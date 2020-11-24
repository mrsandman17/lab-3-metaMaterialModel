function ABCD=ser_l(f,value)
%Series Inductor
%ABCD=ser_l(f,value)

    ABCD=repmat([1 -99 0 1],length(f),1);
    ABCD(:,2)=1i.*f.*2.*pi.*value;

