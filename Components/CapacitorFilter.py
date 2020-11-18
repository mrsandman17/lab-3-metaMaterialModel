from Components.Circuit import Circuit
from Components.Component import Component
from Components.Resistor import Resistor
from Components.Capacitor import Capacitor

class CapacitorFilter(Circuit):
    """
    Represents a single cell of a metaMaterial
    """

    def __init__(self, R,  C, connection_type):
        super().__init__(connection_type)
        self.add_component(Resistor(R, Component.SERIES))
        self.add_component(Capacitor(C, Component.SHUNT))
