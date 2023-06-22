
from scipy import constants 
from scipy import integrate 
import numpy as np

# model

class energy_:
    
    K0 = 273.15
    Ta = 23.0+K0  # K

    m = 4.0/1000.0    # kg
    cp = 0.5*1000.0   # J/kg-K    
        
    A = 12.0/100.0**2 # Area in m^2    

    U = 10.0          # W/m^2-K

    eps = 0.9         # Emissivity
    sigma = constants.Stefan_Boltzmann

    alpha = 0.01      # W / % heater

    @staticmethod    
    def compute_(x,t, Q,Ta,P):                    
        # arguments
        # x     = temperature state
        # t     = time stamp
        # Q     = heater %
        # Ta    = ambient temperature
        # P     = parameter set        
        T = x[0]
        dTdt = (1.0/(P.m*P.cp))*(P.U*P.A*(Ta-T) + P.eps*P.sigma*P.A*(Ta**4-T**4) + P.alpha*Q)
        return dTdt
    
    @staticmethod
    def estimate_(t,u,y,step=1):

        model = energy_()

        Ta = model.Ta

        rc = [[t[0],u[0],y[0],0.]]
        i = 0
        for i in range(1,len(t),step):
                        
            u_ = u[i-1]

            to = [t[i]-t[i-1]]

            y0 = y[i-1]+model.K0                       
            y_ = integrate.odeint(func=model.compute_, y0=y0, t=to, args=(u_,Ta,model))
            y_ = y_.flatten()[0] - model.K0
            e_ = y[i] - y_

            rc.append([t[i],u_,y_,e_])

        rc = np.array(rc)
        return rc[:,0],rc[:,1],rc[:,2],rc[:,3]