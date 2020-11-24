function S_Params = ABCD_to_S(f,ABCD,Zo)
%Convert ABCD matrix to Scattering Parameters.
% Usuage:  
% S_Params=ABCD_to_S(f,ABCD,Zo)
%  Where Zo *must* be real!
%  ABCD is in standard format described elsewhere
%  s11=S_Params.s11;
%  s12=S_Params.s12;
%  s21=S_Params.s21;
%  s22=S_Params.s22;

    S_Params.f=f;
    A=ABCD(:,1);
    A=rot90(A);
    B=ABCD(:,2);
    B=rot90(B);
    C=ABCD(:,3);
    C=rot90(C);
    D=ABCD(:,4);
    D=rot90(D);
    
    GG=A+B./Zo+C.*Zo+D;
    
    S_Params.s11=(A+B./Zo-C.*Zo-D)./GG;
    S_Params.s12=2.*(A.*D-B.*C)./GG;
    S_Params.s21=2./GG;
    S_Params.s22=(-A+B./Zo-C.*Zo+D)./GG;
    