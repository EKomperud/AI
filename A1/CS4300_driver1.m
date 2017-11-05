function results = CS4300_driver1(n)
% CS4300_driver1 - driver for collecting data from random agent
%   Runs the agent n times.
% On input:
%   n = number of trials to run
% On output:
%   results (1x3 array):
%     (1,1): Mean
%     (1,2): Variance
%     (1,3): Gold Success Rate
% Call:
%   a = CS4300_agent1(n);
% Author:
%   Eric Komperud
%   u0844210
%   Fall 2017
%

data = zeros(n,2);
mean = 0;
variance = 0;
goldSuccessRate = 0;
goldVariance = 0;

for i = 1:n
   trace = CS4300_WW2(100,'CS4300_agent1',0);
   data (i,1) = trace(1,end).agent.steps;
   data (i,2) = trace(1,end).agent.gold;
   mean = mean + data(i,1);
   goldSuccessRate = goldSuccessRate + data(i,2);
end
mean = mean / n;
goldSuccessRate = goldSuccessRate / n;

for i = 1:n
    variance = variance + ( data(i,1) - mean )^2;
    goldVariance = goldVariance + (data(i,2) - goldSuccessRate)^2;
end
variance = variance / n;
standardDeviation = sqrt(variance);
confidenceInterval = (1.96 * (standardDeviation / sqrt(n)));

goldVariance = goldVariance / n;
goldSD = sqrt(goldVariance);
goldCI = (1.96 * (goldSD / sqrt(n)));

results = [mean, variance, confidenceInterval , goldSuccessRate, goldCI];

