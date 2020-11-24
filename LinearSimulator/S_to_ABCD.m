function [f,ABCD]=S_to_ABCD(S_Params,Z0)
%Convert 2-port scattering parameters to ABCD parameters
%Usage:
%  S_to_ABCD(S_Params,Z0)
%  Where:
%   Z0 *must* be real!
%   S_Params = structure with following setup:
s11=S_Params.s11;
s12=S_Params.s12;
s21=S_Params.s21;
s22=S_Params.s22;

A=((1+s11).*(1-s22)+s12.*s21)./(2.*s21);
B=Z0.*((1+s11).*(1+s22)-s12.*s21)./(2.*s21);
C=1./Z0.*((1-s11).*(1-s22)-s12.*s21)./(2.*s21);
D=((1-s11).*(1+s22)+s12.*s21)./(2.*s21);

f=S_Params.f;
ABCD(:,1)=A;
ABCD(:,2)=B;
ABCD(:,3)=C;
ABCD(:,4)=D;