from ABCDSimulator import ABCDSimulator

R = 1
L0 =1
G = 1
C0 = 1
L = 1
C = 1
CELL_LEN = 1
CELLS_NUM = 1

def main():
    abcd_simulator = ABCDSimulator(R, L0, G, C0, L, C, CELL_LEN, CELLS_NUM)
    abcd_simulator.run()

if __name__ == '__main__':
    main()