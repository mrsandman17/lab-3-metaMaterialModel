from Components.Circuit import Circuit
from Components.Resistor import Resistor
from Components.Capacitor import Capacitor
from Components.Inductor import Inductor
from Components.Component import Component
import numpy as np

class TransmissionLine(Circuit):
    """
    A transmission line, This circuit has a unique ABCD matrix
    """

    def __init__(self, R, L0, G, C0, length, connection_type):
        super().__init__(connection_type)
        self._length = length
        self.add_component(Resistor(R, Component.SERIES))
        self.add_component(Inductor(L0, Component.SERIES))
        self.add_component(Resistor(G, Component.SHUNT))
        self.add_component(Capacitor(C0, Component.SHUNT))

    @property
    def gamma(self):
        return np.sqrt((self._components[0].impedance + self._components[1].impedance) *
                       (self._components[2].impedance + self._components[3].impedance))
    @property
    def ABCD(self):
        param = self.gamma * self._length
        return np.array([[np.cos(param), 1j * self.impedance() * np.sin(param)],
                        [(1j / self.impedance()) * np.sin(param), np.cos(param)]])

    def impedance(self):
        return np.sqrt(np.divide((self._components[0].impedance + self._components[1].impedance),
                                 (self._components[2].impedance + self._components[3].impedance)))