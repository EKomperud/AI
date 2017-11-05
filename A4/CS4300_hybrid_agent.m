function action = CS4300_hybrid_agent(percept)
% CS4300_hybrid_agent - hybrid random and logic-based agent
% On input:
%   percept( 1x5 Boolean vector): percepts
% On output:
%   action (int): action selected by agent
% Call:
%   a = CS4300_hybrid_agent([0,0,0,0,0]);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

persistent KB;
if isempty(KB)
    KB = CS4300_gen_KB;
end
persistent t;
if isempty(t)
   t = 0; 
end
persistent plan;

end

