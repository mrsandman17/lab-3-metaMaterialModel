from Components.Circuit import Circuit
from Components.Component import Component

from Components.TransmissionLine import TransmissionLine


class SingleTransition(Circuit):
    """
    Represents a single cell of a metaMaterial
    """

    def __init__(self, R, L0, G, C0, L, C, length, connection_type):
        super().__init__(connection_type)
        self.add_component(TransmissionLine(R, L0, G, C0, (length / 2), Component.SERIES))

