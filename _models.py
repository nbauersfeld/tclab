"""
@version 2023-07-02
"""
import tensorflow as tf
tf.keras.backend.set_floatx('float64')

import tfdiffeq

from scipy import constants
import numpy as np

class HelperODE():
    """
    ode batch helper
    builds y0, t, u, y, i per batch
    stepwise data lookup
    """
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
    
    @staticmethod
    def test_(device,model,t,u,y,data_size,name,verbose=0):
    
        batch_time = 2
        batch_due = 0
        batch_size = int((data_size-batch_due)/batch_time)
        
        with tf.device(device):
            
            batch_y0,batch_t,_, batch_y,batch_i = HelperODE.batch_(
                t, None, y, 
                batch_size=batch_size, 
                batch_time=batch_time, 
                data_size=data_size)
            
            # against model test
            y_test = tfdiffeq.odeint(model, batch_y0, batch_t, method="dopri5")
            l_test = tf.reduce_mean(tf.square(batch_y - y_test))
            y_test = y_test.numpy().flatten() 

            # energy balance surrogate compare
            params = ParamsODE()
            params.alpha = 0.
            balan = SurrogateODE(params=params)

            y_bala = tfdiffeq.odeint(balan, batch_y0, batch_t)
            l_bala = tf.reduce_mean(tf.square(batch_y - y_bala))
            y_bala = y_bala.numpy().flatten()

        if verbose:
            print(f"{name}")
            print(f"data size {data_size}; batch time {batch_time} due {batch_due} size {batch_size}")
            print(f"loss test {l_test:.6f} and surrogate {l_bala:.6f}")

        return dict(
            t=t,u=u,y=y,data_size=data_size,
            batch_time=batch_time,batch_due=batch_due,batch_size=batch_size,
            y_test=y_test,l_test=l_test,
            y_bala=y_bala,l_bala=l_bala,
            batch_i=batch_i
        )
    
    @staticmethod
    def plot_(ts,us,ys,yy,loss,indizes,size,name,model_name,dpi=80):

        import matplotlib.pyplot as plt

        plt.rcParams["font.size"] = 8
        plt.rcParams["figure.dpi"] = dpi
        plt.rcParams["lines.linewidth"] = .8

        marker_size = 1

        ncols,nrows = 1,2
        nwidth,nheight = 16,4

        fig, axx = plt.subplots(nrows=nrows,ncols=ncols,figsize=[nwidth*ncols,nheight*nrows],dpi=plt.rcParams["figure.dpi"])
        fig.subplots_adjust(right=0.75)

        # model test

        ax = axx[0]

        ax.plot(ts,ys,":",color="grey",label="y(%s)"%(name))

        i_ = indizes
        a_ = np.argsort(i_)
        t_ = ts[i_[a_]]
        y_ = yy[0][-size:][a_]

        ax.plot(t_,y_,':o',ms=marker_size,label="y(test)",color="green")

        ax.legend()
        ax.set_title(f"test:{model_name}:batch {size:d}:loss {loss[0]:.6f}",x=0,ha="left")

        ax = ax.twinx()
        ax.plot(ts,us,":",label="u",color="gray")

        # balance equivalence

        ax = axx[1]

        ax.plot(ts,ys,":",color="grey",label="y(%s)"%(name))

        i_ = indizes
        a_ = np.argsort(i_)
        t_ = ts[i_[a_]]
        y_ = yy[1][-size:][a_]

        ax.plot(t_,y_,':o',ms=marker_size,label="y(surr)",color="red")

        ax.legend()
        ax.set_title(f"surrogate:{model_name}:batch {size:d}:loss {loss[1]:.6f}",x=0,ha="left")

        ax = ax.twinx()
        ax.plot(ts,us,":",label="u",color="gray")

        for ax in axx.ravel():
            ax.set_xlabel("time(s)")
            ax.set_ylabel("T(°C)")

        plt.show()
        plt.close()

class NeuralODE(tf.keras.Model):
    """
    neural ode declaration
    one dense layer with 50 neurons and tanh activation
    one output layer with 1 neuron
    """
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.func = tf.keras.Sequential([
                tf.keras.layers.Dense(50, input_shape=(1,),
                                    activation="tanh",
                                    kernel_initializer=tf.keras.initializers.GlorotNormal(seed=42)),
                tf.keras.layers.Dense(1,
                                    kernel_initializer=tf.keras.initializers.GlorotNormal(seed=42))
            ],name="n-ode")

    def call(self, t, y):
        # call serially
        y = tf.reshape(y,[-1,1])
        y = self.func(y)
        y = tf.convert_to_tensor(y[0,0],dtype=tf.float64)
        return y
    
class NeuralODE2(tf.keras.Model):
    """
    neural ode declaration; 2d implementation
    one dense layer with 50 neurons and tanh activation
    one output layer with 2 neuron
    """
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.func = tf.keras.Sequential([
                tf.keras.layers.Dense(50,
                                    activation="tanh",
                                    kernel_initializer=tf.keras.initializers.GlorotNormal(seed=42)),
                tf.keras.layers.Dense(2,
                                    kernel_initializer=tf.keras.initializers.GlorotNormal(seed=42))
            ],name="n-ode")

    def call(self, t, y):
        # call serially
        y = tf.reshape(y,[-1,2])
        y = self.func(y)
        y = tf.convert_to_tensor(y[0,0],dtype=tf.float64)
        return y

class NeuralPIN(tf.keras.Model):
    """
    neural pin declaration
    one dense layer with 50 neurons and tanh activation
    one output layer with 1 neuron
    """
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

class ParamsODE():
    """
    physical parameters for energy balance equation
    https://apmonitor.com/pdc/index.php/Main/ArduinoModeling
    with Q pickup by u_
    """
    
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

class SurrogateODE(tf.keras.Model):
    """
    surrogate model for tclab by 
    https://apmonitor.com/pdc/index.php/Main/ArduinoModeling
    to compute with ParamsODE
    """
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
    def linear_fit_(m, t, y0):
        """
        fit one step by a line (batch wise)
        m: derivative tensor
        t: time tensor
        y0: offset tensor
        """
        m_ = m.numpy()
        t_ = t.numpy()
        y0_ = y0.numpy()
        return tf.convert_to_tensor((m_.T*t_).T + y0_)

