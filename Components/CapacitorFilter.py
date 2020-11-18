from Components.Circuit import Circuit
from Components.Component import Component
from Components.Resistor import Resistor
from Components.Capacitor import Capacitor
from Components.TransmissionLine import TransmissionLine
from Components.Inductor import Inductor

class CapacitorFilter(Circuit):
    """
    Represents a single cell of a metaMaterial
    """

    def __init__(self, R, L0, G, C0, L, C, length, connection_type):
        super().__init__(connection_type)
        # self.add_component(Resistor(8.56, Component.SERIES))
        # self.add_component(Resistor(141.8, Component.SHUNT))
        # self.add_component(Resistor(8.56, Component.SERIES))
        # self.add_component(Capacitor(C, Component.SERIES))
        # self.add_component(Inductor(L, Component.SERIES))
        # T= TransmissionLine(R, L0, G, C0, (length / 2), Component.SERIES)
        # T.input_freq = 100
        # print(T.impedance)
        # print(T._components[2].impedance)
        self.add_component(TransmissionLine(0, 291 * 10**-9, 0, 116* 10^-12, (0.00381), Component.SERIES))
        # self.add_component(TransmissionLine(4*R, 2*L0, 3*G, C0, (length / 2), Component.SERIES))
