import csv
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

POINTS_NUM = 1000
CSV_NAME = 'ABCD_matlab_1.csv'

START_F = 1*10**9
END_F = 14*10**9
V_end = 1
I_end = 1 / 50

def plot_s_params(frequency_range, s11_arr, s21_arr):
    fig, axs = plt.subplots(2)
    axs[0].plot(frequency_range, 20 * np.log10(np.absolute(s11_arr)))
    axs[0].set_title('S11 - Reflection')
    axs[1].set_title('S21 - Transmission')
    axs[1].plot(frequency_range, 20 * np.log10(np.absolute(s21_arr)))
    axs[1].set_xlabel('Frequency (Hz)')
    plt.show()

def get_s11(abcd_matrix):
    A = abcd_matrix[0, 0,:]
    B = abcd_matrix[0, 1,:]
    C = abcd_matrix[1, 0,:]
    D = abcd_matrix[1, 1,:]
    Z_end = V_end / I_end
    return (A + (B / Z_end) - (C * Z_end) - D) / (A + (B / Z_end) + (C * Z_end) + D)

def get_s21(abcd_matrix):
    A = abcd_matrix[0, 0,:]
    B = abcd_matrix[0, 1,:]
    C = abcd_matrix[1, 0,:]
    D = abcd_matrix[1, 1,:]
    Z_end = V_end / I_end
    return 2 / (A + (B / Z_end) + (C * Z_end) + D)

def get_s12(abcd_matrix):
    A = abcd_matrix[0, 0,:]
    B = abcd_matrix[0, 1,:]
    C = abcd_matrix[1, 0,:]
    D = abcd_matrix[1, 1,:]
    Z_end = V_end / I_end

    return (2 *A*D - 2*B*C) / (A + (B / Z_end) + (C * Z_end) + D)


def main():
    data = pd.read_csv(CSV_NAME, sep=",", header=None)
    data = data.applymap(lambda s: np.complex(s.replace('i', 'j'))).values
    abcd_matrix = np.empty((2, 2, POINTS_NUM), dtype=complex)
    line_count = 0
    for row in data:
        abcd_matrix[0, 0, line_count] = data[line_count, 0]
        abcd_matrix[0, 1, line_count] = data[line_count, 1]
        abcd_matrix[1, 0, line_count] = data[line_count, 2]
        abcd_matrix[1, 1, line_count] = data[line_count, 3]
        line_count += 1
    frequency_range = np.linspace(START_F, END_F, POINTS_NUM)
    s11_arr = (get_s11(abcd_matrix))
    s21_arr = (get_s21(abcd_matrix))
    # s12_arr = (get_s12(abcd_matrix))
    plot_s_params(frequency_range, s11_arr, s21_arr)

if __name__ == '__main__':
    main()