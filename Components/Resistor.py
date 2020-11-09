from Components.Component import Component

class Resistor(Component):
    def __init__(self, resistance, connection_type):
        super().__init__(connection_type)
        self._resistance = resistance

    def impedance(self):
        return self._resistance
