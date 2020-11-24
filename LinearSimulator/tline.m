function ABCD=tline(f,L,R,C,length_cable)
%Lossy Non-ideal Transmission Line.  Usage:
%  ABCD=tline(f,Z0,R,C,length_cable)
%  Where
%   Z0 = Characteristic impedance = sqrt(L/C)
%   R =  Resistance per unit length
%   C =  Capacitance per unit length
%   length_cable = Length of cable (be sure to be constitent in units)
%Example (units in meters):
%  ABCD = tline(f,50,0.4,62e-12,1)
ww=f.*2.*pi;
        gamma=sqrt((R+j.*ww.*L).*(j.*ww.*C));  %Gamma assuming G=0
        Z0=sqrt((R+j.*ww.*L)./(j.*ww.*C));     %Complex Z0  
        
        %Now fill in the matrix equations
        A=cosh(gamma.*length_cable);
        B=Z0.*sinh(gamma.*length_cable);
        C=1./Z0.*sinh(gamma.*length_cable);
        D=cosh(gamma.*length_cable);
ABCD(:,1)=A;
ABCD(:,2)=B;
ABCD(:,3)=C;
ABCD(:,4)=D;
disp(ABCD)
