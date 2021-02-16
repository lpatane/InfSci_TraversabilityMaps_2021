%https://it.mathworks.com/matlabcentral/answers/171277-how-can-i-get-all-paths-between-two-nodes
clear all
clc

load('graph');
startn=5;
endn=96;
stop=0;
n=0;
graph=G;
while stop~=1
    n=n+1;
    Temp=shortestpath(graph,startn,endn);
    eidx=findedge(graph,Temp(1:end-1),Temp(2:end));
    if n~=1
        if length(Temp)==length(pth{n-1,1})
            if Temp==pth{n-1,1}
                stop=1;
            else
                pth{n,1}=Temp;
                graph.Edges.Weight(eidx)=100;
            end
        else
            pth{n,1}=Temp;
            graph.Edges.Weight(eidx)=100;
        end
    else
        pth{n,1}=Temp;
        graph.Edges.Weight(eidx)=100;
    end
    clear Temp eidx;
end

% for h=1:size(pth, 1)
%     nums = [pth{h,:}];
%     for i=1:1:size(nums, 1)
%         tmp=0;
%         k=1;
%         m=1;
%         for j=1:1:size(nums, 2)-1
%             if (nums(i)==G.Edges.EndNodes(j, 1) && (nums(i+1)==G.Edges.EndNodes(j, 2)))          
%                 tmp(k)=G.Edges.Weight(i);
%                 k=k+1;
%                 break;
%             end
%         end        
%     end
% %         if tmp ~= 0
% %             S(:, m) = sum(tmp);
% %             m=m+1;
% %         end
% %         tmp=0;
% end
k=1;
h=1;
for i=1:size(pth, 1)
    nums = [pth{i,:}];
    for j=1:size(nums, 1)
        %for h=1:size(G.Edges.EndNodes, 1)
            if (nums(j)==G.Edges.EndNodes(h, 1) && (nums(j+1)==G.Edges.EndNodes(h, 2)))          
                tmp(k)=G.Edges.Weight(h);
                k=k+1;
                
                %break;
            end
           
        %end
    end
    h=h+1;
end





