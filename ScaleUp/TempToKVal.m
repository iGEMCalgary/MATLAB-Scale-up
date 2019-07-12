%Determines k value based on temperatures.
%Coleslaw_final setup_model_1 "CFM1"
% author: Sebastian Alvarez
% version 1.0
% since July 11th 2019
% changes: Jean-David Rousseau

% function [k] = TempToKVal(~)
% % hardcoded values cuz tests
% Tmin = 303;
% Tmax = 333;
% Tswitch = 323;
% Ea = 400;
% A = 1;
% kd = -5.85154*10^-6;
% Eo = 6;
% R = 8.314;
% t = 1000;
% 
% % growth
% Tg = linspace(Tmin,Tswitch);
% v1 = A*Eo*exp(-Ea./(R.*Tg)); 
% % decay
% Td = linspace(Tswitch,Tmax);
% v2 = A*Eo*exp(-Ea./(R.*Td)+kd*t); 
% 
% figure
% plot(Tg,v1,Td,v2);
% xlabel('Temperature');
% ylabel('Vmax'); 
% title('Enzyme at temp'); 
% end

% xrun = [0 10000];
% work = 6*exp(-((72.17*xrun.^-1)+(200./(exp(-(288.67.*xrun.^-1))))));
% plot(xrun,work,'r'); 

clc; 
T = linspace(273,600);
t = 600; 
R = 1.987E-3; %check this
Eo = 10;
Ed = 5; 
Ad = 5; 
Ea = 4; 
Aa = 1;

kd = Ad*exp(-Ed./(T.*R));
E = Eo*exp(-kd*t);
v = Aa*E.*exp(-Ea./(T.*R));
plot(T,v,'r'); 

