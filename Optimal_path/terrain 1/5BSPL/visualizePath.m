% clc; 
% clear all;
% close all;

load('T2');
load('OptimalPath');
[n, m] = size(T);
optimalPath=OptimalPath;
l = length(optimalPath);

% Convert back the node cardinal number to the corresponding xyz coordinate.
x = zeros(1, l);
y = zeros(1, l);
z = zeros(1, l);
for i = 1 : l
    x(i) = mod(optimalPath(i) - 1, n) + 1;
    y(i) = abs((optimalPath(i) - 1 - mod(optimalPath(i) - 1, n)) / n) + 1;
    z(i) = 1.0 + T(x(i), y(i));
end
hold on
% figure;
% Draw the optimal path as line.
surf(T);
hold on
% z(1:size(x, 2))=600;
plot3(y, x, z, 'r', 'LineWidth', 2)
% save('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\test_robot\Mappa', 'Mappa');
fin=[y' x'];
save('fin', 'fin');
% hold on
% Draw asterisk symbol (*) at destination nodes.
plot3(y(l), x(l), z(l)+30, '*g', 'LineWidth', 10)
plot3(y(1), x(1), z(1)+30, 'sr', 'LineWidth', 7)

xlabel('X (tiles)'); ylabel('Y (tiles)');