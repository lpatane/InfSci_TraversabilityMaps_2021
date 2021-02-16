close all
clc

load ('finalecontutto_indici.mat');

%https://it.mathworks.com/help/deeplearning/ug/analyze-neural-network-performance-after-training.html

delete=isnan(DATI(:, 2));
delete=find(delete(:, 1)==1);
DATI(delete, :)=[];

new1=zscore(DATI(:, 1));
new2=zscore(DATI(:, 2));
new3=zscore(DATI(:, 3));
new4=zscore(DATI(:, 4));
new5=zscore(DATI(:, 5));
new6=zscore(DATI(:, 6));

DATI_I=[new1 new2 new3 new4 new5];
DATI_O=[new6];

net = feedforwardnet(10);
 
net = train(net,DATI_I',DATI_O');
view(net)
y = net(DATI_I');
perf = perform(net,DATI_O',y)

