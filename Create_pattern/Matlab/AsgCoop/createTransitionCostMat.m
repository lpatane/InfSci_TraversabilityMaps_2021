function P = createTransitionCostMat(T)
% This is the function to create a transition matrix.
%
% Consider a terrain map T of m x n, we will find the cost from one point 
%in the map to the rest of other points in the map.
%
% P(toNode, fromNode): transition cost from fromNode to toNode
% Its value is ranging from 0 to inf.
%
% Cardinality of the nodes in the terrain map T of m x n:
%   1   2   3   4   5  ... n
%  n+1 n+2 n+3 n+4 n+5 ... 2n
%   .   .   .   .   .      .  
%   .   .   .   .   .      .
%   .   .   .   .   .  ... mxn
%
% From one node, we can only move one step at a time to the sorrounding 
% nodes (up, down, left, right, upper left, upper right, lower left, and 
% lower right).
%  
% manurung.auralius@gmail.com
% 17.11.2012
% -------------------------------------------------------------------------
[m, n] = size(T);
P = inf * ones(m * n); % This generates (m*n) x (m*n) matrix
% For every point of terrain matrix T (pivot point), we will compute its
% cost to all other points of the same terrain matrix T.
for pivotR = 1 : m
    for pivotC = 1 : n
        fromNode = (pivotR - 1) * n + pivotC;
        
        % Upward
        if pivotR > 1
            r = pivotR - 1;
            c = pivotC;
            toNode = (r - 1) * n + c;
            P(toNode, fromNode) = max(0, T(r, c) - T(pivotR, pivotC));
        end
        
        % Downward
        if pivotR < m
            r = pivotR + 1;
            c = pivotC;
            toNode = (r - 1) * n + c;
            P(toNode, fromNode) = max(0, T(r, c) - T(pivotR, pivotC));
        end
        
        % Leftward
        if pivotC > 1
            r = pivotR ;
            c = pivotC - 1;
            toNode = (r - 1) * n + c;
            P(toNode, fromNode) = max(0, T(r, c) - T(pivotR, pivotC));
        end
        
        % Rightward
        if pivotC < n
            r = pivotR ;
            c = pivotC + 1;
            toNode = (r - 1) * n + c;
            P(toNode, fromNode) = max(0, T(r, c) - T(pivotR, pivotC));
        end
        
        % Down Rightward
        if pivotC < n && pivotR < m
            r = pivotR + 1;
            c = pivotC + 1;
            toNode = (r - 1) * n + c;
            P(toNode, fromNode) = max(0, T(r, c) - T(pivotR, pivotC));
        end
        
        % Upper Rightward
        if pivotC < n && pivotR > 1
            r = pivotR - 1;
            c = pivotC + 1;
            toNode = (r - 1) * n + c;
            P(toNode, fromNode) = max(0, T(r, c) - T(pivotR, pivotC));
        end
        
        % Down Leftward
        if pivotC > 1 && pivotR < m
            r = pivotR + 1;
            c = pivotC - 1;
            toNode = (r - 1) * n + c;
            P(toNode, fromNode) = max(0, T(r, c) - T(pivotR, pivotC));
        end
        
        % Upper Leftward
        if pivotC > 1 && pivotR > 1
            r = pivotR - 1;
            c = pivotC - 1;
            toNode = (r - 1) * n + c;
            P(toNode, fromNode) = max(0, T(r, c) - T(pivotR, pivotC));
        end
        
        % Itself
        P(fromNode, fromNode) = 0;
        
    end
end