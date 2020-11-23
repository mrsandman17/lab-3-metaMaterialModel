from Components.Circuit import Circuit
from Components.Component import Component
from Components.Inductor import Inductor
from Components.Capacitor import Capacitor
from Components.TransmissionLine import TransmissionLine

class Cell(Circuit):
    """
    Represents a single cell of a metaMaterial
    """

    def __init__(self, R, L0, G, C0, L, C, length, connection_type):
        super().__init__(connection_type)
        self.add_component(TransmissionLine(R, L0, G, C0, (length / 2), Component.SERIES))
        self.add_component(Inductor(L, Component.SHUNT))
        self.add_component(TransmissionLine(R, L0, G, C0, (length / 2), Component.SERIES))
        self.add_component(Capacitor(C, Component.SERIES))

    @property
    def gamma(self):
        return self._components[0].gamma