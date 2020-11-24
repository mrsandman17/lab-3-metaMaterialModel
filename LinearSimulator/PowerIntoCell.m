function P=PowerIntoCell(ABCD_Cell,CellNumber,RMSVinput)
%This function calculates the power flowing into a cell.  RMSVinput is the
%input into the *first* cell of the cascade.  It must be in RMS volts (not
%peak volts).
%
%  P=PowerIntoCell(ABCD_Cell,CellNumber,RMSVinput)
%
%  Example:
%  Calculate power through resistor in network, by finding the power
%  flowing into the resistor minus the power flowing out of the resistor.
%  This is a circuit of (100pF + 100ohm) || 200pF || 500ohm
%  We're going to calculate the power flowing through the 100ohm resistor
%n=1;
%ABCD{n}=ser_c(f,100e-12);  n=n+1;               %1
%ABCD{n}=ser_r(f,100);  n=n+1;                   %2
%ABCD{n}=par_c(f,200e-12);  n=n+1;               %3
%ABCD{n}=par_r(f,500);  n=n+1;                   %4
%
%Pone=PowerIntoCell(ABCD,2,RMSTmit);     %Calculate power flowing into
%100ohm resistor
%
%Ptwo=PowerIntoCell(ABCD,3,RMSTmit);     %Calculate power flowing out of
%100ohm resistor (power flowing into parallel combination of 200pF ||
%500ohm)
%
%Now the power dissipated in the 100ohm resistor
%PowerDissipated = Pone-Ptwo;
%

Z=ImpedanceIntoCell(ABCD_Cell,CellNumber);      %Find the impedance looking into the cell
V=VoltageAtCell(ABCD_Cell,CellNumber).*RMSVinput;  %Voltage at the cell

%Calculate the complex power = |V/Z|^2 * real(Z)
P=(abs(V./Z)).^2.*real(Z);
