function [ABCD_OUT,C_OUT]=cascade_combine_noise(ABCD,CABCD);
%Combine ABCD circuitry and noise matrices in a cascade.
%  [ABCD_OUT,C_OUT]=cascade_combine_noise(ABCD,CABCD);
%  ABCD is a cell of circuitry matrices
%  CABCD is a cell of noise matrices
%  The circuitry matrix (ABCD_OUT) and noise matrix (C_OUT) are returned.
%
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


    freq_points=size(ABCD{1});
    freq_points=freq_points(1,1);
    C_OUT=zeros(freq_points,4);
    ABCD_OUT=zeros(freq_points,4);
    
    
for nn=1:freq_points,
    n=1;
    A=[ABCD{n}(nn,1)  ABCD{n}(nn,2);  ABCD{n}(nn,3)  ABCD{n}(nn,4)];
    C=[CABCD{n}(nn,1) CABCD{n}(nn,2); CABCD{n}(nn,3) CABCD{n}(nn,4)];
    for n=2:length(ABCD),
        A_next=[ABCD{n}(nn,1)  ABCD{n}(nn,2);  ABCD{n}(nn,3)  ABCD{n}(nn,4)];
        C_next=[CABCD{n}(nn,1) CABCD{n}(nn,2); CABCD{n}(nn,3) CABCD{n}(nn,4)];
        
        A_Combine=A*A_next;
        C_Combine=A*C_next*A' + C;
        A=A_Combine;
        C=C_Combine;
        
    end
        C_OUT(nn,:)    = [C(1,1) C(1,2) C(2,1) C(2,2)];
        ABCD_OUT(nn,:) = [A(1,1) A(1,2) A(2,1) A(2,2)];
end   
     
    
    
        
    
