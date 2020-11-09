import numpy as np

class Component:
    # Connection types
    SERIES = 0
    SHUNT = 1

    def __init__(self, connection_type):
        self._connection_type = connection_type

    @property
    def impedance(self):
        return

    @property
    def input_freq(self):
        return self._input_freq

    @property
    def ABCD(self):
        if self._connection_type == self.SERIES:
            return Component.get_series_ABCD(self.impedance)
        else:
            return Component.get_shunt_ABCD(self.impedance)

    @input_freq.setter
    def input_freq(self, omega):
        self._input_freq = omega

    @staticmethod
    def get_series_ABCD(impedance):
        return np.array([1, impedance], [0, 1])

    @staticmethod
    def get_shunt_ABCD(impedance):
        return Component.get_series_ABCD(impedance).T