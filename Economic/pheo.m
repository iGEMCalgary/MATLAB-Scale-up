% Benefits of pheophorbide processing
% author: Jean-David Rousseau
% version 1.0
% since August 24th 2019

%%
% Section 1 cost of pheophorbide
% As pheophorbide processing is done through enzymes, the use of
% immobilized enzymes can be used instead of washes and normal enzymes.
% Assumption 1, immobilized enzymes usage. between 500M and 5 MM per tonne
% We must know the size of the vessels in which we will be operating, as
% the HP person said, our system would likely be a side system, possibly
% before bleaching, in which we would sequester chloro then transfer the
% chloro into a sidesystem and then process it there will it undergoes
% bleaching. A major hurdle is also to make the depreciation cost be lower
% than the money made by conversion. 
enzyme_production_cost = [500000 5000000]; % cost of enzyme production
sequester = 1; % amount of chlor sequestered by the sequestration system. 
efficiency = 0.5; % efficiency of process based on assays.
cycles = 1; % number of cycles to get high quality pheo.
depreciation = 1; % decrease in efficieny over tiem?
investment = 100000000; %upfront cost of adoption
operations = 250000; % daily operational costs
percentage_ops = 0.05; % percentage based operational costs.

%%
% Section 2 Operating space of pheophorbide


%%
% Section 3 All together