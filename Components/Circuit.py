import numpy as np
from Components.Component import Component



class Circuit(Component):


    def __init__(self, connection_type):
        super().__init__(connection_type)
        self._components = []

    def add_component(self, component):
        self._components.append(component)

    @property
    def ABCD(self):
        abcd = np.array([1, 0], [0, 1])
        for component, connection_type in self._components:
            abcd = abcd.dot(component.ABCD)
        return abcd

    @Component.input_freq.setter
    def input_freq(self, omega):
        for component in self._components:
            component.input_freq = omega




