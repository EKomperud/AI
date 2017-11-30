function [S,A,R,P,U,Ut,policy] = CS4300_run_policy_iteration(wumpus)
% A driver function to run the policy iteration algorithm
% Input: 
%   0 to run on R&N board or 1 to run on Wumpus board
% Output:
%   S,A,R,P: Vectors of the input parameters used by value iteration
%   U: A Nx1 vector of the final utilites
%   Ut: An iterations x N vector of the utilities at each iteration
%   policy: A policy based on U
%
% Call:
%   [S,A,R,P,U,Ut,policy] = CS4300_run_policy_iteration(0);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

if wumpus == 1
    S = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
    A = [1,2,3,4];
    P = CS4300_state_transitions(wumpus);
    R = [-1, -1, -1000, -1,  -1, -1, -1000, -1,  -1, -1, -1000, -1,  -1, -1, -1, 1000];

    gamma = 1;
    k = 10;
else
    S = [1,2,3,4,5,6,7,8,9,10,11,12];
    A = [1,2,3,4];
    P = CS4300_state_transitions(wumpus);
    R = [-0.04, -0.04, -0.04, -0.04,  -0.04, 0, -0.04, -1,  -0.04, -0.04, -0.04, 1];
    %R = [-0.3, -0.3, -0.3, -0.3,  -0.3, 0, -0.3, -1,  -0.3, -0.3, -0.3, 1];
    %R = [-0.01, -0.01, -0.01, -0.01, -0.01, 0, -0.01, -1,  -0.01, -0.01, -0.01, 1];
    %R = [-2, -2, -2, -2,  -2, 0, -2, -1,  -2, -2, -2, 1];
    %R = [2, 2, 2, 2, 2, 0.0, 2, -1.0, 2, 2, 2, 1.0];

    gamma = 1;
    k = 10;
end

times = zeros(30,1);
for count = 1:30
    tic;
    [policy,U,Ut] = CS4300_MDP_policy_iteration(S,A,P,R,k,gamma);
    times(count) = toc;
end

return
% Uncomment to plot utilities %%

% X = [];
% one_one = [];
% three_one = [];
% four_one = [];
% three_three = [];
% four_three = [];
% 
% x = 1;
% while x <= max_iter && Ut(x,1) ~= 0
%     X(x) = x;
%     one_one(x) = Ut(x,1);
%     three_one(x) = Ut(x,3);
%     four_one(x) = Ut(x,4);
%     three_three(x) = Ut(x,11);
%     four_three(x) = Ut(x,12);
%     x = x + 1;
% end
% plot(X, one_one, X, three_one, X, four_one, X, three_three, X, four_three);
% xlabel("iterations");
% ylabel("state utility");
% ylim([-0.4 1.2]);
% label(one_one, "(1,1)");
%

end

