%Script to compute different variable variation tests 
% Coleslaw_final setup_model_1 "CFM1"
% author: Sebastian Alvarez
% version 1.0
% since July 16th 2019
clc;

%% Test [Chlorophyll b reductase] vs [T]  

Bounds = [0 30]; 
Scalation = 0.5;
load('values.mat');
index = 4; 
T_hold = [273 308 325 350];

figure('Name','Enzyme 1 variation test on CFM1, at different system temperatures')
for T_hold_i = T_hold
    hold on 
    Function = 'ode45(@(t,y)CFM1(t,y,[variable values.E(2) values.E(3) values.E(4)] ,values.K,values.k,'+string(T_hold_i)+',values.pH), values.tspan, values.S, values.options);';
    [inputs, results] = VarOf1Var(Bounds,Scalation,Function,values,index);
    plot(inputs,results);
end 
title('Chlorophyll a profile on different isotherms'); 
xlabel('[ChlB red](uM)')
ylabel('[ChlA] (uM)') 
legend(string(T_hold));






