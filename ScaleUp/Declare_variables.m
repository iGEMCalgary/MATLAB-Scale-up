%Creates a structure array with the inputed values
%Cofactor concentration inputs and EDTA type dechalator is not included
%either
%Cycling is not included yet 
% author: Sebastian Alvarez
% version 1.1
% since July 16th 2019
% changes: Sebastian Alvarez 

S = [6 0 2 0 0]; %ChlB HdChLA ChlA PhyA PhoA 
E = [10 10 10 10]; %
K = [8.44 12.5 6 15]; %Km 
k = [0.000444 0.0015 0.005 0.001]; %kcat
Temp = 308; %K
pH = 7.0;
tspan = [0 10000];  

options = odeset('NonNegative', 1:5); 

values.title = 'Values for current test' ; 
values.date = datetime; 
values.S = S; 
values.E = E; 
values.K = K; 
values.k = k; 
values.tspan = tspan; 
values.Temp = Temp; 
values.pH = pH; 
values.options = options; 
save('values.mat','values'); 