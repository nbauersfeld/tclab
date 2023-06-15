
# 2023-06-14
import tensorflow as tf
tf.keras.backend.set_floatx('float64')

from scipy import constants
import numpy as np

# ode batch helper
# builds y0, t, u, y, i per batch
# stepwise data lookup
class HelperODE():

    @staticmethod
    def batch_(t, u, y, batch_time, batch_size, data_size):

        batch_i = np.random.choice(np.arange(data_size - batch_time, dtype=np.int64), batch_size, replace=False)
        temp_y = y.numpy()
        batch_y0 = tf.convert_to_tensor(temp_y[batch_i])
        batch_t = t[:batch_time]
        batch_y = tf.stack([temp_y[batch_i+1] for _ in range(batch_time)], axis=0)

        if u is not None:
            temp_u = u.numpy()
            batch_u = tf.convert_to_tensor(temp_u[batch_i])
        else:
           batch_u = None

        return batch_y0, batch_t, batch_u, batch_y, batch_i

# neural ode declaration
# one dense layer with 50 neurons and tanh activation
# one output layer with 1 neuron
class NeuralODE(tf.keras.Model):

  def __init__(self, *args, **kwargs):

    super().__init__(*args, **kwargs)

    self.func = tf.keras.Sequential([
            tf.keras.layers.Dense(50,
                                  activation="tanh",
                                  kernel_initializer=tf.keras.initializers.GlorotNormal(seed=42)),
            tf.keras.layers.Dense(1,
                                  kernel_initializer=tf.keras.initializers.GlorotNormal(seed=42))
        ],name="n-ode")

  def call(self, t, y):

    y = tf.reshape(y,[-1,1])
    y = self.func(y)
    y = tf.convert_to_tensor(y[0,0],dtype=tf.float64)

    return y

class NeuralPIN(tf.keras.Model):

  def __init__(self, *args, **kwargs):

    super().__init__(*args, **kwargs)

    self.func = tf.keras.Sequential([
            tf.keras.layers.Dense(50,
                                  activation="tanh",
                                  kernel_initializer=tf.keras.initializers.GlorotNormal(seed=42)),
            tf.keras.layers.Dense(1,
                                  kernel_initializer=tf.keras.initializers.GlorotNormal(seed=42))
        ],name="n-pin")

  def call(self, t, y):    
    shape = tf.shape(y)
    y = tf.reshape(y,[-1,1])
    y = self.func(y)
    y = tf.convert_to_tensor(y,dtype=tf.float64)
    y = tf.reshape(y, shape)
    return y

# physical parameters for energy balance equation
# https://apmonitor.com/pdc/index.php/Main/ArduinoModeling
# with Q pickup by u_
class ParamsODE():

    # energy balance
    K0 = 273.15
    Ta = 23.0         # K

    m = 4.0/1000.0    # kg
    cp = 0.5*1000.0   # J/kg-K

    A = 12.0/100.0**2 # Area in m^2

    U = 10.0          # W/m^2-K

    eps = 0.9         # Emissivity
    sigma = constants.Stefan_Boltzmann

    alpha = 0.01      # W / % heater

    # fodpt
    K = 0.861933      # gain
    tau = 186.772334  # time constant
    theta = 14        # dead time
    y0 = 0

    # Q setting
    t_delay = 20      #
    t_up = 100        #
    t_down = 240      #

    t_num = t_delay + t_up + t_down

# surrogate model itself
#
#
class SurrogateODE(tf.keras.Model):

    params = None
    mode = None

    def __init__(self, params: ParamsODE, mode="balance_", **kwargs):
        super().__init__(**kwargs)
        self.params = params
        self.mode = mode

    def u_(self,t):

        # pick Q setting
        # actual time value
        v = tf.convert_to_tensor([t], dtype=tf.float64)

        # low and high limit of Q range where 100.
        t_low = int(v/self.params.t_num)*self.params.t_num + self.params.t_delay
        t_high = int(v/self.params.t_num)*self.params.t_num + self.params.t_delay + self.params.t_up

        q = 100. if (v>=t_low and v<=t_high) else 0.

        return tf.convert_to_tensor([q], dtype=tf.float64)

    def balance_(self,t,y,u=None):

        # energy balance representation

        T = y
        Q = self.u_(t) if u is None else u

        # balance
        k = (1.0/(self.params.m*self.params.cp))

        T1 = self.params.U*self.params.A*(self.params.Ta - T)
        T4 = self.params.eps*self.params.sigma*self.params.A*(self.params.Ta**4-T**4)

        dTdt = k * (T1 + T4 + self.params.alpha*Q)

        return tf.convert_to_tensor(dTdt, dtype=tf.float64)

    def call(self,t,y,u=None):
        return getattr(self, self.mode)(t,y,u)
    
    @staticmethod
    def linear_fit_(m,t,y0):
        m_ = m.numpy()
        t_ = t.numpy()
        y0_ = y0.numpy()
        return tf.convert_to_tensor((m_.T*t_).T + y0_)

