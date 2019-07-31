clc; 
load('MK10_data.txt','param_PFO.mat','param_PSO.mat'); 

%declare model conditions
time = linspace(0,60);

figure('Name','test'); 
for i = 1:size(param_PFO.temps,2)
yFO = PFO_model(time,param_PFO.temps(i),param_PFO.q_max(i), param_PFO.k_arrh, param_PFO.Ea); 
hold on
plot(time,yFO)
end


%%
function chl_conc = PFO_model(time,Temp,ads_const,arrh_const,act_energy)
R = 8.314E-3;
chl_conc = ads_const*(1 - exp(-arrh_const*exp(-act_energy/(R*Temp))*time)); 
end

function chl_conc = PSO_model()
end






























