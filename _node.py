
import matplotlib.pyplot as plt

class _node:

  @staticmethod
  def plot_(cycles,X_train,y_train,X_test,y_test,y_pred=None):
    
    plt.rcParams["font.size"] = 8
    plt.rcParams["figure.dpi"] = 80
    plt.rcParams["lines.linewidth"] = .8

    ncols,nrows = 1,1
    nwidth,nheight = 16,4

    fig, ax = plt.subplots(nrows=nrows,ncols=ncols,figsize=[nwidth*ncols,nheight*nrows],dpi=plt.rcParams["figure.dpi"])
    fig.subplots_adjust(right=0.75)

    ax2 = ax.twinx()

    # train loops

    num = 360
    for i,cycle in enumerate(cycles):

        imin,imax = (i)*num,(i+1)*num-1

        xx = X_train[imin:imax,0]+cycle
        yy = y_train[imin:imax]
        ax.plot(xx,yy,":",label="cycle %d"%(cycle))

        ax2.plot(xx,X_train[imin:imax,1],":")

    # test and prediction loop

    xx = X_test[:,0]+cycles[-1]
    yy = y_test
    ax.plot(xx,yy,color="orange",label="test")

    ax2.plot(xx,X_test[:,1],":",color="orange")

    if y_pred is not None:
      yy = y_pred
      ax.plot(xx,yy,color="red",label="pred")

    ax.legend()

    plt.show()
    plt.close()

  @staticmethod
  def history_(history):
     
    plt.rcParams["font.size"] = 8
    plt.rcParams["figure.dpi"] = 80
    plt.rcParams["lines.linewidth"] = .8

    ncols,nrows = 1,1
    nwidth,nheight = 16,4

    fig, ax = plt.subplots(nrows=nrows,ncols=ncols,figsize=[nwidth*ncols,nheight*nrows],dpi=plt.rcParams["figure.dpi"])
    fig.subplots_adjust(right=0.75)

    ax.plot(history['loss'])
    ax.set_xlabel('epochs')
    ax.set_ylabel('loss')

    ax = ax.twinx()
    ax.plot(history['mse'],color="red")
    ax.set_ylabel('mse')

    plt.show()
    plt.close()


def test_():
   
  import os
  import pandas as pd
  import numpy as np

  name = "model.4.5"
  fname = os.path.join(os.getcwd(),"data","tclab.%s.csv"%(name))

  data = pd.read_csv(fname)

  for key in ['Cycle','Time','Time(ns)']: data[key] = data[key].astype(np.int64)
  for key in ['Q1','Q2','T1','T2']: data[key] = data[key].astype(np.float64)

  cycles = data["Cycle"].unique()

  print(cycles)

  from sklearn.preprocessing import MinMaxScaler
  from sklearn.model_selection import train_test_split

  from scipy import interpolate

  scaler = MinMaxScaler(feature_range=(0,1))

  Xs = data[["Time","Q1"]].to_numpy()
  ys = data[["T1"]].to_numpy()

  X,y = None,None
  for cycle in cycles:
      
      ii = np.argwhere(data["Cycle"]==cycle).flatten()

      X_ = np.zeros((len(ii),2))

      X_[:,:2] = Xs[ii,:]
      
      t,u = X_[:,0],X_[:,1]
      c = interpolate.CubicSpline(t,u)
      X_[:,1] = c(t)
      X_ = scaler.fit_transform(X_)    
      
      X = np.vstack([X,X_]) if X is not None else X_.copy()

      y_ = ys[ii]
      y_ = scaler.fit_transform(y_)
      y = np.vstack([y,y_]) if y is not None else y_.copy()

  X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=1./len(cycles), shuffle=False)

  from _node import _node

  _node.plot_(cycles,X_train,y_train,X_test,y_test,y_pred=None)  


if __name__ == "__main__":
    test_()    