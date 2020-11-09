from Components.MetaMaterial import MetaMaterial
from Components.Component import Component
class ABCDSimulator:

    def __init__(self, R, L0, G, C0, L, C, cell_len, cells_num):
        self._material = MetaMaterial(R, L0, G, C0, L, C, cell_len, cells_num, Component.SERIES)

    def run(self):
        # Create a frequency range, loop over it: set the material frequency,
        # get its ABCD matrix, extract s11, s12 and plot
        pass