function ABCD=ser_c(f,value)
%Series Capacitor
%ABCD=ser_c(f,value)

    ABCD=repmat([1 -99 0 1],length(f),1);
    ABCD(:,2)=1./(1i.*f.*2.*pi.*value);
