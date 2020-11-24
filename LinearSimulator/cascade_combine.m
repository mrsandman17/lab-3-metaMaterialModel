function ABCD_f=cascade_combine(ABCD_Cell)
%This function implements a cascade combination of ABCD matrcies
%into a single conglomerate ABCD matrix.
% ABCD_f=cascade_combine(ABCD_Cell)
%
%  ABCD_f=cascade_combine(ABCD_Cell)
%  ABCD_Cell is a cell of ABCD matrices
%  ABCD_f is the combined ABCD matrix
%
%To create the ABCD_Cell:
%This done simply by multipling each ABCD matrix, at each frequency
%The input is a cell of the cascaded ABCD matrices.  Each cell contains 
%a matrix that is size of length(frequency) by 4.  
%  ABCD(:,1) = A
%  ABCD(:,2) = B
%  ABCD(:,3) = C
%  ABCD(:,4) = D
%
%For example, to make a 100pF series capacitor,
%  f=linspace(100e3,10e6,1e3);
%  ABCD{1}(:,1) = ones(1,length(f));  %A's
%  ABCD{1}(:,2) = 1./(2.*pi.*f.*100e-12);  %B's
%  ABCD{1}(:,3) = zeros(1,length(f));  %C's
%  ABCD{1}(:,4) = ones(1,length(f));  %D's
%
% Or to use the built in function, 
%  f=linspace(100e3,10e6,1e3);
%  ABCD{1} = ser_c(f,100e-12);
%
%The output of this function is a non-cell matrix, size of
%length(frequency) by 4.
%
%
%To combine two capacitors in series, you would do the following:
%  f=linspace(100e3,10e6,1e3);
%  ABCD{1} = ser_c(f,100e-12);
%  ABCD{2} = ser_c(f,100e-12);
%  ABCD_Combined=cascade_combine(ABCD);

ABCD=ABCD_Cell{1};
for n=2:length(ABCD_Cell),
    next=ABCD_Cell{n};
    ABCD_f(:,1)=ABCD(:,1).*next(:,1)+ABCD(:,2).*next(:,3);
    ABCD_f(:,2)=ABCD(:,1).*next(:,2)+ABCD(:,2).*next(:,4);
    ABCD_f(:,3)=ABCD(:,3).*next(:,1)+ABCD(:,4).*next(:,3);
    ABCD_f(:,4)=ABCD(:,3).*next(:,2)+ABCD(:,4).*next(:,4);
    
    ABCD=ABCD_f;
end
