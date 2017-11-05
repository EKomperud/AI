function mean = CS4300_driver2(n)
% CS4300_driver2 - driver for collecting data from AC agent
%   Runs the agent n times.
% On input:
%   n = number of trials to run
% On output:
%   mean = mean success rate
% Call:
%   a = CS4300_driver2(n);
% Author:
%   Eric Komperud
%   u0844210
%   Fall 2017
%

data = zeros(1,n);
mean = 0;

for i = 1:n
   trace = CS4300_WW2(25,'CS4300_agent_Astar_AC',0);
   final = trace(end);
   win = final.agent.x == 1 && final.agent.y == 1;
   data(n) = win;
   mean = mean + final.agent.climbed;
   clear CS4300_agent_Astar_AC
   clear CS4300_agent_Astar
end
mean = mean / n;
end

