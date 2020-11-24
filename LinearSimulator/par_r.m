function ABCD=par_r(f,value)
%Parallel Resistor to GND
%ABCD=par_r(f,value)
%Note that f isn't really used for anything, it is just included for 
%consistency.
%Also note that "value" can be a vector of length(f), for example, to
%make a series RC = 200ohms - 100pF to GND, you could use:
%  ABCD{n}=par_r(f,200 + 1./(2.*pi.*f.*100e-12))

if length(value)==1,
    ABCD=repmat([1 0 1/value 1],length(f),1);
else
    ABCD=repmat([1 0 -99 1],length(f),1);
    ABCD(:,3)=1./value;
end

