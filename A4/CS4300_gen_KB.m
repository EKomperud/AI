function [KB,KBi,vars] = CS4300_gen_KB

% BR_gen_KB - generate Wumpus World logic in KB
% On input:
% N/A
% On output:
% KB (CNF KB): KB with Wumpus logic (atom symbols)
% (k).clauses (string): string form of disjunction
% KBi (CNF KB): KB with Wumpus logic (integers)
% (k).clauses (1xp vector): integer form of disjunction
% vars(struct: vector of strings): list of atom strings
% (k).var (string): name of atom
% Call:
% [KB,KBi,vars] = CS4300_gen_KB;
% Author:
% Eric Komperud
% UU
% Fall 2017
%

KB(402).clauses = 402;
KBi(402).clauses = 402;
vars(80).vars = 80; 
i = 1;

% Vars
for x = 1:4
    for y = 1:4
        vars(i).vars = ['B', num2str(x), num2str(y)];
        vars(i+16).vars = ['G', num2str(x), num2str(y)];
        vars(i+32).vars = ['P', num2str(x), num2str(y)];
        vars(i+48).vars = ['S', num2str(x), num2str(y)];
        vars(i+64).vars = ['W', num2str(x), num2str(y)];
        i = i + 1;
    end
end

i = 1;

% A Breeze exists in a Cell iff there is a Pit in a neighbour Cell
for x = 1:4
    for y = 1:4
        K = ['-B', num2str(x), num2str(y), ' '];
        K2 = ['B', num2str(x), num2str(y), ' '];
        P = cell(4,1);
        
        Ki = ((y-1)*4) + x;
        Pi = [];
        if y < 4
            P{1} = ['P', num2str(x), num2str(y+1), ' '];
            KB(i).clauses = [ ['-',P{1}], K2];
            
            Pi = [Pi,(Ki+4)+32];
            KBi(i).clauses = sort([-Pi(end),Ki]);
            
            i = i + 1;
        end
        if x < 4
            P{2} = ['P', num2str(x+1), num2str(y), ' '];
            KB(i).clauses = [ ['-',P{2}], K2];
            
            Pi = [Pi,(Ki+1)+32];
            KBi(i).clauses = sort([-Pi(end),Ki]);
            
            i = i + 1;
        end
        if y > 1
            P{3} = ['P', num2str(x), num2str(y-1), ' '];
            KB(i).clauses = [ ['-',P{3}], K2];
            
            Pi = [Pi,(Ki-4)+32];
            KBi(i).clauses = sort([-Pi(end),Ki]);
            
            i = i + 1;
        end
        if x > 1
            P{4} = ['P', num2str(x-1), num2str(y)];
            KB(i).clauses = [ ['-',P{4},' '], K2];
            
            Pi = [Pi,(Ki-1)+32];
            KBi(i).clauses = sort([-Pi(end),Ki]);
            
            i = i + 1;
        end
        KB(i).clauses = [K P{1} P{2} P{3} P{4}];
        KBi(i).clauses = sort([-Ki, Pi]);
        i = i + 1;
    end
end

% No Multi-Gold
for c = 0:15
    x = mod(int8(c), 4) + 1;
    y = idivide(int8(c),4) + 1;
    k = ['-G', num2str(x), num2str(y)];
    ki = -(c+17);
    for C = (c+1):15
        X = mod(int8(C), 4) + 1;
        Y = idivide(int8(C),4) + 1;
        K = ['-G', num2str(X), num2str(Y)];
        Ki = -(C+17);
        KB(i).clauses = [k,' ',K];
        KBi(i).clauses = sort([ki,Ki]);
        i = i+1;
    end
end

% The Pits
for x = 1:4
    for y = 1:4
        K = ['-P', num2str(x), num2str(y), ' '];
        W = ['-W', num2str(x), num2str(y)];
        G = ['-G', num2str(x), num2str(y)];
        Ki = x+((y-1)*4) + 32;
        Wi = Ki + 32;
        Gi = Ki - 16;
        
        KB(i).clauses = [K,W];
        KBi(i).clauses = sort([-Ki,-Wi]);
        i = i+1;
        KB(i).clauses = [K,G];
        KBi(i).clauses = sort([-Ki,-Gi]);
        i = i+1;
    end
end

% Stenches
for x = 1:4
    for y = 1:4
        K = ['-S', num2str(x), num2str(y), ' '];
        K2 = ['S', num2str(x), num2str(y), ' '];
        P = cell(4,1);
        
        Ki = x+((y-1)*4) + 48;
        Pi = [];
        if y < 4
            P{1} = ['W', num2str(x), num2str(y+1), ' '];
            KB(i).clauses = [ ['-',P{1}], K2];
            
            Pi = [Pi,(Ki+4)+16];
            KBi(i).clauses = sort([-Pi(end),Ki]);
            
            i = i + 1;
        end
        if x < 4
            P{2} = ['W', num2str(x+1), num2str(y), ' '];
            KB(i).clauses = [ ['-',P{2}], K2];
            
            Pi = [Pi,(Ki+1)+16];
            KBi(i).clauses = sort([-Pi(end),Ki]);
            
            i = i + 1;
        end
        if y > 1
            P{3} = ['W', num2str(x), num2str(y-1), ' '];
            KB(i).clauses = [ ['-',P{3}], K2];
            
            Pi = [Pi,(Ki-4)+16];
            KBi(i).clauses = sort([-Pi(end),Ki]);
            
            i = i + 1;
        end
        if x > 1
            P{4} = ['W', num2str(x-1), num2str(y)];
            KB(i).clauses = [ ['-',P{4},' '], K2];
            
            Pi = [Pi,(Ki-1)+16];
            KBi(i).clauses = sort([-Pi(end),Ki]);
            
            i = i + 1;
        end
        KB(i).clauses = [K P{1} P{2} P{3} P{4}];
        KBi(i).clauses = sort([-Ki, Pi]);
        i = i + 1;
    end
end

% No Multi-Wumpuses
for c = 0:15
    x = mod(int8(c), 4) + 1;
    y = idivide(int8(c),4) + 1;
    k = ['-W', num2str(x), num2str(y)];
    ki = -(c+65);
    for C = (c+1):15
        X = mod(int8(C), 4) + 1;
        Y = idivide(int8(C),4) + 1;
        K = ['-W', num2str(X), num2str(Y)];
        Ki = -(C+65);
        KB(i).clauses = [k,' ',K];
        KBi(i).clauses = sort([ki,Ki]);
        i = i+1;
    end
end

% There will be, a Wumpus
w = [''];
wi = [];
for x = 1:4
    for y = 1:4
        w = [w, 'W', num2str(x), num2str(y), ' ']; 
        wi = [wi, (x+((y-1)*4)+64)];
    end
end
KB(i).clauses = w;
KBi(i).clauses = wi;
i = i+1;

% There will be, a Gold
g = [''];
gi = [];
for x = 1:4
    for y = 1:4
        g = [g, 'G', num2str(x), num2str(y), ' ']; 
        gi = [gi, (x+((y-1)*4)+16)];
    end
end
KB(i).clauses = g;
KBi(i).clauses = gi;

end

