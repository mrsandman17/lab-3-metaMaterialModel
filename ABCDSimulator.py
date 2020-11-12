from Components.MetaMaterial import MetaMaterial
from Components.Component import Component

import numpy as np
import matplotlib.pyplot as plt

POINTS_NUM = 10000

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
        freq_distance = (self._end_frequency - self._start_frequency) / POINTS_NUM
        frequency_range = np.arange(self._start_frequency, self._end_frequency, freq_distance)
        transmission_coefficients = np.empty(POINTS_NUM)
        reflection_coefficients = np.empty(POINTS_NUM)
        s11_arr = np.empty(POINTS_NUM)
        s21_arr = np.empty(POINTS_NUM)
        i = 0
        for frequency in frequency_range:
            self._material.input_freq = frequency
            abcd_matrix = self._material.ABCD
            # end_vector = np.array([self._V_end, self._I_end]).T
            # start_vector = abcd_matrix @ end_vector
            # transmission_coefficients[i] = self.get_transmission_coefficient(start_vector)
            # reflection_coefficients[i] = self.get_reflection_coefficient(start_vector)
            s11_arr[i] = np.absolute(self.get_s11(abcd_matrix))
            s21_arr[i] = np.absolute(self.get_s21(abcd_matrix))
            i = i + 1
        fig, axs = plt.subplots(2)
        axs[0].plot(frequency_range, s11_arr)
        axs[0].set_title('S11')
        axs[1].set_title('S21')
        axs[1].plot(frequency_range, s21_arr)
        plt.show()

    def get_s11(self, abcd_matrix):
        A = abcd_matrix[0, 0]
        B = abcd_matrix[0, 1]
        C = abcd_matrix[1, 0]
        D = abcd_matrix[1, 1]
        Z_end = self._V_end / self._I_end
        return (A+B / Z_end - C * Z_end - D) / (A + B / Z_end + C * Z_end + D)

    def get_s21(self, abcd_matrix):
        A = abcd_matrix[0, 0]
        B = abcd_matrix[0, 1]
        C = abcd_matrix[1, 0]
        D = abcd_matrix[1, 1]
        Z_end = self._V_end / self._I_end
        return 2 / (A + B / Z_end + C * Z_end + D)

    def get_transmission_coefficient(self, start_vector):
        V_start = start_vector[0]
        I_start = start_vector[1]
        end_impedance = self._V_end / self._I_end
        start_impedence = V_start / I_start
        # return np.absolute((2 * start_impedence) / (start_impedence + end_impedance))
        return np.absolute((V_start + end_impedance * I_start) / 2)
        # return 1 - self.get_reflection_coefficient(start_vector)


    def get_reflection_coefficient(self, start_vector):
        V_start = start_vector[0]
        I_start = start_vector[1]
        end_impedance = self._V_end / self._I_end
        start_impedence = V_start / I_start
        # return np.absolute((start_impedence - end_impedance) / (start_impedence + end_impedance))
        return np.absolute(((V_start + end_impedance * I_start) / (V_start - end_impedance * I_start)))