function [policy, unchanged] = CS4300_MDP_policy(S,A,P,U,Pepis)
% CS4300_MDP_policy - generate a policy from utilities
% See p. 648 Russell & Norvig
% On input:
%   S (vector): states (1 to n)
%   A (vector): actions (1 to k)
%   P (nxk struct array): transition model
%       (s,a).probs (a vector with n transition probabilities
%       from s to s_prime, given action a)
%   U (vector): state utilities
%   Pepis (vector): An existing policy to try and beat (1 to n)
% On output:
%   policy (vector): actions per state
% Call:
%   p = CS4300_MDP_policy(S,A,P,U);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

policy = Pepis;
%policy = zeros(length(U),1);
Slen = length(S);
Alen = length(A);
Ulen = length(U);
unchanged = 1;

for u = 1:Ulen
    possible_actions = zeros(Alen,1);
    for action = 1:Alen
        v = P(u, action);
        v_sum = 0;
        states = find(v.probs);
        for vi = 1:length(states)
            v_sum = v_sum + (v.probs(states(vi)) * U(states(vi)));
        end
        possible_actions(action) = v_sum;
    end
    [mx, index] = max(possible_actions);
    if (Pepis(u) ~= index)
        policy(u) = index;
        unchanged = 0;
    end
end


end

