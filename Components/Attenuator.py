from Components.Circuit import Circuit
from Components.Component import Component
from Components.Resistor import Resistor


class Attenuator(Circuit):
    """
    Represents a single cell of a metaMaterial
    """

    def __init__(self, R, L0, G, C0, L, C, length, connection_type):
        super().__init__(connection_type)
        self.add_component(Resistor(8.56, Component.SERIES))
        self.add_component(Resistor(141.8, Component.SHUNT))
        self.add_component(Resistor(8.56, Component.SERIES))
