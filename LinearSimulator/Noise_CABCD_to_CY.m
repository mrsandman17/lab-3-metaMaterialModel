function CY=Noise_CABCD_to_CY(CABCD,Y)
%Convert Noise Correlation ABCD matrices to Noise Correlation Y Matrices
%  CY=Noise_CABCD_to_CY(CABCD,Y)

for n=1:length(CABCD(:,1))
            TA = [-Y(n,1) 1; -Y(n,3) 0];
            CABCDM=[CABCD(n,1) CABCD(n,2); CABCD(n,3) CABCD(n,4)];
            CC = TA*CABCDM*TA';
            CY(n,:) = [CC(1,1) CC(1,2) CC(2,1) CC(2,2)];
end