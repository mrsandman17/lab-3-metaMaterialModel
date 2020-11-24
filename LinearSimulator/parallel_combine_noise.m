function [ABCD, CABCD]=parallel_combine_noise(ABCD1,CABCD1,ABCD2,CABCD2)
%This function takes two ABCD matrices, and combines them in parallel using
%Y matrices.  
%  [ABCD, CABCD]=parallel_combine_noise(ABCD1,CABCD1,ABCD2,CABCD2)
%  ABCD1,2 are the circuitry matrices.
%  CABCD1,2 are the noise matrices
%  The parallel combined circuitry matrix (ABCD) and noise matrix (CABCD)
%  are returned
%
%The inputs must not be cells -- they must be standard
%matrices.  For example, to make a parallel/series connection,
%         Z1                     Z2
%  ((100ohms + 100pF) || (200ohms + 200pF)) 
%%Find Z1
%ABCD_Z2{1} = ser_r(f,100);
%ABCD_Z2{2} = ser_c(f,100e-12);
%CABCD_Z2 = PassiveABCD_to_Correlation(ABCD_Z2,293);
%[ABCD_C_Z2,CABCD_C_Z2] = cascade_combine_noise(ABCD_Z2,CABCD_Z2);

%Find Z2
%ABCD_Z3{1} = ser_r(f,200);
%ABCD_Z3{2} = ser_c(f,200e-12);
%CABCD_Z3 = PassiveABCD_to_Correlation(ABCD_Z3,293);
%[ABCD_C_Z3,CABCD_C_Z3] = cascade_combine_noise(ABCD_Z3,CABCD_Z3 );

%Combine Z1 and Z2 in parallel
%[ABCD_C,CABCD_C] = parallel_combine_noise(ABCD_C_Z2,ABCD_C_Z2,ABCD_C_Z3,CABCD_C_Z3);










k=1.380658e-23;

Y1=ABCD_to_Y(ABCD1);
Y2=ABCD_to_Y(ABCD2);

%C1=2*k*T*real(Y1);
%C2=2*k*T*real(Y2);


Y=Y1+Y2;
C=Noise_CABCD_to_CY(CABCD1,Y1) + Noise_CABCD_to_CY(CABCD2,Y2);

ABCD=Y_to_ABCD(Y);

CABCD=Noise_CY_to_CABCD(C,ABCD);

    