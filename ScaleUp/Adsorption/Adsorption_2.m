close all;

% Number of points
Nz = 50;
z = linspace(0,1,Nz+1);
dx = 1/Nz;

%Constants
A=1;
B=1;
D=1;
E=1;
Cifeed=1;

% Set final time
tfinal = 1;

% Set timestep
dt = 0.001;

% Set initial condition

%cond1 = diff(Ci(0,t),0) == v/Dazi*(Ci-Cifeed); %z=0
syms Ci(z)
syms A B
ode = diff(Ci,z)==A*Ci-A*B;
ySol(z) = dsolve(ode);
disp(ySol);
Co = -A/B*(Ci-Cifeed);
t = 0;

Ci = zeros(Nz);




