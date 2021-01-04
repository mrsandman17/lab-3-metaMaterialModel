from ABCDSimulator import ABCDSimulator
# Params for the MetaMaterial circuit
import numpy as np
import matplotlib.pyplot as plt

OLD_BOARD_GAP_S11 = r'MeasuredData\old_board_gap_s11.csv'
OLD_BOARD_GAP_S21 = r'MeasuredData\old_board_gap_s21.csv'
MEASURED_S11_PATH = OLD_BOARD_GAP_S11
MEASURED_S21_PATH = OLD_BOARD_GAP_S21

SAVE_FIG = True
PLOT_MEASURED_DATA = True

CELLS_NUM = 10
CELL_LEN = 1 * 10 ** -2
R = 10 ** -10
L0 = 3.48e-7
G = 0
C0 = 1.89e-10
L = 7.5*10**-9
C = 1*10**-12

#USED for c0, l0 calculation
W1 = 6 * 10 ** 9
W2 = 8 * 10 ** 9


# freq range to scan
START_FREQ = 1*10**9
END_FREQ = 4*10**9

# voltage and current at the end
V_end = 1
I_end = 1 / 50

FONT_SIZE = 16

def main():

    print_C0_L0()
    # simulate_over_cells_num()
    # simulate_over_cell_len()
    # simulate_over_R_G()
    # simulate_over_C0_L0()
    # simulate_over_C_L()
    single_simulation()
    # board_spec_simulation()

def simulate_over_cells_num():
    print_band_gap_frequencies(C0,L0, C, L, CELL_LEN)
    min_cell_num = 1
    max_cell_num = 10
    for cells_num in range(min_cell_num, max_cell_num):
        abcd_simulator = ABCDSimulator(R, L0, G, C0, L, C, CELL_LEN, cells_num, START_FREQ, END_FREQ, V_end, I_end)
        abcd_simulator.run()
        abcd_simulator.plot_s_params()

def simulate_over_R_G():
    # SET R TO AT LEAST 10 ** 4 FOR AN EFFECT ON THE SIMULATION!
    print_band_gap_frequencies(C0,L0, C, L, CELL_LEN)
    gammas = []
    freq_arr = None
    for i in range(-10, 3):
        r = R * (10 ** i)
        g = r
        abcd_simulator = ABCDSimulator(r, L0, g, C0, L, C, CELL_LEN, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
        abcd_simulator.run()
        abcd_simulator.plot_s_params()
        freq_arr = abcd_simulator.frequency_range
        gammas.append(abcd_simulator.gamma_arr)



    plt.figure(1)
    title = f'Gamma vs frequency over different R,G'
    plt.suptitle(title, fontSize=FONT_SIZE)
    for i in range(-10, 3):
        r = R * (10 ** i)
        plt.phase_spectrum(gammas[10 + i], label=f'R=G={r}')
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Gamma (Db)')
    plt.legend(loc='best')
    plt.show()

def simulate_over_C_L():

    for i in range(-4, 4):
        c = C * (5 ** i)
        l = L * (5 ** i)
        print_band_gap_frequencies(C0,L0, c, l, CELL_LEN)
        abcd_simulator = ABCDSimulator(R, L0, G, C0, l, c, CELL_LEN, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
        abcd_simulator.run()
        abcd_simulator.plot_s_params()

def simulate_over_C0_L0():
    gammas = []
    freq_arr = None
    for i in range(-4, 4):
        c0 = C0 * (2 ** i)
        l0 = L0 * (2 ** i)
        print_band_gap_frequencies(c0, l0, C, L, CELL_LEN)
        abcd_simulator = ABCDSimulator(R, l0, G, c0, L, C, CELL_LEN, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
        abcd_simulator.run()
        abcd_simulator.plot_s_params()
        freq_arr = abcd_simulator.frequency_range
        gammas.append(abcd_simulator.gamma_arr)

    plt.figure(1)
    title = f'Gamma vs frequency over different C0,L0'
    plt.suptitle(title, fontSize=FONT_SIZE)
    for i in range(-4, 4):
        c0 = C0 * (2 ** i)
        l0 = L0 * (2 ** i)
        plt.plot(freq_arr, 20 * np.log10(gammas[4 + i]), label=f'C0={c0},L0={l0}')
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Gamma (Db)')
    plt.legend(loc='best')
    plt.show()

def simulate_over_cell_len():
    gammas = []
    freq_arr = None
    for i in range(-4, 4):
        cell_len = CELL_LEN * (2 ** i)
        print_band_gap_frequencies(C0, L0, C, L, cell_len)
        abcd_simulator = ABCDSimulator(R, L0, G, C0, L, C, cell_len, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
        abcd_simulator.run()
        abcd_simulator.plot_s_params()
        freq_arr = abcd_simulator.frequency_range
        gammas.append(abcd_simulator.gamma_arr)

    plt.figure(1)
    title = f'Gamma vs frequency over different cell length'
    plt.suptitle(title, fontSize=FONT_SIZE)
    for i in range(-4, 4):
        cell_len = CELL_LEN * (2 ** i)
        plt.plot(freq_arr, 20 * np.log10(gammas[4 + i]), label=f'{cell_len}m')
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Gamma (Db)')
    plt.legend(loc='best')
    plt.show()

def single_simulation():
    print_band_gap_frequencies(C0,L0, C, L, CELL_LEN)
    abcd_simulator = ABCDSimulator(R, L0, G, C0, L, C, CELL_LEN, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
    abcd_simulator.read_measured_data(MEASURED_S11_PATH, MEASURED_S21_PATH)
    abcd_simulator.run()
    abcd_simulator.plot_s_params(SAVE_FIG, PLOT_MEASURED_DATA)

def print_band_gap_frequencies(c0, l0, c, l, cell_len):
    w1 = 1 / (np.sqrt(c0 * l * cell_len)) * (1 / (2 *np.pi))
    w2 = 1 / (np.sqrt(l0 * c * cell_len)) * (1 / (2 *np.pi))
    print(f'w1: {w1:e}')
    print(f'w2: {w2:e}')

def print_C0_L0():
    c0 = 1 / ((W1 **2) * L * CELL_LEN)
    l0 = 1 / ((W2 **2) * C * CELL_LEN)
    print(f'C0: {c0:e}')
    print(f'L0: {l0:e}')

def board_spec_simulation():
    l0 = 3.574 * 10**-9
    c0 = 0.82838 * 10**-12
    G=0
    R=0
    print_band_gap_frequencies(c0, l0, C, L, CELL_LEN)
    abcd_simulator = ABCDSimulator(R, l0, G, c0, L, C, CELL_LEN, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
    abcd_simulator.run()
    abcd_simulator.plot_s_params()



if __name__ == '__main__':
    main()