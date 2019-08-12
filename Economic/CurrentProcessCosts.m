% Economic Costs of Current Acid Activated Clay Method
% author: Jean-David Rousseau
% version 1.0
% Last updated Aug 8th 2019

% clear all
close all

cost_of_clay_tonne = 300 * 0.907185; % USD per ton * tonne/ton
cost_of_clay_shipping = 2000; % USD per Container (20 tonnes)
cost_of_clay = cost_of_clay_shipping + 20 * cost_of_clay_tonne; % Price for 20 tonnes


estimated_cost = cost_of_clay;
cost_refinery = estimated_cost*1.15; %add utilities

% Bleaching. Adsorptive bleaching is performed with 1–3% of acid-activated clays 
% to remove colored components, metals, and phospholipids. 
% Oil is mixed with clay at 100 °C under vacuum for up to 30 min at 10–15% moisture, 
% and then clay is removed by filtration. Chlorophyls will be reduced to below 0.05 mg kg?1. 
% Other adsorbents are rarely used for canola oil.

% with assumption of 2%v acid activated clays, we can then say 20 tonnes
% can process 1000 tonnes of oil
% which, coincidentally, is approx what a plant can process per day

% price of canola oil is cross-elastic with palm and soybean oil, and is
% elastic with itself.
price_seed = 531.86; % CAD/tonne %needs to be changed to show by grade if that can be found

% approx 33% of seed becomes oil, 66% into meal
price_meal = 354.23; %CAD/tonne

volume_seed = 3000; %tonne
volume_meal = volume_seed*2/3; %tonne
volume_oil_crude = volume_seed/3; % tonne no source
volume_oil_RBD = volume_oil_crude*0.8; % tonne no source

% based on futures market on  
% https://www.cmegroup.com/trading/agricultural/grain-and-oilseed/soybean-oil.html
% which is then added with 10-12Cad for a BASIS
price_oil_CME = 27; % CAD/100lbs
price_oil_basis = 11; % CAD/100lbs
price_oil_crude = (price_oil_CME + price_oil_basis) * 19.684; % CAD/tonne

price_oil_RBD = 1273.30; % India price converted to CAD/tonne

revenue_crush=price_meal*volume_meal;
profit_crush_green = revenue_crush-price_seed*volume_seed;
profit_crush_y = profit_crush_green+volume_oil_crude*volume_oil_crude;
revenue_refine = price_oil_RBD*volume_oil_RBD;
% profit_refine = revenue_refine-cost_refinery- price_oil_crude*volume_oil_crude;
profit_refine = revenue_refine*0.03; % assume 3% profit until more data feeds in
