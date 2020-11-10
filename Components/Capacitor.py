from Components.Component import Component
import numpy as np

class Capacitor(Component):
    def __init__(self, capacitance, connection_type):
        super().__init__(connection_type)
        self._capacitance = capacitance

    @property
    def impedance(self):
        return np.complex(1 / (1j * 2 * np.pi * self.input_freq * self._capacitance))
