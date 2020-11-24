function ABCD_Flip=flip_ABCD(ABCD)
%This function flips a ABCD matrix.  ABCD is a matrix not a cell.
% The input side of the matrix becomes the output side and the output side
% becomes the input side.
% ABCD_Flip=flip_ABCD(ABCD)
%
%Example Find the output imepdance of the circuit below:
% ABCD{1} = par_r(1:10,100);
% ABCD{2} = ser_r(1:10,300);
% ABCD{3} = par_r(1:10,1000);
% ABCD{4} = par_r(1:10,2000);
% ABCD_C=cascade_combine(ABCD);
% ABCD_Flip = flip_ABCD(ABCD_C);
% Z=ABCD_Flip(:,1)./ABCD_Flip(:,3) = 
%  = 2k || 1k || (300 + 100) = 1/(1/2k + 1/1k + 1/400) = 250



for n=1:length(ABCD),
    denom_raw = ABCD(n,1) .* ABCD(n,4) - ABCD(n,2) .* ABCD(n,3);
    ABCD_Flip(n,1) = ABCD(n,4) ./ denom_raw;
    ABCD_Flip(n,2) = -(-ABCD(n,2) ./ denom_raw);  %Flip current (I) signs ...
    ABCD_Flip(n,3) = -(-ABCD(n,3) ./ denom_raw);
    ABCD_Flip(n,4) = ABCD(n,1) ./ denom_raw;
end

