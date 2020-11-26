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

    # @property
    # def ABCD(self):
    #     """
    #     :return: The ABCD matrix of the circuit,
    #     it is the product of all the ABCD matrices of the components
    #     """
    #     abcd = np.array([[1, 0], [0, 1]])
    #     for component in (self._components):
    #         temp = component.ABCD
    #         abcd = np.matmul(abcd, temp)
    #     return abcd
    @property
    def ABCD(self):
        """
        :return: The ABCD matrix of the circuit,
        it is the product of all the ABCD matrices of the components
        """

        abcd = self._components[0].ABCD
        abcd_f = np.empty(abcd.shape, dtype=np.complex)
        for i in range(1, len(self._components)):
            next = self._components[i].ABCD
            abcd_f[0,0,:] = abcd[0,0,:] * next[0,0,:] + abcd[0,1,:] * next[1,0,:]
            abcd_f[0,1,:] = abcd[0,0,:] * next[0,1,:] + abcd[0,1,:] * next[1,1,:]
            abcd_f[1,0,:] = abcd[1,0,:] * next[0,0,:] + abcd[1,1,:] * next[1,0,:]
            abcd_f[1,1,:] = abcd[1,0,:] * next[0,1,:] + abcd[1,1,:] * next[1,1,:]
            abcd = np.copy(abcd_f)

        return abcd

    @Component.input_freq.setter
    def input_freq(self, omega):
        """
        Sets all the components input frequency to omega
        :param omega: the new input frequency
        """
        for component in self._components:
            component.input_freq = omega




