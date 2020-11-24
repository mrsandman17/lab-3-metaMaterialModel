

%Noise Example:  Make a circuit with a cascade/parallel combination.

%Here is the circuit
%  Z1                         Z2                     Z3              Z4
%300ohms (toGND) +  ((100ohms + 100pF) || (200ohms + 200pF)) + 400ohms (to GND)

f=linspace(1e6,30e6,100);

%Find Z2
ABCD_Z2{1} = ser_r(f,100);
ABCD_Z2{2} = ser_c(f,100e-12);
CABCD_Z2 = PassiveABCD_to_Correlation(ABCD_Z2,293);
[ABCD_C_Z2,CABCD_C_Z2] = cascade_combine_noise(ABCD_Z2,CABCD_Z2);

%Find Z3
ABCD_Z3{1} = ser_r(f,200);
ABCD_Z3{2} = ser_c(f,200e-12);
CABCD_Z3 = PassiveABCD_to_Correlation(ABCD_Z3,293);
[ABCD_C_Z3,CABCD_C_Z3] = cascade_combine_noise(ABCD_Z3,CABCD_Z3 );  %Note that we could just use cascade_combine here without the noise.  But we'll do it with the noise just for fun

%Combine Z2 and Z3 in parallel
[ABCD_C,CABCD_C] = parallel_combine_noise(ABCD_C_Z2,ABCD_C_Z2,ABCD_C_Z3,CABCD_C_Z3);

%Now add in Z1 and Z4 in series
ABCD{1} = par_r(f,300);
ABCD{2} = ABCD_C;
ABCD{3} = par_r(f,400);
CABCD = PassiveABCD_to_Correlation(ABCD,293);

%Here's the final deal
[ABCD_C_Final,CABCD_C_Final] = cascade_combine_noise(ABCD,CABCD);

Zinput = ImpedanceIntoCell(ABCD,1);
Noise = Noise_OC(ABCD_C_Final,CABCD_C_Final);
figure(1)
subplot(2,1,1)
plot(f,real(Zinput));
subplot(2,1,2)
plot(f,imag(Zinput));

figure(2)

plot(f,Noise);

