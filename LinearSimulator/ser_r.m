function ABCD=ser_r(f,value)
%Series resistor
%ABCD=ser_r(f,value)
%Note that f isn't really used for anything, it is just included for 
%consistency.
%Also note that "value" can be a vector of length(f), for example, to
%make a parallel RC = 200ohms - 100pF in series with the circuit, you could 
%use:
%  Z=1./(2.*pi.*f.*100e-12)
%  ABCD{n}=ser_r(f,200.*Z./(200+Z))


if length(value)==1,
    ABCD=repmat([1 value 0 1],length(f),1);
else
    ABCD=repmat([1 -99 0 1],length(f),1);
    ABCD(:,2)=value;
end

