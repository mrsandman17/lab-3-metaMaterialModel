from ABCDSimulator import ABCDSimulator

# Params for the MetaMaterial circuit
CELLS_NUM = 10
CELL_LEN = 1 * 10 ** -2
R = 0
L0 = 0.01332 * 10**-5
G = 0
C0 = 3.96*10**-11 / CELLS_NUM
L = 200*10**-9
C = 100*10**-12



# freq range to scan
START_FREQ = 1
END_FREQ = 7*10**9

# voltage and current at the end
V_end = 1
I_end = 1 / 50

def main():
    abcd_simulator = ABCDSimulator(R, L0, G, C0, L, C, CELL_LEN, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
    abcd_simulator.run()

if __name__ == '__main__':
    main()