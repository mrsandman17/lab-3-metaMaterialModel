function ABCD=Y_to_ABCD(Y)
%Convert Y parameters to ABCD parameters
%
%  ABCD=Y_to_ABCD(Y)
%
% Y(:,1) = Y11
% Y(:,2) = Y12
% Y(:,3) = Y21
% Y(:,4) = Y22

a=size(Y);
ABCD=zeros(a(1),4);

for n=1:a(1),
    ABCD(n,1)=-1*Y(n,4)/Y(n,3);
    ABCD(n,2)=-1/Y(n,3);
    ABCD(n,3)=-1*(Y(n,1)*Y(n,4)-Y(n,2)*Y(n,3))/Y(n,3);
    ABCD(n,4)=-Y(n,1)/Y(n,3);
end