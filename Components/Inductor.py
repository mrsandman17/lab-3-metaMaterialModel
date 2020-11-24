from Components.Component import Component
import numpy as np

class Inductor(Component):
    def __init__(self, inductance, connection_type):
        super().__init__(connection_type)
        self._inductance = inductance

    @property
    def impedance(self):
        return (1j * 2 * np.pi * self.input_freq * self._inductance)