function V=VoltageAtCell(ABCD_Cell,CellNumber)
%Find the voltage at the input of a cell.  This is normalized to a 1v input
%at the beginning of the cascade
%
%  V=VoltageAtCell(ABCD_Cell,CellNumber)
%
%Example:
% Find the voltage drop across the combination (100 + 300) || 1k || 2k,
% assuming a source voltage of 10v
% ABCD{1} = ser_r(1:10,100);
% ABCD{2} = ser_r(1:10,300);
% ABCD{3} = par_r(1:10,1000);
% ABCD{4} = par_r(1:10,2000);
% VoltageAtCell(ABCD,3).*10
%  = 10v * 666/(666 + 400) = 6.25v

if CellNumber == 1,
    V=ones(1,length(ABCD_Cell(:,1)));;
    return
end



nn=0;
for n=1:CellNumber-1,
    nn=nn+1;
    ABCD_I{nn}=ABCD_Cell{n};
end

if length(ABCD_I) > 1,
    ABCD_C=cascade_combine(ABCD_I);
else
    ABCD_C = ABCD_I{1};
end

Z=ImpedanceIntoCell(ABCD_Cell,CellNumber);

ABCD{1}=ABCD_C;
ABCD{2}=par_r(1:length(ABCD_Cell{1}(:,1)),rot90(Z));

ABCD_F = cascade_combine(ABCD);
V=1./ABCD_F(:,1);