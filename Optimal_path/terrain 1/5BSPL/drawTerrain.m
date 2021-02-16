function drawTerrain(T)

% This function draws the terrain map.
%
% manurung.auralius@gmail.com
% 17.11.2012
% -------------------------------------------------------------------------

[m,n] = size(T);

[X,Y] = meshgrid(1 : n, 1 : m);
surf(X, Y, T(1 : m, 1 : n));

end