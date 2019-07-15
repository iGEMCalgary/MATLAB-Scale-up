% Solve ODE set for CFM1 with inputed conditions 
clc; 
load('values.mat');

% get reaction 1 solved
[t,y] = ode45(@(t,y)CFM1(t,y,values.E,values.K,values.k,values.Temp,values.pH),values.tspan,values.S,values.options);

%save values at 95% (assume only chb,chb-fancy, and cha get changed)
cell_95=Xforlvl95(y(:,3),1);
values.S = y(cell_95,:);

% get reaction 2 solved
[t2,y2] = ode45(@(t2,y2)CFM1_2(t2,y2,values.E,values.K,values.k,values.Temp,values.pH),values.tspan,values.S,values.options);

figure 
subplot(2,1,1)
plot(t,y(:,1),'b',t,y(:,2),'k',t,y(:,3),'g');
legend('Chlorophyll b', '7-Hydroxymethyl chlorophyll a', 'Chlorophyll a')
xlabel('time(s)'); 
ylabel('[Species](uM)'); 
title('Reaction Vessel 1 at given conditions'); 

subplot(2,1,2)
plot(t2,y2(:,3),'g',t2,y2(:,4),'c',t2,y2(:,5),'r');
legend('Chlorophyll a', 'Pheophytin', 'Pheophorbide')
xlabel('time(s)'); 
ylabel('[Species](uM)'); 
title('Reaction Vessel 2 at given conditions'); 

set(legend,'Location','northeast'); 