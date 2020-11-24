function [p,z,v,itercount,func_evals]=simplexe(fun,p0,x,y)
% SIMPLEXE Multidimensional unconstrained nonlinear minimization (Nelder-Mead)
% This is a modified FMINSEARCH function in order to fit experimental data (x,y)

% SIMPLEXE starts at p0 and finds a local minimizer p of DISTANCE = {(fun(p,x)-y)/fun(p,x)}^2
% which may be user-defined at the end of this listing

%--------------------------------------------------------------------------
% 2 EXAMPLES are given at the end of this listing
% The first describes the fitting of a decreasing sinusoide.
% The second the fitting of complex data as found in Impedance Spectroscopy
% -------------------------------------------------------------------------


%**************** Output Arguments ****************************************
%****** p = best parameters                                     ***********
%****** z = values of DISTANCE computed at the simplex'vertices ***********
%****** v = vertices coordinates matrix                         ***********
%****** itercount = iterations count                            ***********
%****** func_evals = function evaluations count                 ***********

%**************** Input Arguments *****************************************
%****** fun = the function to fit to a data set                 ***********
%****** p0 = initial values of the function parameters          ***********
%****** x ,y = experimental data                                ***********


%************************* parameters number ******************************

 n= prod(size(p0)); 

%*********** initialisation des paramètres de l'algorithme ****************

rho = 1; % coefficient de reflexion%
chi = 2; % coefficient d expansion%
psi = 0.5;% coefficient contraction%
sigma = 0.5;%coefficient de shrinkage%

onesn = ones(1,n);
two2np1 = 2:n+1;
one2n = 1:n;
l=ones(length(x),1);

%********** matrice des coordonnées des sommets du simplex ****************
v = zeros(n,n+1); 

%********** vecteur de la fonction évalué au sommet du simplex ************
z= zeros(1,n+1);

%********** initialisation du simplex *************************************
v(:,1) = p0'; 
    ymod=feval(fun,p0,x);

z(:,1) =distance(ymod,y); 

%********* Following improvement suggested by L.Pfeffer at Stanford *******
  usual_delta = 0.05;       % 5 percent deltas for non-zero terms      
  zero_term_delta = 0.00025;% Even smaller delta for zero elements of x 
  
for j = 1:n
   t=p0';
   if t(j) ~= 0
      t(j) = (1 + usual_delta)*t(j);
   else 
      t(j) = zero_term_delta;
   end  
   v(:,j+1) = t;
  
   
    ymod=feval(fun,t,x);

   z(:,j+1) = feval(@distance,ymod,y);
end     

 %********** sort so v(1,:) has the lowest function value *****************
 
[z,j] = sort(z);
v = v(:,j);

%**********************************************************
% Main algorithm : Simplex Method
% Iterate until the diameter of the simplex is less than tolx
%   AND the function values differ from the min by less than tolf,
%   or the max function evaluations are exceeded. (Cannot use OR instead of AND.)


tolf=1e-12;           %précision sur les valeurs de la fonction%
tolx=1e-12;           %précision sur la dimension du simplexe%
maxiter=n*200;       %nombre maximal d itération%
maxfun=n*200;        %nombre maximal d' évaluation de la fonction%
func_evals =n+1;
itercount=1;

            
while func_evals < maxfun & itercount < maxiter
    
   if max(max(abs(v(:,two2np1)-v(:,onesn)))) <= tolx & max(abs(z(1)-z(two2np1)))<= tolf 
% Iterate until the diameter of the simplex is less than tolx
%   AND the function values differ from the min by less than tolf,
%   or the max function evaluations are exceeded. (Cannot use OR instead of AND.)      
 break
      
   end
  
   
   %xbar = average of the n (NOT n+1) best points
   hbar = sum(v(:,one2n), 2)/n;
   
   %calcul du point reflechi%
   hr = (1 + rho)*hbar - rho*v(:,end);
  
       ymod=feval(fun,hr,x);
  
   fxr = feval(@distance,ymod,y);
   func_evals = func_evals+1;
   
   if fxr < z(:,1)
       
      % Calcul du point d expansion%
      he = (1 + rho*chi)*hbar - rho*chi*v(:,end);
     
           ymod=feval(fun,he,x);
      
  
   fxe = feval(@distance,ymod,y);
      func_evals = func_evals+1;
      
      if fxe < fxr
          
          %expansion du simplex%
         v(:,end) = he;
         z(:,end) = fxe;
   
      else
          
          %relexion du simplex%
         v(:,end) = hr; 
         z(:,end) = fxr;
       
      end
      
   else % fv(:,1) <= fxr%
       
      if fxr < z(:,n)
          
          %reflexion du simplex%
         v(:,end) = hr; 
         z(:,end) = fxr;
        
      else
          
         % faire la contraction%
         if fxr < z(:,end)
             
            %point de conraction exterieur%
            hce = (1 + psi*rho)*hbar - psi*rho*v(:,end);
          
                ymod=feval(fun,hce,x);
  
            fxce = feval(@distance,ymod,y);
            func_evals = func_evals+1;
            
            if fxce <= fxr
                
                % contraction exterieur du simplex%
               v(:,end) = hce; 
               z(:,end) = fxce;
               
            else
               % faire le retrecisement %
                for j=two2np1
                   v(:,j)=v(:,1)+sigma*(v(:,j) - v(:,1));
           
                  ymod=feval(fun,v(:,j),x);
           
  
                 z(:,j) = feval(@distance,ymod,y);
                end
            func_evals = func_evals + n;
           
            end
         else
             
            %point de contraction interieur%
            hci = (1-psi)*hbar + psi*v(:,end);
         
              ymod=feval(fun,hci,x);
           
  
              fxci = feval(@distance,ymod,y);
             func_evals = func_evals+1;
            
            if fxci < z(:,end)
                
                %contraction interieur du simplex%
               v(:,end) = hci;
              z(:,end) = fxci;
              
            else
                
               % faire le retrecissement%

               for j=two2np1
                  v(:,j)=v(:,1)+sigma*(v(:,j) - v(:,1));
           
                  ymod=feval(fun,v(:,j),x);
           
                   z(:,j) = feval(@distance,ymod,y);
               end
               func_evals = func_evals + n;
            
            end
         end
         
      end
   end
   
   %recherche recherche  du minimal et du  maximal du simplexe%
   
   [z,j] = sort(z);
   v = v(:,j);
   itercount = itercount + 1;
end

%********************** fin  algorithme du simplexe *******************************

%***************** affichage de la convergence ou non******************************
if(itercount >= maxiter)
    disp('not convergence so p bad improve your initial parametres');
else
    if(func_evals >= maxfun)
    disp('not convergence so p is bad  improve your initial parametres')
    
      else
          disp('convergence so p is good ')
      end
  end
    %   determination des meilleurs parametres %
           p=v(:,1);
%********************************************************************************
%*********** fonction DISTANCE **************************************************
%********************************************************************************
               
function dist=distance(ymod,yexp)
dist=sum(sum(((ymod-yexp)./ymod).^2));     
% dist=sum(sum(((ymod-yexp)).^2));      



%--------------- EXAMPLE 1 -----------------------------------------------------
%******************************************************************************-
% These 2 first functions below are given as an example                 *******-
% Copy and save as a M-file, launch demo_simplexeA in the command window*******-
%******************************************************************************-
% function p=demo_simplexeA                                             *******-
% t=0:1e-3:1;                                  % vector time            *******-         
% s=model([1,2,3],t);                          % signal                 *******-
% s2=s.*(1+0.5*randn(size(t)));                % plus noise             *******-
% p=simplexe(@model,[1.5,1,3.3],t,s2);         % best parameters        *******-
% plot(t,s2,t,model(p,t),'r')                  % compare                *******-
%                                                                       *******-
% function s=model(p,t)                        % the decreasing         *******-
% s=p(1)*exp(-p(2)*t).*cos(2*pi*p(3)*t);       % sinusoide              *******- 
%******************************************************************************-
%--------------------------------------------------------------------

%--------------- EXAMPLE 2 ------------------------------------------
%******************************************************************************-
% These 2 first functions below are given as an example                 *******-
% Copy and save as a M-file, launch demo_simplexeA in the command window*******-
%******************************************************************************-
% function p=demo_simplexeB
% w=2*pi*logspace(1,6)';                        % vector pulsation           
% z=model([1e4,2e-9],w);                        % model = RC in parallel
% z(:,1)=z(:,1).*(1+0.05*randn(size(z(:,1))));  % plus noise
% z(:,2)=z(:,2).*(1+0.05*randn(size(z(:,2))));  % plus noise
% p=simplexe(@model,[1e3,2e-10],w,z);           % best paraleters 
% zm=model(p,w);
% plot(z(:,1),-z(:,2),'o',zm(:,1),-zm(:,2),'-*r'),axis equal% compare
% 
% function z=model(p,w)
% z1=p(1);                                      % a resistor (impedance)
% y2=j*p(2)*w;                                  % a capacitor(admittance)
% 
% y1=1./z1;
% y=y1+y2;                                      % R // C
% zthe=1./y;
% z=[real(zthe),imag(zthe)];
%******************************************************************************-
%-------------------------------------------------------------------------------

