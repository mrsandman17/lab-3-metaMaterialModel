function C=PassiveABCD_to_Correlation(ABCD,T)
%Find the correlation noise matrix for a passive component.
%
%  C=PassiveABCD_to_Correlation(ABCD,T)
%
%  ABCD is a cell of ABCD matrices.  T is temp in Kelvin
%  This is done by converting the matrix, ABCD{n} to either Z or Y
%  parameters, depending on which one exists, and using the following
%  matrix relationship:
%  CZ = 2kT*Real(Z)
%  CY = 2kT*Imag(Y)
%  
%  Then the correlation matrix is converted to the ABCD version by:
%  CABCD = T * C * T'
%   where T = [0 A12; 1  A22] for Y parameters and
%         T = [1 -A11;0 -A21] for Z parameters
%
%
%  Example:  Find the thermal noise in the following circuit:  
%  50ohms in series with a lossy transmission terminated in 50ohms||50pF
%  f=linspace(1e6,100e6,100);
%  ABCD{1} = ser_r(f,50);
%  ABCD{2} = tline(f,50,10,60e-12,1);
%  ABCD{3} = par_r(f,50);
%  ABCD{4} = par_c(f,50e-12);
%
%  CABCD = PassiveABCD_to_Correlation(ABCD,293);  %Find noise of passive parts
%
%  [ABCD_C,CABCD_C] = cascade_combine_noise(ABCD,CABCD);  %Find the ABCD matrix and the correlation matrix
%  Noise = Noise_OC(ABCD_C,CABCD_C);
%  figure(1)
%  plot(f,Noise./1e-9);  title('Noise in nV/rtHz')
%  figure(2)
%  plot(f,abs(1./ABCD_C(:,1))); title('Transfer function from input to output')
%
%  Note that this is not vectorized and is really terrible slow...


k=1.380658e-23;
%T=300;

warning off MATLAB:divideByZero



for n=1:length(ABCD),
    freq_points=size(ABCD{n});
    freq_points=freq_points(1,1);
    C{n}=zeros(freq_points,4);
    display_message=1;
    
    for nn=1:freq_points,
        Z=ABCD_to_Z(ABCD{n}(nn,:));
        if isinf(Z),
            Y=ABCD_to_Y(ABCD{n}(nn,:));
            if isinf(Y),
                if display_message == 1,
                    disp(sprintf('Component %g has no Z or Y parameters, noise is set to 0',n))
                    display_message=0;
                end
                C{n}(nn,:) = [0 0 0 0];
            else
                TY = [0 ABCD{n}(nn,2);1 ABCD{n}(nn,4)];
                CY=2*k*T*real([Y(1,1) Y(1,2); Y(1,3) Y(1,4)]);
                CC = TY*CY*TY';
                C{n}(nn,:) = [CC(1,1) CC(1,2) CC(2,1) CC(2,2)];
            end
        else        
            TZ = [1 -ABCD{n}(nn,1); 0 -ABCD{n}(nn,3)];
        
            CZ=2*k*T*real([Z(1,1) Z(1,2); Z(1,3) Z(1,4)]);
            CC = TZ*CZ*TZ';
            C{n}(nn,:) = [CC(1,1) CC(1,2) CC(2,1) CC(2,2)];
        end
    end
end

warning on MATLAB:divideByZero
        
            
            