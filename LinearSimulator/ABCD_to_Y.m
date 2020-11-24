function Y=ABCD_to_Y(ABCD)
%Convert ABCD parameters to Y parameters
%Y=ABCD_to_Y(ABCD)
% Y(:,1) = Y11
% Y(:,2) = Y12
% Y(:,3) = Y21
% Y(:,4) = Y22
a=size(ABCD);
Y=zeros(a(1),4);

for n=1:a(1),
    dABCD=ABCD(n,1)*ABCD(n,4)-ABCD(n,2)*ABCD(n,3);
    Y(n,1)=ABCD(n,4)/ABCD(n,2);
    Y(n,2)=-dABCD/ABCD(n,2);
    Y(n,3)=-1/ABCD(n,2);
    Y(n,4)=ABCD(n,1)/ABCD(n,2);
end

