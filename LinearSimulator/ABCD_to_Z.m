function Z=ABCD_to_Z(ABCD)
%Convert ABCD parameters to Z parameters
% Z=ABCD_to_Z(ABCD)
% Z(:,1) = Z11
% Z(:,2) = Z12
% Z(:,3) = Z21
% Z(:,4) = Z22
a=size(ABCD);
Z=zeros(a(1),4);

for n=1:a(1),
    dABCD=ABCD(n,1)*ABCD(n,4)-ABCD(n,2)*ABCD(n,3);
    Z(n,1)=ABCD(n,1)/ABCD(n,3);
    Z(n,2)=dABCD/ABCD(n,3);
    Z(n,3)=1/ABCD(n,3);
    Z(n,4)=ABCD(n,4)/ABCD(n,3);
end

