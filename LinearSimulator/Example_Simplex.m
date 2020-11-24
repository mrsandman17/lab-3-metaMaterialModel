function Example_Simplex
%Simplex Optimizer Example:
%
%  Say we have measured an input impedance to a circuit, and we want to
%  match that input impedance to a circuit model.  The network analysis
%  routines combined with a Simplex optimizer is an efficient and accurate
%  method to accomplish a matched circuit model.  
%
%  Here, Jean-Luc Dellis's simplex alogorithm is used.  Search for
%  "simplexe" on Matlab's File Exchange.  The file is simplexe.m

%  Match to circuit:  R1 + C1 + (L1 || C2 || R2)  (only optimize for L1, C2
%  and R2)  R1=100ohm, C1=150pF.  We're shooting for the optimizer to find
%  that L1=1uH, C2=100pF, and R2=50ohms
%
%  The optimizer does great with this circuit as long as the resonance is
%  fairly damped.  Once it becomes "sharp" (or high Q), the optimizer gets
%  the wrong answer.  Try making R2=500 ohsm, and see that the answer is
%  wrong.  I believe this is due to a couple factors.  First, the imaginary 
%  to real ratio large, which adds difficults, and second there are 
%  probably multiple minima, which makes the simplex optimizer go off on 
%  the wrong route.


f=transpose(linspace(100e3,50e6,1e3));    %Set up the frequency vector, make it a column vector

z=model([1e-6,100e-12,50],f);   %This is the ideal circuit that we're going to try and optimize for
%z=model([1e-6,100e-12,500],f);   %Uncomment this to make the optimizer fail, set R2=500ohms, and make the resonance sharp
z(:,1)=z(:,1).*(1+0.05*randn(size(z(:,1))));  % We'll add some noise to make it hard
z(:,2)=z(:,2).*(1+0.05*randn(size(z(:,2))));  % We'll add some noise to make it hard

p=[0.1e-6,300e-12,10];   %Here's our initial guess, p=[L1,C2,R2] (not very good guesses!)
p=simplexe(@model,p,f,z);  %Now we'll have the simplex optimizer try and find the correct values for L1, C2 & R2

disp(sprintf('L= %0.3guH   C= %0.3gpF  R=%0.3gohms',p(1).*1e6,p(2).*1e12,p(3)));  %Print the values.

Zopt=model(p,f);  %This is the answer the optimizer found.


%Plot the results
figure(1)
subplot(2,1,1)
plot(f,z(:,1),'r',f,Zopt(:,1),'c');
legend('Original Z','Optimized Z')
ylabel('Real Input Impedance, ohms')
subplot(2,1,2)
plot(f,z(:,2),'r',f,Zopt(:,2),'c');
xlabel('Freq, Hz');
ylabel('Imaginary Input Impedance, ohms')


end


function z=model(p,f)
%Here's our model for the optimizer to use
n=1;
ABCD{n} = ser_r(f,100);  n=n+1;         %R1
ABCD{n} = ser_c(f,150e-12);  n=n+1;     %C1
ABCD{n} = par_l(f,p(1));  n=n+1;        %L1
ABCD{n} = par_c(f,p(2));  n=n+1;        %C2
ABCD{n} = par_r(f,p(3));  n=n+1;        %R2
ZZ=ImpedanceIntoCell(ABCD,1);
z = [10.*real(ZZ),imag(ZZ)];

end



