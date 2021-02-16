clc
clear all
close all

load ('finalecontutto_indici.mat');
DATI=MatriceDati;
delete=isnan(DATI(:, 2));
delete=find(delete(:, 1)==1);
DATI(delete, :)=[];

x1=zscore(DATI(:, 1))';
x2=zscore(DATI(:, 4))';
x3=zscore(DATI(:, 6))';

x = [x1; x2; x3];
net = selforgmap([10 10]);
net = train(net,x);
view(net)
y = net(x);
% plot(y)
classes = vec2ind(y);