
import matplotlib.pyplot as plt
from pandas import DataFrame

import tclab
import numpy as np
import pandas as pd
import time

class _tclab:

    @staticmethod
    def status():        
        with tclab.TCLab() as model:
            status = [model.Q1(),model.Q2(),model.T1,model.T2,model.LED()]
            print(status)

    @staticmethod
    def _4_data(cycles=1):
      
        t_delay = 20
        t_up = 100
        t_down = 240

        t_num = t_delay + t_up + t_down
        
        dns = 1e9

        tt = np.linspace(0,t_num,t_num,endpoint=False)

        data = []

        with tclab.TCLab() as model:
                        
            for c in range(cycles):

                q1 = 0; model.Q1(q1)
                q2 = 0; model.Q2(q2)
                
                for t in tt:
                    
                    tns = time.time_ns()

                    q1_ = q1
                    q1 = 0. if (t<=t_delay) or (t>t_up) else 1.
                    if q1_!=q1: model.Q1(q1*100)
                            
                    data.append([c,t,tns,q1*100,q2*100,model.T1,model.T2])
                    
                    while(time.time_ns()-tns < dns): pass;
        
        return pd.DataFrame(data,columns=["Cycle","Time","Time(ns)","Q1","Q2","T1","T2"])
    
    @staticmethod
    def _q_data(q):
              
        dns = 1e9
        t_num = len(q)

        tt = np.linspace(0,t_num,t_num,endpoint=False,dtype=np.int64)

        data = []

        with tclab.TCLab() as model:

            q1 = q[0]; model.Q1(q1*100)
            q2 = 0; model.Q2(q2)
            
            for t in tt:
                
                tns = time.time_ns()

                if q[t]!=q1:                     
                    q1 = q[t]                    
                    print(f"--- switch Q to {q1*100} at {t}")
                    model.Q1(q1*100)                    
                       
                data.append([t,tns,q1*100,q2*100,model.T1,model.T2])
                
                while(time.time_ns()-tns < dns): pass;
        
        return pd.DataFrame(data,columns=["Time","Time(ns)","Q1","Q2","T1","T2"])

class _tclabutils:

    @staticmethod
    def noise_(y, snr=100):
                
        y_ = y.copy()
        sig_avg = np.mean(y_)
        sig_db = 10 * np.log(sig_avg)

        noi_avg_db = sig_db - snr
        noi_avg = 10 ** (noi_avg_db / 10.)

        noi_mean = 0.
        y_noi = np.random.normal(noi_mean, np.sqrt(noi_avg), len(y_))
        y_ += y_noi
        
        return y_
    
    @staticmethod
    def plot(t,u,y,t_=None,u_=None,y_=None,e_=None,title=""):

        if t_ is None: t_ = t.copy()

        plt.rcParams["font.size"] = 8
        plt.rcParams["figure.dpi"] = 80
        plt.rcParams["lines.linewidth"] = .8

        ncols,nrows = 1,1
        nwidth,nheight = 16,4

        fig, sp = plt.subplots(nrows=nrows,ncols=ncols,figsize=[nwidth*ncols,nheight*nrows],dpi=plt.rcParams["figure.dpi"])
        fig.subplots_adjust(right=0.75)
        
        if e_ is not None: 
            ax = [sp,sp.twinx(),sp.twinx()]
        else:
            ax = [sp,sp.twinx()]

        ax[0].set_title("%s"%(title),x=0,ha="left")

        if y_ is not None: 
            ax[0].plot(t,y,"-",label="y(org)",color="black")
            ax[0].plot(t_,y_,":",label="y(fit))",color="green")
        else:
            ax[0].plot(t,y,":",label="y(org)",color="black")
        ax[0].set_xlabel("t(s)")
        ax[0].set_ylabel("output(y)")

        ax[0].legend(bbox_to_anchor=(.1, 0.97))
        
        if u_ is not None: 
            ax[1].plot(t,u,":",label="u",color="gray")
            ax[1].plot(t_,u_,"-",label="u(fit)",color="gray")
        else:
            ax[1].plot(t,u,":",label="u",color="gray")
        ax[1].set_ylabel("input(u)")
        ax[1].spines.right.set_position(("axes", 1.0))
        
        if e_ is not None: 
            ax[2].plot(t_,e_.cumsum(),label="e(y,ym,cum)",color="red")
            ax[2].set_ylabel("error")
            ax[2].spines.right.set_position(("axes", 1.06))

        plt.show()
        plt.close()

    @staticmethod
    def error(data: DataFrame):

        plt.rcParams["font.size"] = 8
        plt.rcParams["figure.dpi"] = 80
        plt.rcParams["lines.linewidth"] = .8

        ncols,nrows = 1,1
        nwidth,nheight = 12,4

        fig, ax = plt.subplots(nrows=nrows,ncols=ncols,figsize=[nwidth*ncols,nheight*nrows],dpi=plt.rcParams["figure.dpi"])
        fig.subplots_adjust(right=0.75)

        ax.set_title("error comparison",x=0,ha="left")

        data.plot(kind='box',ax=ax)

        ax.set_xticklabels(data.columns)

        plt.show()
        plt.close()


if __name__=="__main__":

    data = _tclab._4_data()
    frame = pd.DataFrame(data,columns=["Time","Time(ns)","Q1","Q2","T1","T2"])
    
    print(frame["Time(ns)"].diff())