from Components.Circuit import Circuit
from Components.Component import Component
from Components.Resistor import Resistor
from Components.Capacitor import Capacitor
from Components.TransmissionLine import TransmissionLine
from Components.Inductor import Inductor

class Resonator(Circuit):
    """
    Represents a single cell of a metaMaterial
    """

    def __init__(self, R, L0, G, C0, L, C, length, connection_type):
        super().__init__(connection_type)
        self.add_component(Resistor(800.56, Component.SERIES))
        self.add_component(Capacitor(C, Component.SERIES))
        self.add_component(Inductor(L, Component.SERIES))
