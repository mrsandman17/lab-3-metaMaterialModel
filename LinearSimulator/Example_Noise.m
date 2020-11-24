

%  Example:  Amplifier with Gain of 15 with 100ohms||50pF on the input and 50ohms
%  on the output going into a 1m transmission line terminated by 50ohms.  
%  Amplifier noise is 2nV/rtHz and 5pA/rtHz


f=linspace(1e6,30e6,100);
ABCD{1} = par_r(f,100);
ABCD{2} = par_c(f,500e-12);
[ABCD{3}, CABCD_Amp] = Amplifier(f,15,2e-9,5e-12);  %Amplifier
ABCD{4} = ser_r(f,50);
ABCD{5} = tline(f,50,10,60e-12,1);
ABCD{6} = par_r(f,50);

CABCD = PassiveABCD_to_Correlation(ABCD,293);  %Find noise of passive parts
CABCD{3} = CABCD_Amp;  %Correct the Amplifier's noise (since it's not passive)

[ABCD_C,CABCD_C] = cascade_combine_noise(ABCD,CABCD);  %Find the ABCD matrix and the correlation matrix

OverallGain = (abs(1./ABCD_C(:,1))).';  %Gain from beginning to end
Input_Referred_Noise = Noise_OC(ABCD_C,CABCD_C)./OverallGain;
figure(1)
plot(f,OverallGain);  title('Gain from input to end of terminated TLINE')
xlabel('Freq, Hz')
ylabel('Gain, V/V')
figure(2)
plot(f,Input_Referred_Noise);  title('Amplifier Input referred Voltage Noise');
xlabel('Freq, Hz')
ylabel('Input Referred Noise, in V/rtHz')
