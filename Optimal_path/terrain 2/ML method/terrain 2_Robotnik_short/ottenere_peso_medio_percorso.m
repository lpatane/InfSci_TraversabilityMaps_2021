clear all;
clc;
close all;

load('OptimalPath');
load('G_nosoglia_Robotnik');


G=G.Edges{:, 1:2};

for i=1:size(OptimalPath, 2)-1
    tmp1=OptimalPath(i);
    tmp2=OptimalPath(i+1);
    x=find(G(:, 1)==tmp1);
    y=find(G(:, 2)==tmp2);
    tmp3 = intersect(x,y);
    tmp4(i)=G(tmp3, 3);
    
end
tmp5=sum(tmp4);

ris=tmp5/size(OptimalPath, 2)

