% multicomponent Langmuir
% ""1"" qi=Qmi*bi*Ci/(1+[j=1,n]SUM(bj*Cj))
% qi = amount of component i adsorbed
% Qm,i = maximum adsorption capacity of component i. 
% b is the Langmuir constant  
% C is the adsorbate concentration of each components i,j, in a n-component solution.

% LDF approx ""2, 3""
syms Ci(z,t); % Ci is the concentration of the component i
syms qi(z,t); % qi is the concentration of component i on the adsorbent surface
syms v; % v is superficial fluid velocity
syms Dazi; % Dazi is the axial dispersion coefficient
syms eb; % eb is the bed porosity
syms rhop; % rhop is the density of the adsorbent
syms kovi;% kovi is the overall mass-transfer resistance
syms qsi;
syms Cifeed;
L=5;
ode1 = diff(Ci,t) == -1*v*diff(Ci,z)+Dazi*diff(Ci,z,2)-(1+-1*eb)/eb*rhop*diff(qi,t);
ode2 = diff(qi,t) == kovi*(qsi - qi);

% boundary conditions
cond1 = diff(Ci(0,t),0) == v/Dazi*(Ci-Cifeed); %z=0
cond2 = diff(Ci(L,t),L) == 0; %z=L
cond3 = Ci(z,0) == 0; %t=0
conds = [cond1 cond2 cond3];

% Solve

