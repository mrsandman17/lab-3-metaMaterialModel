function ABCD=tform(f,value)
% This is an ideal transformer, ratio VALUE:1.  That means that from the
% left to the right, VALUE > 1 is step down, and VALUE < 1 is step up
%  ABCD=tform(f,value)

    ABCD=repmat([value 0 0 1./value],length(f),1);
    

