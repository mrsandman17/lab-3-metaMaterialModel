from ABCDSimulator import ABCDSimulator

# Params for the MetaMaterial circuit
R = 0
L0 = 7 * 10 ** -11
G = 0
C0 = 1.8 * 10 ** -12
L = 15 * 10 ** -9
C = 1 * 10 ** -12
CELL_LEN = 3 * 10 ** -2
CELLS_NUM = 1

# freq range to scan
START_FREQ = 1 * 10 ** 9
END_FREQ = 20 * 10 ** 9

# voltage and current at the end
V_end = 1
I_end = 1 / 50

def main():
    abcd_simulator = ABCDSimulator(R, L0, G, C0, L, C, CELL_LEN, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
    abcd_simulator.run()

if __name__ == '__main__':
    main()