import numpy as np

class Component:
    """
    A basic electric component, all components have a connection_type
    **abstract class**
    """

    # Connection types
    SERIES = 0
    SHUNT = 1

    def __init__(self, connection_type):
        self._connection_type = connection_type
        self._input_freq = None

    @property
    def impedance(self):
        return

    @property
    def input_freq(self):
        return self._input_freq

    @property
    def ABCD(self):
        """
        :return: This components ABCD matrix, based on its connection type
        """
        if self._connection_type == self.SERIES:
            return Component._get_series_ABCD(self.impedance)
        else:
            return Component._get_shunt_ABCD(self.impedance)

    @input_freq.setter
    def input_freq(self, omega):
        self._input_freq = omega

    @staticmethod
    def _get_series_ABCD(impedance):
        return np.array([[np.ones(impedance.size), impedance],
                         [np.zeros(impedance.size), np.ones(impedance.size)]],
                        dtype=np.complex)

    @staticmethod
    def _get_shunt_ABCD(impedance):
        return np.array([[np.ones(impedance.size), np.zeros(impedance.size)],
                         [1 / impedance, np.ones(impedance.size)]],
                        dtype=np.complex)
