import numpy as np
import pandas as pd

class Helpers_():

    @staticmethod
    def rectangle_impulse_(size, width=120, heating=40, cooling=80):
        
        """
        prepare rectangle impulse
        """

        rc = np.zeros((size,))

        low,high = 20,0
        toggle = 0

        wmin = 0

        while high < size:

            high = low + np.random.randint(wmin,wmin+width)
            rc[low:high] = toggle * np.random.uniform(0.2,1)
            toggle = 0 if toggle==1 else 1
            wmin = heating if toggle==1 else cooling
            low = high

        return rc
    
    @staticmethod
    def tfload_(fname):

        import tensorflow as tf

        """
        read a tclab csv file
        return t,u,y and size of data
        """

        data = pd.read_csv(fname)

        for key in ['Time','Time(ns)']: data[key] = data[key].astype(np.int64)
        for key in ['Q1','Q2','T1','T2']: data[key] = data[key].astype(np.float64)

        # time
        t = data["Time(ns)"].to_numpy().astype(np.int64)
        t = ((t-t[0])/1e9).astype(np.int64)
        # input
        u = data["Q1"].to_numpy()
        # output
        y = data["T1"].to_numpy()

        data_size = len(y)

        t = tf.convert_to_tensor(t,dtype=tf.float64)
        u = tf.convert_to_tensor(u,dtype=tf.float64)
        y = tf.convert_to_tensor(y,dtype=tf.float64)

        return t,u,y, data_size    
    
    @staticmethod
    def load_(fname):

        """
        read a tclab csv file
        return t,u,y and size of data
        """

        data = pd.read_csv(fname)

        for key in ['Time','Time(ns)']: data[key] = data[key].astype(np.int64)
        for key in ['Q1','Q2','T1','T2']: data[key] = data[key].astype(np.float64)

        # time
        t = data["Time(ns)"].to_numpy().astype(np.int64)
        t = ((t-t[0])/1e9).astype(np.int64)
        # input
        u = data["Q1"].to_numpy()
        # output
        y = data["T1"].to_numpy()

        data_size = len(y)

        return t,u,y, data_size        

if __name__=="__main__":

    print(Helpers_.rectangle_impulse_(60*120, 360))