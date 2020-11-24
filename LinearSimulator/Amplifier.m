function [ABCD, CABCD] = Amplifier(f,Gain,Vnoise,Inoise)
%Model for an ideal amplifier.  
%[ABCD, CABCD] = Amplifier(f,Gain,Vnoise,Inoise)
%
%The model is:
%  A = Gain ... can be a vector (i.e. the gain & phase of the amplifier,
%    but expressed in REAL + IMAGINARY
%  B = 0
%  C = 0
%  D = 0
%
%  If Vnoise & Inoise are ommitted, the noise correlation matrix is not
%  returned, and a noiseless amplifier is simulated.
%
%If Vnoise and Inoise is used, then the noise correlation matrix is
%returned.  It is assumed that the voltage noise and current noise are
%completely decorellated.  The voltage noise (Vnoise) and Current noise
%(Inoise) are expressed in V/rtHz
%  The correlation matrix is as follows:
%  C11 = Vnoise^2/2
%  C12 = 0
%  C21 = 0
%  C22 = Inoise^2/2
%
%  Note that f isn't really used for anything but to find the vector length
%  (and for consitency)
%
%  Example:  Amplifier with Gain of 15 with 100ohms||50pF on the input and 50ohms
%  on the output going into a 1m transmission line terminated by 50ohms.  
%  Amplifier noise is 2nV/rtHz and 5pA/rtHz
%  f=linspace(1e6,30e6,100);
%  ABCD{1} = par_r(f,100);
%  ABCD{2} = par_c(f,500e-12);
%  [ABCD{3}, CABCD_Amp] = Amplifier(f,15,2e-9,5e-12);  %Amplifier
%  ABCD{4} = ser_r(f,50);
%  ABCD{5} = tline(f,50,10,60e-12,1);
%  ABCD{6} = par_r(f,50);
%
%  CABCD = PassiveABCD_to_Correlation(ABCD,293);  %Find noise of passive parts
%  CABCD{3} = CABCD_Amp;  %Correct the Amplifier's noise (since it's not passive)
%
%  [ABCD_C,CABCD_C] = cascade_combine_noise(ABCD,CABCD);  %Find the ABCD matrix and the correlation matrix

%  OverallGain = (abs(1./ABCD_C(:,1))).';  %Gain from beginning to end
%  Input_Referred_Noise = Noise_OC(ABCD_C,CABCD_C)./OverallGain;
%  figure(1)
%  plot(f,OverallGain);  title('Gain from input to end of terminated TLINE')
%  figure(2)
%  plot(f,Input_Referred_Noise);  title('Amplifier Input referred Voltage Noise');



a=size(Gain);
if a(1,1)>1,
    Gain = Gain.';
end

ABCD(:,1) = ones(length(f),1)./Gain;
ABCD(:,2) = zeros(length(f),1);
ABCD(:,3) = zeros(length(f),1);
ABCD(:,4) = zeros(length(f),1);

if nargin==4,
    if length(Vnoise)==length(f),
        CABCD(:,1) = (Vnoise).'.^2/2;
        CABCD(:,2) = zeros(length(f),1);
        CABCD(:,3) = zeros(length(f),1);
        CABCD(:,4) = (Inoise).'.^2/2;
    else
        CABCD = repmat([Vnoise(1)^2/2 0 0 Inoise(1)^2/2],length(f),1);
    end
end