%Mechanism Script for reaction vessel 1
%Coleslaw_final setup_model_1 "CFM1"
% author: Sebastian Alvarez
% version 1.0
% since July 11th 2019
% changes: Jean-David Rousseau

% :( 

function [dS] = CFM1(~,S,E,K,k,Temp,pH)
S1 = S(1); S2 = S(2); S3 = S(3); S4 = S(4); S5 = S(5); 
E1 = E(1); E2 = E(2); E3 = E(3); E4 = E(4);
K1 = K(1); K2 = K(2); K3 = K(3); K4 = K(4); 
k1 = k(1); k2 = k(2); k3 = k(3); k4 = k(4); 
T = Temp; 
H = pH; 

v1 = k1*exp(400*((1/308)-(1/T)))*(E1*S1)/(K1 + S1); 
v2 = k2*exp(700*((1/308)-(1/T)))*(E2*S2)/(K2 + S2); 
v3 = 0;
v4 = 0;

dS1 = -v1; 
dS2 = v1 - v2; 
dS3 = v2 - v3; 
dS4 = v3 - v4; 
dS5 = v4; 

dS(1,:) = dS1;
dS(2,:) = dS2;
dS(3,:) = dS3;
dS(4,:) = dS4; 
dS(5,:) = dS5; 
end