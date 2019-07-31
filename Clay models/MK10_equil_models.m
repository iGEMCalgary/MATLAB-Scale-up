%Function set for equilibrium models 
function q = MK10_equil_models(~,y) 
q = zeros(3,1); 
 
%PFO: pseudo first order 
q(1,1) = 4;

%PSO: pseudo second order
q(2,1) = 4;

%IPD: Inter-particle diffusion
q(3,1) = 4; 
end
