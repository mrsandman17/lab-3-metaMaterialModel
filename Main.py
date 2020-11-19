from ABCDSimulator import ABCDSimulator
# Params for the MetaMaterial circuit
CELLS_NUM = 10
CELL_LEN = 1 * 10 ** -2
R = 1 * 10 ** - 20
L0 = 3.48 * 10**-7
G = 1 * 10 ** - 20
C0 = 1.89*10**-10
L = 7.5*10**-9
C = 1*10**-12



# freq range to scan
START_FREQ = 1.2*10**9
END_FREQ = 10*10**9

# voltage and current at the end
V_end = 1
I_end = 1 / 50

def main():
    abcd_simulator = ABCDSimulator(R, L0, G, C0, L, C, CELL_LEN, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
    abcd_simulator.run()


if __name__ == '__main__':
    main()