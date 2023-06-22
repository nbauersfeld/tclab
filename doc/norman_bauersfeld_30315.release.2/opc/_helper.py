from dataclasses import dataclass
import pandas as pd
import numpy as np

@dataclass
class DataItem:

    name = None
    value = None

    def __init__(self, name=None,value=None) -> None:
        self.name = name
        self.value = value

class DataLoad:

    @staticmethod
    def load_(fname):

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