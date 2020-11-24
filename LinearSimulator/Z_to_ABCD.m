function ABCD=Z_to_ABCD(Z)
%Convert Z parameters to ABCD parameters
%
%  ABCD=Z_to_ABCD(Z)
%
% Z(:,1) = Z11
% Z(:,2) = Z12
% Z(:,3) = Z21
% Z(:,4) = Z22

a=size(Z);
ABCD=zeros(a(1),4);

for n=1:a(1),
    ABCD(n,1)=Z(n,1)/Z(n,3);
    ABCD(n,2)=(Z(n,1)*Z(n,4) - Z(n,2)*Z(n,3))/Z(n,3);
    ABCD(n,3)=1/Z(n,3);
    ABCD(n,4)=Z(n,4)/Z(n,3);
end