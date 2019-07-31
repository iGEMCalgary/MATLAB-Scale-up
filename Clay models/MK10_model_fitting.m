%% Fit equations to experimental data
clc; 
load('MK10_kin_data.txt');
load('MK10_equil_data.txt');  

%Equilibrium and Kinetic Model function handles are defined here 
LANG = @(Lang_const,Ce_value) Ce_value.*Lang_const(1).*Lang_const(2)./(1+Ce_value.*Lang_const(2).*1);
PFO = @(PFO_const, qt_times) PFO_const(1).*(1-exp(-PFO_const(2).*qt_times)); 
PSO = @(PSO_const, qt_times) qt_times./((1/(PSO_const(1)^2*PSO_const(2))) + (qt_times./PSO_const(1)));
ARRH = @(ARRH_const,temp) ARRH_const(1).*exp(-ARRH_const(2)./(gas_const*temp));

%Inputting data into discrete sets 
qe_results = zeros(size(MK10_equil_data,1),size(MK10_equil_data,2)); 
qt_results = zeros(size(MK10_kin_data,1),size(MK10_kin_data,2)-1);
qt_times = MK10_kin_data(:,1); 
initial_guess = [1 1]; 

%fix temperature dependance here - make it so that it takes the temperature
%directly from the data
Temp = [100 110 120]; %C
Temp = (Temp + 273.15).'; 
gas_const = 8.314E-3; %KJ/molK

for i = 2:size(MK10_kin_data,2)
    qt_results(:,i-1) = MK10_kin_data(:,i);
end

%Looping algorithm to fit Langmuir and Freundlich equilibirum models
%still need to add the freundlich model 

for i = 1:(size(MK10_equil_data,2)-1)/2
    Ce_values(:,i) = MK10_equil_data(:,2*i); 
    qe_values(:,i) = MK10_equil_data(:,2*i+1);
    LANG_equil_consts(i,:) =  lsqcurvefit(LANG,[1000 1],Ce_values(:,i),qe_values(:,i));
end

%Looping algorithm to fit PFO and PSO kinetic equations to kinetic data
%Fix initial guesses to get closer results 
for i = 1:size(qt_results,2) 
    %kin_const(1) is adsorption capacity & kin_const(2) is rate constant
    PFO_kin_consts(i,:) = lsqcurvefit(PFO,initial_guess,qt_times,qt_results(:,i));
    PSO_kin_consts(i,:) = lsqcurvefit(PSO,initial_guess,qt_times,qt_results(:,i));
end

%Fits kinetic parameters to arrhenius relation 
PFO_ARRH_consts = lsqcurvefit(ARRH,initial_guess,Temp,PFO_kin_consts(:,2));
PSO_ARRH_consts = lsqcurvefit(ARRH,initial_guess,Temp,PSO_kin_consts(:,2)); 

%% plots equations and values

param_LANG.title = 'Fitted equilibrium parameters for Langmuir Isotherm model'; 
param_LANG.temps = Temp.'; 
param_LANG.qmax = LANG_equil_consts(:,1).'; 
param_Lang.KL = LANG_equil_consts(:,2).'; 
save('param_Lang.KL','param_Lang'); 

param_PFO.title = 'Fitted Kinetic Parameters for Pseudo-first-order model'; 
param_PFO.temps = Temp.'; 
param_PFO.q_max = PFO_kin_consts(:,1).'; 
param_PFO.k_rate = PFO_kin_consts(:,2).';
param_PFO.k_arrh = PFO_ARRH_consts(1); 
param_PFO.Ea = PFO_ARRH_consts(2); 
save('param_PFO.mat','param_PFO');

param_PSO.title = 'Fitted Kinetic Parameters for Pseudo-Second-Order model'; 
param_PSO.temps = Temp.'; 
param_PSO.q_max = PSO_kin_consts(:,1).'; 
param_PSO.k_rate = PSO_kin_consts(:,2).';
param_PSO.k_arrh = PSO_ARRH_consts(1); 
param_PSO.Ea = PSO_ARRH_consts(2); 
save('param_PSO.mat','param_PSO');

figure('Name','Fitting Results'); 
subplot(2,1,1);
for i =1:3
    hold on 
    plot(Ce_values(:,i),qe_values(:,i),'.')
    plot(Ce_values(:,i),LANG(LANG_equil_consts(i,:),Ce_values(:,i)))
    hold off
end 
subplot(); 

%% Notes
%{
ADD: 
add plotting of all models - equilibrium and kinetics 
Add R^2 and R values 
fix plot looping & add labels to graphs 
%}