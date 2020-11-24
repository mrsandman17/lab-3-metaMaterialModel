function ABCD=par_l(f,value)
%Parallel inductor to GND
%ABCD=par_l(f,value)

    ABCD=repmat([1 0 -99 1],length(f),1);
    ABCD(:,3)=1./(1i.*f.*2.*pi.*value);

