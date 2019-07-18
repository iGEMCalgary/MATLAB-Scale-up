%3E6 tonnes oil
%30ppm pigment crude, 0.1ppm pigment RBD, ppm = mg/L
% assumption: clay takes 60% of chlorophyll, our thing takes 40%, so we
% have to remove approx 100mg/L of chrophyll
chlorophyll_to_remove = 100; %mg/L
oil = 3*10^6; %tonne/yr

chlA_MM=893.5;%g/mol
chlB_MM=907.5;%g/mol
chl_MM = 0.6*chlB_MM + 0.4*chlA_MM;%g/mol

chlorophyll_to_remove = chlorophyll_to_remove /(1000*chl_MM); % mol/L
chlorophyll_to_remove = chlorophyll_to_remove * 1000; %mol/tonne

chl_mol = chlorophyll_to_remove*oil; %mol/yr

% we need 4x as much protein so
