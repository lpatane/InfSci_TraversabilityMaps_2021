function visualizeTerrain(T)

% Visualize the terrain.
%
% Don't forget to hold the figure when you want to visualize the optimal 
% path using visualizePath function.
%
% manurung.auralius@gmail.com
% 17.11.2012
% -------------------------------------------------------------------------

[m, n] = size(T);

[X,Y] = meshgrid(1 : n, 1 : m);
surf(X, Y, T(1 : m, 1 : n));

end