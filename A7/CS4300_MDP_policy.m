function policy = CS4300_MDP_policy(S,A,P,U)
% CS4300_MDP_policy - generate a policy from utilities
% See p. 648 Russell & Norvig
% On input:
%   S (vector): states (1 to n)
%   A (vector): actions (1 to k)
%   P (nxk struct array): transition model
%       (s,a).probs (a vector with n transition probabilities
%       from s to s_prime, given action a)
%   U (vector): state utilities
% On output:
%   policy (vector): actions per state
% Call:
%   p = CS4300_MDP_policy(S,A,P,U);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

policy = zeros(16,1);
Slen = length(S);
Alen = length(A);
Ulen = length(U);

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
    policy(u) = index;
end


end

