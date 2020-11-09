from Components.Component import Component
import numpy as np

class Inductor(Component):
    def __init__(self, inductance, connection_type):
        super().__init__(connection_type)
        self._inductance = inductance

    def impedance(self):
        return np.complex(1j * self.input_freq * self._inductance)