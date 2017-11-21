function [S,A,R,P,U,Ut,policy] = CS4300_run_value_iteration()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

S = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
A = [1,2,3,4];
P = CS4300_state_transitions();
R = [-1, -1, -1000, -1,  -1, -1, -1000, -1,  -1, -1, -1000, -1,  -1, -1, -1, 1000];

gamma = 0.99;
eta = 0.1;
max_iter = 100;

[U,Ut] = CS4300_MDP_value_iteration(S,A,P,R,gamma,eta,max_iter);

policy = CS4300_MDP_policy(S,A,P,U);

end

