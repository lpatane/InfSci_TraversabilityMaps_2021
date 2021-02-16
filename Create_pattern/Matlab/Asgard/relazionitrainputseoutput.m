close all
clear all
clc

data = importdata('SimulationResult.mat') ;
x = data(:,1) ; y = data(:,3) ; z = data(:,4) ;
dt = delaunayTriangulation(x,y) ;
tri = dt.ConnectivityList ;
xi = dt.Points(:,1) ; 
yi = dt.Points(:,2) ; 
F = scatteredInterpolant(x,y,z);
zi = F(xi,yi) ;
trisurf(tri,xi,yi,zi) 
view(2)
shading interp

figure
plot(x, z)

figure
plot(y, z)

figure
plot3(x, y, z, '*')

% xr=reshape(x(1:2450), [49 50]);
% yr=reshape(y(1:2450), [49 50]);
% zr=reshape(z(1:2450), [49 50]);
% 
% figure
% surf(xr);
% 
% figure
% surf(yr);
% 
% figure
% surf(zr);
