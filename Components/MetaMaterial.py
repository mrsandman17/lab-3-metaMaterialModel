from Components.Circuit import Circuit
from Components.Component import Component
from Components.Cell import Cell

class MetaMaterial(Circuit):
    """
    The MetaMaterial is a series of cells
    """

    def __init__(self, R, L0, G, C0, L, C, cell_len, cells_num, connection_type):
        super().__init__(connection_type)
        for i in range(cells_num):
            self.add_component(Cell(R, L0, G, C0, L, C, cell_len, Component.SERIES))


    @property
    def gamma(self):
        return self._components[0].gamma

