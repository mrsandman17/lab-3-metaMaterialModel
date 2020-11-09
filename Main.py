from ABCDSimulator import ABCDSimulator

# Params for the MetaMaterial circuit
R = 0
L0 =1
G = 0
C0 = 1
L = 1
C = 1
CELL_LEN = 1
CELLS_NUM = 1

# freq range to scan
START_FREQ = 1
END_FREQ = 100

# voltage and current at the end
V_end = 1
I_end = 1 / 50

def main():
    abcd_simulator = ABCDSimulator(R, L0, G, C0, L, C, CELL_LEN, CELLS_NUM, START_FREQ, END_FREQ, V_end, I_end)
    abcd_simulator.run()

if __name__ == '__main__':
    main()