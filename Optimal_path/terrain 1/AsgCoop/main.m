% This is the main simulation file.
%
% manurung.auralius@gmail.com
% 17.11.2012
% 
clc;
clear all;
close all;

% START_NODE = 68*20+10;  %funziona
% END_NODE = 68*40+60;          

START_NODE = 68*20+29;  %non funziona
END_NODE = 68*40+40; 

% Warning: Terrain2.mat is a huge map, it will takes quite a lot of time to
% proceed.

load ('T.mat');
% load ('Terrain1.mat'); 

figure;
hold on;
visualizeTerrain(T);

P = createTransitionCostMat(T);
% P(:,:)=1;
[stageCostMat, predMat, converged] = dpa(P, START_NODE, END_NODE, 1000);

% Keep in mind that DPA propagates through all the nodes. Basically DPA
% tries to find optimal path from one nodes to all nodes.

[optimalPath, optimalCost] = processPredMat(stageCostMat, predMat, START_NODE, END_NODE);
visualizePath(T, optimalPath);

