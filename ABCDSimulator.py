from Components.MetaMaterial import MetaMaterial
from Components.Component import Component

import numpy as np
import matplotlib.pyplot as plt

class ABCDSimulator:

    def __init__(self, R, L0, G, C0, L, C, cell_len, cells_num, start_frequency, end_frequency, V_end, I_end):
        self._material = MetaMaterial(R, L0, G, C0, L, C, cell_len, cells_num, Component.SERIES)
        self._start_frequency = start_frequency
        self._end_frequency = end_frequency
        self._V_end = V_end
        self._I_end = I_end

    def run(self):
        """
        Create a frequency range, loop over it: set the material frequency,
        get its ABCD matrix, extract s11, s12 and plot
        :return:
        """

        frequency_range = np.arange(self._start_frequency, self._end_frequency)
        transmission_coefficients = np.empty((self._end_frequency - self._start_frequency))
        reflection_coefficients = np.empty((self._end_frequency - self._start_frequency))
        i = 0
        for frequency in frequency_range:
            self._material.input_freq = frequency
            abcd_matrix = self._material.ABCD
            end_vector = np.array([self._V_end, self._I_end]).T
            start_vector = abcd_matrix.dot(end_vector)
            transmission_coefficients[i] = self.get_transmission_coefficient(start_vector)
            reflection_coefficients[i] = self.get_reflection_coefficient(start_vector)
            i = i + 1
        plt.plot(frequency_range, transmission_coefficients)
        plt.ylabel('S11')
        plt.xlabel('Frequency')
        plt.plot(frequency_range, reflection_coefficients)
        plt.show()


    def get_transmission_coefficient(self, start_vector):
        V_start = start_vector[0]
        I_start = start_vector[1]
        end_impedance = self._V_end / self._I_end
        return (V_start + end_impedance * I_start)

    def get_reflection_coefficient(self, start_vector):
        V_start = start_vector[0]
        I_start = start_vector[1]
        end_impedance = self._V_end / self._I_end
        return ((V_start + end_impedance * I_start) / (V_start - end_impedance * I_start))