function ABCD=parallel_combine(ABCD1,ABCD2)
%This function takes two ABCD matrices, and combines them in parallel using
%Y matrices.  The inputs must not be cells -- they must be standard
%matrices.  
%  ABCD=parallel_combine(ABCD1,ABCD2)
%
%For example, to make a parallel/cascade connection,
%    Z1           Z2                     Z3              Z4
%  300ohms + ((100ohms + 100pF) || (200ohms + 200pF)) + 400ohms
%
%  f=logspace(5,9,10e3);
%  ABCD_Z2{1} = ser_r(f,100);
%  ABCD_Z2{2} = ser_c(f,100e-12);
%  ABCD_C_Z2 = cascade_combine(ABCD_Z2);
%
%  ABCD_Z3{1} = ser_r(f,200);
%  ABCD_Z3{2} = ser_c(f,200e-12);
%  ABCD_C_Z3 = cascade_combine(ABCD_Z3);
%
%  ABCD_C = parallel_combine(ABCD_C_Z2,ABCD_C_Z3);
%
%  ABCD{1} = ser_r(f,300);
%  ABCD{2} = ABCD_C;
%  ABCD{3} = ser_r(f,400);
%
%  ABCD_C_Final = cascade_combine(ABCD);



Y1=ABCD_to_Y(ABCD1);
Y2=ABCD_to_Y(ABCD2);

Y=Y1+Y2;

ABCD=Y_to_ABCD(Y);