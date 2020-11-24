%
%
%  Linear 2-port Circuit Simulator, with noise correlation
%  matrices
%
%  This set of functions allows you to simulate a cascaded system
%  using ABCD parameters.  This is particularly useful for analog, or
%  linearized systems.  All functions operate over a range of frequencies.
%
%  Basic circuit storage structure:
%  The ABCD parameters are stored in matrix form, within cells.  For
%  example, let's say you were going to analyze a circuit with 15
%  components at 100 frequency points.   You would then create 15 cells
%  with 100x4 data points (at each frequency we are going to store 4 ABCD
%  matrix numbers).  The format is as follows.  See Example.m for more
%  info.
%    ABCD{n}(:,1) = A = v1/v2 with i2=0
%    ABCD{n}(:,2) = B = -v1/i2 with v2=0
%    ABCD{n}(:,3) = C = i1/v2 with i2=0
%    ABCD{n}(:,4) = D = -i1/i2 with v2=0
%    Note that the ":" convention is used to store the frequency vector
%
%  Known Bugs:
%  There is no guarantee, but I have tested these functions fairly well,
%  and haven't found any bugs.  
%  **There is no error checking**.  So if you feed it garbage, it'll just 
%  die.  In some cases you need to be careful of singularities (like trying 
%  to find the Y parameters for an ideal transformer).  
%
%  There is minimal to no support for this software.  Use it at your own
%  risk.  Any feedback can be done through Matlab's website.  The author is
%  not responsible for any use, or misuse of the software, and does not
%  guarantee that it will work properly.  
%
%
%  In GNU fashion, 
%       This program is distributed in the hope that it will be useful,
%       but WITHOUT ANY WARRANTY; without even the implied warranty of
%       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
%       
%   Written by Brett Bymaster, partially supported by Sensant Corporation
%
%
%
%
%
%Circuit Operations:
%   ImpedanceIntoCell - Calculate the impedance looking into a cell
%   PowerIntoCell     - This function calculates the power flowing into a Cell
%   VoltageAtCell     - Find the voltage at the input of a cell.  This is normalized to a 1v input
%   flip_ABCD         - This function flips a ABCD matrix.  ABCD is a matrix not a cell.
%   parallel_combine  - This function takes two ABCD matrices, and combines them in parallel using Y matrices
%   cascade_combine    - This function implements a cascaded combination of ABCD cells


%Circuit Components:
%   tform             - This is an ideal transformer, ratio VALUE:1.  
%   tline             - Lossy Non-ideal Transmission Line.  
%   par_c             - Parallel Capacitor to GND
%   par_l             - Parallel inductor to GND
%   par_r             - Parallel Resistor to GND
%   ser_c             - Series Capacitor
%   ser_l             - Series Inductor
%   ser_r             - Series resistor

%Conversions:
%   ABCD_to_S         - Convert ABCD matrix to Scattering Parameters.
%   ABCD_to_Y         - Convert ABCD matrix to Y parameters
%   ABCD_to_Z         - Convert ABCD matrix to Z parameters
%   Y_to_ABCD         - Convert Y parameters to ABCD matrix
%   Z_to_ABCD         - Convert Z parameters to ABCD matrix
%   S_to_ABCD         - Convert 2-port scattering parameters to ABCD matrix

%Noise Operations
%  These functions use correlation matrices.  This is a method of using
%  network parameters to calculate noise in a linear circuit.  The method
%  used here is outlined in the following paper:
%  H. Hillbrand and P. H. Russer, ``An Efficient Method for Computer Aided Noise Analysis of Linear Amplifier Networks,'' IEEE Transactions on Circuits and Systems, vol. 23, no. 4, pp. 235-238, Apr. 1976.
%  You can find a summary of that paper on the internet (free access) at:
%     http://www.ifh.ee.ethz.ch/Microwave/GaAs/pdf98/tu3a_3.pdf
%
%  Noise_CABCD_to_CY  - Convert Correlation matrix from ABCD to Y params  
%  Noise_CY_to_CABCD  - Convert Correlation matrix from Y to ABCD params
%  Noise_OC           - Calculate the open circuit noise of a single
%                       matrix.  Input is a matrix
%  PassiveABCD_To_Correlation - This function takes a convential ABCD
%                               matrix, and from that calculates the noise 
%                               correlation matrix assuming all components
%                               are passive
%  parallel_combine_noise - Combine two ABCD matrices in parallel
%  cascade_combine_noise   - Combine a number of ABCD cells in cascade
%  Amplifier          - This models an ideal, and noisy amplifier in ABCD
%                       and Correlation noise matrices