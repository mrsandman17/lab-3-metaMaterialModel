function ABCD=par_c(f,value)
%Parallel Capacitor to GND
%ABCD=par_c(f,value)

    ABCD=repmat([1 0 -99 1],length(f),1);
    ABCD(:,3)=(1i.*f.*2.*pi.*value);

