function [stageCostMat, predMat, converged] = dpa(P, startNode, endNode, maxIteration)

% This is the function that will perform the DPA.
%
% Assume we have n number of nodes. P matrix is the transition cost matrix
% with dimension of n x n(square matrix). P(toNode, fromNode) shows
% transition cost from fromNode to toNode.
%
% stageCostMat shows the cost at each node for current iteration.
% stageCostMat(c) = current stage cost matrix at node c.
%
% predMat shows parent/predecessor node of each node for every stage.
% predMat(c, s): parent of node c during stage s.
%
% manurung.auralius@gmail.com
% 17.11.2012
% -------------------------------------------------------------------------

% Is the algortihm converged?
converged = 0;

% Cost matrix is a square matrix, m = n
[m, n] = size(P);

% Assume we will probably converge after n stages
stageCostMat = ones(1, m) * inf;

% Initial cost, no initial cost
stageCostMat(startNode) = 0;

% Predecessor matrix to trace back the optimum path, we will record parent of
% each node on each iteration
predMat = zeros(m, maxIteration); 

% Stage-by-stage, we move from start node to terminal node
for stage = 2 : maxIteration    
    
    % Find connection from any nodes to any nodes, keep the smaller cost
    prevStageCostMat = stageCostMat;
    stageCostMat = ones(1, m) * inf;

    for fromNode = 1 : m
        for toNode = 1 : m
            aij = P(toNode, fromNode);
            dj = aij + prevStageCostMat(fromNode);
            if dj < stageCostMat(toNode)
                stageCostMat(toNode) = dj;
                predMat(toNode, stage) = fromNode;
            end         
        end % end toNode
    end % end fromNode

    % Termination
%     if (stageCostMat == prevStageCostMat)
%         converged = 1;
%         break;
%     end

    if (predMat(endNode, stage) == endNode) || (predMat(endNode, stage-1) > 0) && (predMat(endNode, stage) == predMat(endNode, stage-1))
        converged = 1;
        break;
    end

end

predMat = predMat(:, 1:stage);

