function [optimalPath, optimalCost] = processPredMat(stageCostMat, predMat, startNode, endNode)

% This function traces back the predMat to find the optimal path.
%
% manurung.auralius@gmail.com
% 17.11.2012
% -------------------------------------------------------------------------

stage = size(predMat, 2);

index = 2;
node = endNode;
while (1)
    optimalPath(index - 1) = node;
    node = predMat(optimalPath(index-1), stage - index + 1);
    if node == startNode
        optimalPath(index) = startNode;
        break;
    end
    
%     if stage - index == 1
%         disp('oboy')
%         break
%     end
    
    index = index + 1;
end
optimalPath = fliplr(optimalPath);

optimalCost = stageCostMat(endNode);

end