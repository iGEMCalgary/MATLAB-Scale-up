% Economic Costs of Protein production
% author: Jean-David Rousseau
% version 1.0
% Last updated July 26th 2019

% clear all
close all
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
afiinity_chrom_5ml = 200;

% Span80 surfactant
surfactant_s = 1500; % USD/tonne
surfactant_s = surfactant_s * 1.3; % CAD/tonne

% Tween80 surfactant
surfactant_t = 5; % USD/kg
surfactant_t = surfactant_t*1300; % CAD/tonne

% oil
price_oil_crude = (28 + 11) * 19.684; % CAD/tonne

% Organic phase is 0.2g Tween, 1.8g Span, 38g oil in experiment
price_organic = 0.2/40*surfactant_t+1.8/40*surfactant_s+38/40*price_oil_crude; %CAD/tonne

% water
water = 52500/10000000; % USD/Gal
water_L =water/3.785*1.3; % CAD/L
water = water_L*1000; % CAD/tonne

% protein
% growing1 - first add WSCP plasmid to BL21 then incubate in 1L of LBmedium
% at 37C. wait. add 1mM IPTG. grow at 30C. Centrifuge at 5000 for 10min at
% 4C. dissolve in binding buffer(100mM phospshate buffer or 50mM Tris, 500mM NaCl, 5mM EDTA)
% sonicate on ice (30 sec 5x), 250ml LB medium, spin at 12000g for 30min
% at 4C. Purify affinity chromatography. Use purified WSCP with 50mM
% phosphate buffer. protein should be 0.5-1mg per 1mL buffer.
IPTG = 80; % CAD/g
Tryptone = 80; %CAD/kg cheaper alibaba (50)
NaCl = 20; %CAD/kg cheaper alibaba (15)
yeast_extract = 240; %CAD/kg
LBMedia = water_L*0.95 + Tryptone*0.01 + NaCl*0.01 + yeast_extract * 0.005; % CAD/L
ice = water_L*1.1; %CAD/L

Sodiumphosphatedibasicheptahydrate=290; % CAD/kg
Sodiumphosphatemonobasicmonohydrate=256; % CAD/kg
phosphate_buffer_100 = water_L * 0.95 + Sodiumphosphatedibasicheptahydrate*0.017846 + Sodiumphosphatemonobasicmonohydrate*0.004611; %CAD/L
phosphate_buffer_50 = water_L * 0.95 + Sodiumphosphatedibasicheptahydrate*0.017846/2 + Sodiumphosphatemonobasicmonohydrate*0.004611/2; %CAD/L
Tris_base = 145; % CAD/kg
HCl = 500; % CAD/L
Tris_buffer = water_L* 0.9 + Tris_base*0.00606 + HCl*0.01; 
EDTA = 125; % CAD/kg
%30g/L NaCl, 1.46g/L EDTA, buffer
binding_buffer_phosphate = NaCl *0.03 + EDTA*0.00146 + phosphate_buffer_100; % CAD/L
binding_buffer_Tris = NaCl *0.03 + EDTA*0.00146 + Tris_buffer; % CAD/L

%price of growing per procedure, does not include cold, static costs, centrifugation, sonicate.
growth_cost_L = 1.25*LBMedia +ice + 0.001*IPTG + binding_buffer_Tris*0.01; %CAD/L

% Theoretical maximum yield for a 1 liter(LB) E. coli culture (109 cells /ml) if protein of interest is:
% 0.1% of total protein: 150 µg/liter
% 2.0% of total protein: 3 mg/liter (our assumption)
% 50.0% of total protein: 75 mg/liter
OurProt_LB_yield = 3; %mg/L
OurProt_LB_yield = 10^9 / OurProt_LB_yield; %L medium/tonne

growth_cost = growth_cost_L*OurProt_LB_yield; %CAD/tonne protein

% cost of purification
buffer_hplc = 7.5; % FAKE VALUE %CAD/L
hplc_yield = 40; % 40mg/mL so 40g/L so kg/25L so tonne/25 000L buffer
buffer_hplc = buffer_hplc*1000000/hplc_yield; %CAD/tonne of protein produced (just in buffer)

isolation_cost = 1000000*phosphate_buffer_50+ buffer_hplc + growth_cost;

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
AA = 3; % CAD/AA
tetramer = 4*180*AA; % CAD/tetramer

weight_monomer = 3.25131774E-23; % g
weight_tetramer = weight_monomer*4000000; % ton/tetramer

protein = tetramer/weight_tetramer; % CAD/ton

world_money = 104000000000000;

lol = protein/world_money; %160 000x the worlds money supply

% Where does our project fit in?
%Base assumptions, refinery operates at a 3% profit, given this, we
%extrapolate that we have 30000$/day to work with. Given this information we
%can then assume the process costs based on published values of utilities,
%from there we can see what is our target lost protein/MT yOIL produced
%using enzymes is likely a viable process as industrial enzymes are used in
%the degumming process (Phospholipase A1) of processing canola, so we must transform our
%product into what will likely be an immobilized enzyme solution

%first off the cost of the facility add-on for our project to work in. 
profit_day = 25000; %cad/day
cost_add_on = 10000000; %Cad
cost_add_utilities = 7.5; %CAD/MT
tonnes_day = 1000; %large facility
%assume our process lets refineries reduce cost by reducing the amount of
%heat they need to use for the clays. assumption is 0.5% of PROFITS
profit_day = 1.005*profit_day;
interest_investment = 0.05; %assume 5% interest rate yearly
interest_investment = interest_investment/365; % get daily rate
cost_operation = 65000*4; %pay for 4 people at a decent salary for the add-on, per yr
cost_operation = cost_operation/365;
protein_cost = 5000000; %CAD/tonne
protein_lost = 0.001; %tonnes lost/ tonnes yOIL  produced
%this relationship to figure out time to reimbursment can be simply
%explained as linear relationships. left to reimburse =
%gain/day*day+initial investment
gain_per_day = profit_day - cost_add_utilities*tonnes_day - cost_operation;
days = linspace(0,1000000, 1000001);
% recycle_0 = zeros(10000,1);
% recycle_10th = zeros(10000,1);
% recycle_100th = zeros(10000,1);
% recycle_1000th = zeros(10000,1);
recycle = zeros(1000000,4);
for i=days
    if(i<1)
        %base case
        recycle(1,1)=-cost_add_on;
        recycle(1,2)=-cost_add_on;
        recycle(1,3)=-cost_add_on;
        recycle(1,4)=-cost_add_on;
    elseif(i<2)
        %need to calculate based on remainder for interest
        recycle(i+1,1)=gain_per_day*(i+1)-cost_add_on - (i+1)*protein_cost;
        recycle(i+1,2)=gain_per_day*(i+1)-cost_add_on - (i+1)*protein_cost/1000;
        recycle(i+1,3)=gain_per_day*(i+1)-cost_add_on - (i+1)*protein_cost/300;
        recycle(i+1,4)=gain_per_day*(i+1)-cost_add_on - (i+1)*protein_cost/500;
    else
        %need to calculate based on remainder for interest
        recycle(i+1,1)=gain_per_day*(i+1)-recycle(i,1)*interest_investment-cost_add_on - (i+1)*protein_cost/1;
        recycle(i+1,2)=gain_per_day*(i+1)-recycle(i,2)*interest_investment-cost_add_on - (i+1)*protein_cost/1000;
        recycle(i+1,3)=gain_per_day*(i+1)-recycle(i,3)*interest_investment-cost_add_on - (i+1)*protein_cost/300;
        recycle(i+1,4)=gain_per_day*(i+1)-recycle(i,4)*interest_investment-cost_add_on - (i+1)*protein_cost/500;
    end
end

figure
hold off
plot(days, recycle) 
legend('no recycling','1/100 protein loss', '1/300 protein loss', '1/500 protein loss');
title('How much does our protein need to be recycled, assuming cost is similar to Insulin');
ylabel('Debt (CAD)');
xlabel('Time (Days)')
ylim([-20000000, 0]);
% Plotting
% https://studylib.net/doc/7258453/cost-of-enzymes
different_processes = {'Buying', 'Lab Method', 'Antibody 1bioreactor', 'Antibody 6bioreactors', 'Insulin', 'Immobilized Enzyme High', 'Immobilized Enzyme Low', 'Reg Enzyme High', 'Reg Enzyme Low' };
different_processes_sorted = categorical(different_processes);
y=[protein isolation_cost 192000000 156000000 25000000 5000000 500000 120000 50000 ];

figure
hold off
subplot(2,1,1)
bar(different_processes_sorted,y);
legend('cost per tonne');
set(gca, 'YScale', 'log');
title('Cost of Proteins per tonne, Using All Methods');
ylabel('Cost $/tonne logarithmic');

hold off
subplot(2,1,2)
different_processes_sorted = categorical(different_processes(3:end));
bar(different_processes_sorted,y(3:end))
legend('cost per tonne');
ylabel('Cost $/tonne');