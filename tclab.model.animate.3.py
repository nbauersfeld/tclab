
# @version 2023-06-17

import os
import pandas as pd
import numpy as np

from _animate import Animation_
from _helpers import Helpers_

import matplotlib.pyplot as plt
import matplotlib as mpl

def monitor_data_(name):
    """
    load monitored data and loss
    """
    monitor_path = os.path.join(os.getcwd(),"data","tclab.%s.mo"%(name))
    data = pd.read_pickle(os.path.join(monitor_path,"data.monitor.pickle"))
    loss = pd.read_pickle(os.path.join(monitor_path,"loss.monitor.pickle"))    
    return data, loss

def animate_data_(t,u,y,data,loss,
                  n_features=1,
                  ylim=[0,100],steps=10,prefix=None,title="",icon=None,grab=False):
    
    """
    animate
    """
    def mpl_figure_(fig,icon=None,color=[255,255,255]):
        fm = plt.get_current_fig_manager()
        if icon is not None: fm.window.wm_iconbitmap(icon)
        fig.patch.set_facecolor(np.array(color)/255.)

    def mpl_grab_(fig,index,prefix):
        path_ = os.path.join(os.getcwd(),"media",prefix)
        if not os.path.exists(path_): os.mkdir(path_)
        name_ = os.path.join(path_,f"{index:04d}.png")
        fig.savefig(name_)
    
    plt.rcParams["font.size"] = 8
    plt.rcParams["figure.dpi"] = 80
    mpl.rcParams['toolbar'] = 'None'

    ncols,nrows = 1,1
    nwidth,nheight = 16,6

    fig, ax = plt.subplots(nrows=nrows,ncols=ncols,figsize=[nwidth*ncols,nheight*nrows],
                            dpi=plt.rcParams["figure.dpi"],
                            num=f"{title}")
    
    ay2 = ax.twinx()
    ax2 = ay2.twiny()
    ax2.set_yscale("log")

    ax2.set_xlabel("iteration")
    ay2.set_ylabel("$loss$")

    ay3 = ax.twinx()
    ay3.set_visible(False)
    
    ax.set_xlabel("time")
    ax.set_ylabel("$T(°C)$")

    mpl_figure_(fig,icon=icon)

    l_ = loss['loss']   
    l_loss = ax2.plot(l_,":",color="orange",alpha=0.6,lw=0.8,animated=True)[0]
    l_step = ax2.axvline(x=0,color="black",linestyle=":",linewidth=0.8,animated=True)

    ax.set_ylim(ylim)   

    p_anot = ax.annotate("loading...",
                       xy=(0,1),
                       xycoords="axes fraction",xytext=(10,-10),textcoords="offset points",
                       color="black",
                       animated=True)

    p_base,p_pred,u_base = [],[],[]
    for f in range(n_features):
        ys = y[:,f].flatten()
        p_base.append(ax.plot(t,ys,":",color="navy",lw=0.8,animated=True)[0])
        p_pred.append(ax.plot(t,ys,".",color="red",ms=4,animated=True)[0])    
        u_base.append(ay3.fill_betweenx(u[:,f],x1=t,color="grey",alpha=.1,zorder=-1,
                                edgecolor="white",
                                interpolate=True,
                                animated=True))
    
    A = Animation_(fig.canvas, p_base+p_pred+u_base+[l_step, l_loss, p_anot])

    plt.show(block=False)

    A.update()

    if grab: mpl_grab_(fig,index=0,prefix=prefix)
    plt.pause(1)

    for j in range(0,data.shape[0],steps):
        
        i = 1
        ii = data.loc[j,'index']
        batch_size = len(ii)
        t_ = t[ii]

        for f in range(n_features):
            yy = data.loc[j,f'y_pred[{f}]']
            y_ = yy[-i*batch_size:len(yy)-(i-1)*batch_size]
            p_pred[f].set_data(t_,y_)

        p_anot.set_text(f"step {(j+1):03d}")
        l_step.set_xdata([j])

        A.update()

        if grab: mpl_grab_(fig,index=j+1,prefix=prefix)
        plt.pause(.1)

    plt.ioff()
    plt.show()

def animate_(t,u,y,
             n_features=1,
             ylim=[0,100],
             model="",mode="",title="",steps=10,icon=None):

    title = f"{title} - {model}"
    
    if 2==n_features:
        prefix = f"{model}.{mode}.{n_features}"
    else:
        prefix = f"{model}.{mode}"

    data,loss = monitor_data_(prefix)

    if 1==n_features:
        data.columns = ['index'] + [f'{c}[0]' for i,c in enumerate(data.columns[1:])]
        y = y[:,np.newaxis]
        u = u[:,np.newaxis]

    animate_data_(t,u,y,data,loss,
                  n_features=n_features,
                  ylim=ylim,prefix=prefix,title=title,steps=steps,icon=icon,grab=True)

if __name__=="__main__":

    os.system('cls')

    n_features = 1

    icon = os.path.join(os.getcwd(),"media","icon.ico")

    model = 'model.4.6'
    fname = os.path.join(os.getcwd(),"data","tclab.%s.csv"%(model))

    if 2==n_features:
        t,u,y,data_size = Helpers_.load2_(fname)  
    else:
        t,u,y,data_size = Helpers_.load_(fname)  

    # t,u,y = t.flatten(),u.flatten(),y.flatten()

    print(f"data {model:>10}")
    print(f"size {data_size:>10}")
    print(f"feat {n_features:>10}")

    mode,title = "node","n-ode"
    animate_(t,u,y,n_features=n_features,ylim=[0,100],model=model,mode=mode,title=title,steps=20,icon=icon)

    #mode,title = "pinn","n-pin"
    #animate_(t,u,y,n_features=n_features,ylim=[10,60],model=model,mode=mode,title=title,steps=100,icon=icon)




