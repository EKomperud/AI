function [U,U_trace] = CS4300_MDP_value_iteration(S,A,P,R,gamma,...
eta,max_iter)
% CS4300_MDP_value_iteration - compute policy using value iteration
% On input:
%   S (vector): states (1 to n)
%   A (vector): actions (1 to k)
%   P (nxk struct array): transition model
%       (s,a).probs (a vector with n transition probabilities
%       (from s to s_prime, given action a)
%   R (vector): state rewards
%   gamma (float): discount factor
%   eta (float): termination threshold
%   max_iter (int): max number of iterations
% On output:
%   U (vector): state utilities
%   U_trace (iterxn): trace of utility values during iteration
% Call:
%   [U,Ut] = Cs4300_MDP_value_iteration(S,A,P,R,0.999999,0.1,100);
%
%   Set up a driver function, CS_4300_run_value_iteration (see
%   below), which sets up the Markov Decision Problem and calls this
%   function.
%
%   Chapter 17 Russell and Norvig (Table p. 651)
%   [S,A,R,P,U,Ut] = CS4300_run_value_iteration(0.999999,1000)
%
%   U’ = 0.7053 0.6553 0.6114 0.3879 0.7616 0 0.6600 -1.0000
%     0.8116 0.8678 0.9178 1.0000
%
%   Layout:             1
%                       ˆ
%    9 10 11 12         |
%    5  6  7  8     2 <- -> 4
%    1  2  3  4         |
%                       V
%                       3
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

% (S)tates        = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
% (A)ctions       = [1 (Up), 2 (Left), 3 (Down), 4 (Right)];

Slen = length(S);
Alen = length(A);

U = zeros(Slen,1);
%U(3) = -1000;
%U(7) = -1000;
%U(11) = -1000;
%U(16) = 1000;

Up = zeros(Slen,1);
%Up(3) = -1000;
%Up(7) = -1000;
%Up(11) = -1000;
%Up(16) = 1000;

iterations = 0;
U_trace = zeros(max_iter, Slen);


while (1)
    U = Up;
    curly_thing = 0;
    for state = 1:Slen
        Possible_Utilities = zeros(Alen,1);
        for action = 1:Alen
            v = P(state, action);
            %vpx = [0,0,0];
            vp = 0;
            %vi = 1;
            for vs = 1:Slen
                if v.probs(vs) ~= 0.0
                    %vpx(vi) = v.probs(vs) * U(vs);
                    vp = vp + (v.probs(vs) * U(vs));
                    %vi = vi + 1;
                end
            end
            Possible_Utilities(action) = vp;
        end
        Up(state) = R(state) + (gamma * (max(Possible_Utilities)));       
        curly_thing = max(curly_thing, Up(state) - U(state));
    end
    iterations = iterations + 1;
    for s = 1:Slen
        U_trace(iterations,s) = Up(s);
    end
    if curly_thing < (eta * (1 - gamma) / gamma)
        return;
    end
    
    if iterations >= max_iter
        return;
    end
end


end

