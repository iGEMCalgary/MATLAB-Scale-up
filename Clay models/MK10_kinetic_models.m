%Function set for different kinetic models 

function kin_model = MK10_kinetic_models(time,MK10_concentration) 
kin_model = zeros(3,1); 

%PFO: pseudo first order 
kin_model(1,1) = MK10_kinetic_constant(1)*(MK10_equil_value - MK10_concentration(1));

%PSO: pseudo second order
kin_model(2,1) = MK10_kinetic_constant(2)*(MK10_equil_value - MK10_concentration(2))^2 ;

% Elovich model - assumes rate of adsorption Elovich
% MK10_rate(3,1) = MK10_kinetic_constant(2)*(MK10_equil_value - MK10_concentration(2))^2 ;  

end
