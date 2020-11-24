
%EXAMPLE:
%  This function implements a simple RF circuit.  It cascades a 200 source
%  impedance, 2:1 source matching transformer, 50ohm transmission line,
%  load matching network, and 30pF + 100ohm load.  As a function of
%  frequency, the following parameters are plotted:
%      Voltage transfer function, H(s) = Vout/Vin
%      Input Impedance
%      Output Impedance
%      Impedance looking into load matching network



f=linspace(1e9,14e9,1e3);   %Setup a frequency space from 170Mhz to 220Mhz
w=f.*2.*pi;   %This is the omega vector
clear ABCD    %Clean things up from a prior simulation
n=1;
%50ohm, transmission line length of 1m
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %1  Transmission Line, 50ohms not very lossy
  ABCD{n} = par_l(f,7.5e-9);  n=n+1;                %2  Parallel inductor
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %3  Transmission Line, 50ohms not very lossy
  ABCD{n} = ser_c(f,1e-12);  n=n+1;               %4  Series capacitor
  
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %1  Transmission Line, 50ohms not very lossy
  ABCD{n} = par_l(f,7.5e-9);  n=n+1;                %2  Parallel inductor
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %3  Transmission Line, 50ohms not very lossy
  ABCD{n} = ser_c(f,1e-12);  n=n+1;               %4  Series capacitor
  
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %1  Transmission Line, 50ohms not very lossy
  ABCD{n} = par_l(f,7.5e-9);  n=n+1;                %2  Parallel inductor
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %3  Transmission Line, 50ohms not very lossy
  ABCD{n} = ser_c(f,1e-12);  n=n+1;               %4  Series capacitor
  
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %1  Transmission Line, 50ohms not very lossy
  ABCD{n} = par_l(f,7.5e-9);  n=n+1;                %2  Parallel inductor
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %3  Transmission Line, 50ohms not very lossy
  ABCD{n} = ser_c(f,1e-12);  n=n+1;               %4  Series capacitor
  
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %1  Transmission Line, 50ohms not very lossy
  ABCD{n} = par_l(f,7.5e-9);  n=n+1;                %2  Parallel inductor
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %3  Transmission Line, 50ohms not very lossy
  ABCD{n} = ser_c(f,1e-12);  n=n+1;               %4  Series capacitor
  
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %1  Transmission Line, 50ohms not very lossy
  ABCD{n} = par_l(f,7.5e-9);  n=n+1;                %2  Parallel inductor
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %3  Transmission Line, 50ohms not very lossy
  ABCD{n} = ser_c(f,1e-12);  n=n+1;               %4  Series capacitor
  
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %1  Transmission Line, 50ohms not very lossy
  ABCD{n} = par_l(f,7.5e-9);  n=n+1;                %2  Parallel inductor
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %3  Transmission Line, 50ohms not very lossy
  ABCD{n} = ser_c(f,1e-12);  n=n+1;               %4  Series capacitor
  
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %1  Transmission Line, 50ohms not very lossy
  ABCD{n} = par_l(f,7.5e-9);  n=n+1;                %2  Parallel inductor
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %3  Transmission Line, 50ohms not very lossy
  ABCD{n} = ser_c(f,1e-12);  n=n+1;               %4  Series capacitor
  
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %1  Transmission Line, 50ohms not very lossy
  ABCD{n} = par_l(f,7.5e-9);  n=n+1;                %2  Parallel inductor
  ABCD{n} = tline(f,3.48e-7,1e-10,1.89e-10,0.5e-2) ;n=n+1;          %3  Transmission Line, 50ohms not very lossy
  ABCD{n} = ser_c(f,1e-12);  n=n+1;               %4  Series capacitor


%Combine all ABCD matrices in a cascade
ABCD_C=cascade_combine(ABCD);


%Find the voltage transfer function, = H(s) = Vout/Vin.
%  This is equal to 1/A in the ABCD matrix
OutputVoltage = 1./(ABCD_C(:,1));

%Find the input impedance = A/C
InputImpedance = ABCD_C(:,1)./ABCD_C(:,3);

%Flip the matrix to find the output impedance
ABCD_Flip = flip_ABCD(ABCD_C);
%Output impedance = A/C on flipped ABCD matrix
OutputImpedance = ABCD_Flip(:,1)./ABCD_Flip(:,3);

%Find the impedance looking into the load, = impedance looking into cell 4
ImpedanceLookingIntoLoad = ImpedanceIntoCell(ABCD,4);

S=ABCD_to_S(f,ABCD_C,50);
S11=S.s11;
S12=S.s12;

% 
% 
% %Now do a bunch of plots.  For impedances, real part in top plot, imaginary
% %part in bottom plot
% figure(1)
% clf;
% plot(f,abs(OutputVoltage));
% title('Voltage transfer function from input to output (Vout/Vin)');
% 
% figure(2)
% clf;
% subplot(2,1,1)
% plot(f,real(InputImpedance))
% title('Input Impedance')
% subplot(2,1,2)
% plot(f,imag(InputImpedance))
% 
% figure(3)
% clf;
% subplot(2,1,1)
% plot(f,real(OutputImpedance))
% title('Output Impedance')
% subplot(2,1,2)
% plot(f,imag(OutputImpedance))
% 
% 
% figure(4)
% clf;
% subplot(2,1,1)
% plot(f,real(ImpedanceLookingIntoLoad))
% title('Impedance looking into transformed load')
% subplot(2,1,2)
% plot(f,imag(ImpedanceLookingIntoLoad))

figure(5)
clf;
subplot(2,1,1)
plot(f,20* log10(abs(S11)))
title('S11')
subplot(2,1,2)
plot(f,20*log10(abs(S12)))
