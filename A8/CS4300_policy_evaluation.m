function Up = CS4300_policy_evaluation(policy,U,S,A,P,R,k,gamma)
% Given a policy, return U, a vector of utilites were that policy to be
% executed
%
% Input:
%   policy (vector): actions for each state (1 to n)
%   U (vector): utilities (1 to n)
%   S (vector): states (1 to n)
%   A (vector): actions (1 to k)
%   P (nxk array): transition model
%   R (vector): state rewards
%   k (int): number of iterations
%   gamma (float): discount factor
% 
% Output:
%   Up (vector): Utilities were policy to be executed
%
% Call:
%   Up = CS4300_policy_evaluation(policy, U, S, A, P, R, 10, 1.0)
%
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

len_s = length(S);
Up = zeros(len_s,1);

for K = 1:k
    for s = 1:len_s
        Up(s) = R(s);
        [a,b,new_states] = find(P(s, policy(s)).probs);
        summation = 0;
        if length(new_states) ~= 1
            for s2 = 1:length(new_states)
                summation = summation + (new_states(s2) * U(b(s2)));
            end
        end
        summation = summation * gamma;
        Up(s) = Up(s) + summation;
    end
    U = Up;
end

return

% % % System of Equations Method. Doesn't really work that well % % %
% len_s = length(S);
% left_hand_side  = zeros(len_s, 1);
% right_hand_side = zeros(len_s, len_s);
% 
% for s = 1:len_s
%     left_hand_side(s) = -1 * R(s);
%     equation = P(s, policy(s));
%     equation = equation.probs;
%     for s2 = 1:len_s
%         right_hand_side(s,s2) = equation(s2);
%         if s == s2 && right_hand_side(s,s2) ~= 1 && left_hand_side(s2) ~= 0
%             right_hand_side(s,s2) = right_hand_side(s,s2) - 1;
%         elseif right_hand_side(s,s2) == 1
%             left_hand_side(s) = R(s);
%         end
%     end
% end
% 
% Up2 = pinv(right_hand_side) * left_hand_side;
% Up = linsolve(right_hand_side,left_hand_side);
% test = right_hand_side * Up;
% test2 = right_hand_side * Up2;


end

