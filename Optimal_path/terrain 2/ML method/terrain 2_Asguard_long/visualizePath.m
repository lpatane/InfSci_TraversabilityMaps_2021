% clc; 
% clear all;
% close all;

load('T_mediata');
load('OptimalPath');
[n, m] = size(T);
optimalPath=OptimalPath;
l = length(optimalPath);

%Convert back the node cardinal number to the corresponding xyz coordinate.
x = zeros(1, l);
y = zeros(1, l);
z = zeros(1, l);
for i = 1 : l
    x(i) = mod(optimalPath(i) - 1, n) + 1;
    y(i) = abs((optimalPath(i) - 1 - mod(optimalPath(i) - 1, n)) / n) + 1;
    z(i) = 1.0 + T(x(i), y(i));
end
% Draw the optimal path as line.
 figure;
 surf(T);
 hold on
% load('x');
% load('y');
% load('z');
xx=5
% % z(1:size(x, 2))=600;
if xx==10
    plot3(y, x, z-1, 'r', 'LineWidth', 2)
end
if xx==20
    plot3(y, x, z-1, 'g', 'LineWidth', 2)
end
if xx==30
    plot3(y, x, z-1, 'b', 'LineWidth', 2)
end
if xx==40
    plot3(y, x, z-1, 'c', 'LineWidth', 2)
end
if xx==5
    plot3(y, x, z-1, 'm', 'LineWidth', 7)
end
if xx==60
    plot3(y, x, z-1, 'y', 'LineWidth', 2)
end
if xx==70
    plot3(y, x, z-1, 'k', 'LineWidth', 2)
end
if xx==80
    plot3(y, x, z-1, 'w', 'LineWidth', 2)
end
if xx==90
    plot3(y, x, z-1, 'r', 'LineWidth', 7)
end


% save('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\test_robot\Mappa', 'Mappa');
fin=[y' x'];
save('.\fin', 'fin');
% hold on
% Draw asterisk symbol (*) at destination nodes.
% plot3(y(l), x(l), z(l), '*m', 'LineWidth', 4)
%pause(1);
% Draw asterisk symbol (*) at destination nodes.
plot3(y(l), x(l), z(l)-0.96, '*g', 'LineWidth', 15)
plot3(y(1), x(1), z(1)-0.96, 'sr', 'LineWidth', 12)

xlabel('X (tiles)'); ylabel('Y (tiles)');