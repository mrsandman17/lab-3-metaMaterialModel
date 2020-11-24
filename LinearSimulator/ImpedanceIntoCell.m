function Z=ImpedanceIntoCell(ABCD_Cell,CellNumber)
%Calculate the impedance looking into a cell
%  Z=ImpedanceIntoCell(ABCD_Cell,CellNumber)
%
%Example:
%  
% ABCD{1} = ser_r(1:10,100);
% ABCD{2} = ser_r(1:10,300);
% ABCD{3} = par_r(1:10,1000);
% ABCD{4} = par_r(1:10,2000);
% ImpedanceIntoCell(ABCD,2)
%  = 300 + (1k * 2k)/(1k + 2k) = 966.66ohms

%If the CellNumber is the last cell, then we got it easy and can directly
%caculate the impedance
if CellNumber == length(ABCD_Cell),
    Z=ABCD_Cell{end}(:,1)./ABCD_Cell{end}(:,3);
    return
end

%Cascade the cells after CellNumber
nn=0;
for n=CellNumber:length(ABCD_Cell),
    nn=nn+1;
    ABCD_I{nn}=ABCD_Cell{n};
end

%Do the cascade combination
ABCD = cascade_combine(ABCD_I);

%Impedance to GND is A/C
Z=ABCD(:,1)./ABCD(:,3);