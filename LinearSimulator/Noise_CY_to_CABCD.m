function CABCD=Noise_CY_to_CABCD(C,ABCD)
%Convert Noise Correlation Y Matrices to Noise Correlation ABCD matrices.
%  CABCD=Noise_CY_to_CABCD(C,ABCD)
%  where C is the Y matrix

for n=1:length(C(:,1))
            TY = [0 ABCD(n,2);1 ABCD(n,4)];            
            CY=[C(n,1) C(n,2); C(n,3) C(n,4)];
            CC = TY*CY*TY';
            CABCD(n,:) = [CC(1,1) CC(1,2) CC(2,1) CC(2,2)];
end
