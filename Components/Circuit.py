import numpy as np
from Components.Component import Component

class Circuit(Component):
    """
    An electric circuit, can hold multiple components
    """
    def __init__(self, connection_type):
        super().__init__(connection_type)
        self._components = []

    def add_component(self, component):
        self._components.append(component)

    @property
    def ABCD(self):
        """
        :return: The ABCD matrix of the circuit,
        it is the product of all the ABCD matrices of the components
        """
        abcd = np.array([[1, 0], [0, 1]])
        for component in reversed(self._components):
            temp = component.ABCD
            abcd = abcd @ temp
        return abcd

    @Component.input_freq.setter
    def input_freq(self, omega):
        """
        Sets all the components input frequency to omega
        :param omega: the new input frequency
        """
        for component in self._components:
            component.input_freq = omega




