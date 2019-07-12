%Determines k value based on temperatures.
%Coleslaw_final setup_model_1 "CFM1"
% author: Sebastian Alvarez
% version 1.0
% since July 11th 2019
% changes: Jean-David Rousseau

function [k] = TempToKVal(~)
% hardcoded values cuz tests
Tmin = 303;
Tmax = 333;
Tswitch = 323;
Ea = 400;
A = 1;
kd = -5.85154*10^-6;
Eo = 6;
R = 8.314;
t = 1000;

% growth
Tg = linspace(Tmin,Tswitch);
v1 = A*Eo*exp(-Ea./(R.*Tg)); 
% decay
Td = linspace(Tswitch,Tmax);
v2 = A*Eo*exp(-Ea./(R.*Td)+kd*t); 

figure
plot(Tg,v1,Td,v2);
xlabel('Temperature');
ylabel('Vmax'); 
title('Enzyme at temp'); 
end