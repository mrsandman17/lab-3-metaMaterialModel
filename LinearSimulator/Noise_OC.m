function Noise = Noise_OC(ABCD,CABCD)
%This function calculates the open circuit noise for an ABCD and
%correlation matrix.
%  Noise = Noise_OC(ABCD,CABCD)
%  ABCD is the typical circuitry ABCD matrix
%  CABCD is the correlation noise matrix in ABCD form.
%  Noise is the output noise voltage, in units of V/sqrt(Hz)
%
%  This function assumes that the input and output of the ABCD matrix are
%  open circuit, and then finds the output noise generated in the circuit.
%
%  Example:  The voltage noise in a 50ohm resistor at 20C should be 
% k=13.80658e-24; R=50; T=293; 
% NoiseTheory = sqrt(4*k*T*R)
% f=1;
% ABCD{1} = par_r(f,100);  %Just for fun, make this 100||100 = 50ohms
% ABCD{2} = par_r(f,100); 
% CABCD = PassiveABCD_To_Correlation(ABCD,293);
% [ABCD_Combined,CABCD_Combined] = cascade_combine_noise(ABCD,CABCD);
% Noise_Simulated = Noise_OC(ABCD_Combined,CABCD_Combined)
%   = ~0.9nV/rtHz

for n=1:length(ABCD(:,1));
%                        Noise Voltage at input of ABCD           Mirrored to output    
    Noise(n)=sqrt(abs(  CABCD(n,4)*2*(ABCD(n,1)/ABCD(n,3))^2 ) * abs((1/(ABCD(n,1)))^2));
end