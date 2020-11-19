from Components.MetaMaterial import MetaMaterial
from Components.Component import Component
from Components.CapacitorFilter import CapacitorFilter
from Components.Resonator import Resonator
from Components.SingleTransition import SingleTransition
from Components.Attenuator import Attenuator
import numpy as np
import matplotlib.pyplot as plt

POINTS_NUM = 10000

FONT_SIZE = 16

class ABCDSimulator:

    def __init__(self, R, L0, G, C0, L, C, cell_len, cells_num, start_frequency, end_frequency, V_end, I_end):
        self._material = MetaMaterial(R, L0, G, C0, L, C, cell_len, cells_num, Component.SERIES)
        # self._material = Resonator(R, L0, G, C0, L, C, cell_len, Component.SERIES)
        # self._material = SingleTransition(R, L0, G, C0, L, C, cell_len, Component.SERIES)
        # self._material = Attenuator(R, L0, G, C0, L, C, cell_len, Component.SERIES)
        self._start_frequency = start_frequency
        self._end_frequency = end_frequency
        self._V_end = V_end
        self._I_end = I_end
        self._cells_num = cells_num

    def run(self):
        """
        Create a frequency range, loop over it: set the material frequency,
        get its ABCD matrix, extract s11, s12 and plot
        :return:
        """
        freq_distance = (self._end_frequency - self._start_frequency) / POINTS_NUM
        frequency_range = np.arange(self._start_frequency, self._end_frequency, freq_distance)
        s11_arr = np.zeros(POINTS_NUM, dtype=np.complex)
        s21_arr = np.zeros(POINTS_NUM, dtype=np.complex)
        i = 0
        for frequency in frequency_range:
            self._material.input_freq = frequency
            abcd_matrix = self._material.ABCD
            s11_arr[i] = (self.get_s11(abcd_matrix))
            s21_arr[i] = (self.get_s21(abcd_matrix))
            i = i + 1
        fig, axs = plt.subplots(2)
        title = f'{self._cells_num} Cells'
        fig.suptitle(title, x=0.12, fontSize=FONT_SIZE)
        axs[0].plot(frequency_range, 20 * np.log10(np.absolute(s11_arr)))
        axs[0].set_title('S11 - Reflection')
        axs[1].set_title('S21 - Transmission')
        axs[1].plot(frequency_range, 20 * np.log10(s21_arr))
        axs[1].set_xlabel('Frequency (Hz)')
        plt.show()


    def get_s11(self, abcd_matrix):
        A = abcd_matrix[0, 0]
        B = abcd_matrix[0, 1]
        C = abcd_matrix[1, 0]
        D = abcd_matrix[1, 1]
        Z_end = self._V_end / self._I_end
        return (A + (B / Z_end) - (C * Z_end) - D) / (A + (B / Z_end) + (C * Z_end) + D)

    def get_s21(self, abcd_matrix):
        A = abcd_matrix[0, 0]
        B = abcd_matrix[0, 1]
        C = abcd_matrix[1, 0]
        D = abcd_matrix[1, 1]
        Z_end = self._V_end / self._I_end
        return 2 / (A + (B / Z_end) + (C * Z_end) + D)