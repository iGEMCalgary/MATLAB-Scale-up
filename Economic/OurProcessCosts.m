% static lab costs CAD/unit
centrifuge = 5000; 
hood = 15000;
SafetyGlasses = 2.60;
shower_eyewash = 858;
Lab_coat=37;
Emergency_lights=70;
Emergency_signs=74;
Chemical_storage_cabinet=603;
sharps_container=19;
SDSEnvelopes=26;
Fire_extinguisher_cabinet=66;
Fire_extinguisher_signs=35;

% Span80 surfactant
surfactant_cost_s = 1500; % USD/tonne
surfactant_cost_s = surfactant_cost_s * 1.3; % CAD/tonne

% Tween80 surfactant
surfactant_cost_t = 5; % USD/kg
surfactant_cost_t = surfactant_cost_t*1300; % CAD/tonne

% oil
price_oil_crude = (28 + 11) * 19.684; % CAD/tonne

% Organic phase is 0.2g Tween, 1.8g Span, 38g oil in experiment
price_organic = 0.2/40*surfactant_cost_t+1.8/40*surfactant_cost_s+38/40*price_oil_crude; %CAD/tonne

% water
water_cost = 52500/10000000; % USD/Gal
water_cost_L =water_cost/3.785*1.3; % CAD/L
water_cost = water_cost_L*1000; % CAD/tonne

% protein
% growing1 - first add WSCP plasmid to BL21 then incubate in 1L of LBmedium
% at 37C. wait. add 1mM IPTG. grow at 30C. Centrifuge at 5000 for 10min at
% 4C. dissolve in binding buffer(100mM phospshate buffer or 50mM Tris, 500mM NaCl, 5mM EDTA)
% sonicate on ice (30 sec on 5x, 250ml LB medium, spin at 12000g for 30min
% at 4C. Purify affinity chromatography. Use purified WSCP with 50mM
% phosphate buffer. protein should be 0.5-1mg per 1mL buffer.
IPTG_cost = 80; % CAD/g
Tryptone_cost = 80; %CAD/kg cheaper alibaba (50)
NaCl_cost = 20; %CAD/kg cheaper alibaba (15)
yeast_extract_cost = 240; %CAD/kg
LBMedia = water_cost_L*0.95 + Tryptone_cost*0.01 + NaCl_cost*0.01 + yeast_extract_cost * 0.005; % CAD/L


% growing2 - first add WSCP plasmid to BL21 then incubate in 250mL of LBmedium
% at 37C. wait. add 1mM IPTG. grow at 30C. Centrifuge at 5000 for 10min at
% 4C. dissolve in 1-2mL of 50mM sodium phosphate, sonicate (30sec 3x), 
% spin at 12000g for 30min at 4C. 0.125ml supernatant with 0.875ml of 50mM
% sodium phosphate. 

% emulsion - 5ml oil/surfactant, cooled on ice, mixed well. 1mL ice-cold
% aqueous phase. mix thoroughly. DARKNESS. add 20uL of 25mM Chl a. Mix.
% wait 1-2h on ice, Separate then add 1mL mineral oil until pure. Add 1mL
% diethyl ether. separate 14000 g 5min at room temp. let diethyl ether
% evaporate. 

% buying
AA_cost = 3; % CAD/AA
tetramer_cost = 4*180*AA_cost; % CAD/tetramer

weight_monomer = 3.25131774E-23; % g
weight_tetramer = weight_monomer*4000000; % ton/tetramer

protein_cost = tetramer_cost/weight_tetramer; % CAD/ton
% concentration of protein