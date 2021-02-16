load ('pattern_Robotnik.mat');
load ('patterningresso_mediati_con_zscore.mat');

DATI=MatriceDati;

a=find(DATI(:, 1)==0);
tutti_zeri=DATI(a, :);
dim=size(tutti_zeri, 1);

a=find(DATI(:, 1)==1);
tutti_uni=DATI(a, :);
tutti_uni=tutti_uni(1: dim, :);

DATI=[tutti_uni; tutti_zeri];
dim2=size(DATI, 1);

DATI=datasample(DATI, dim2);
new2=zscore(DATI(:, 4)); %pendenza partenza
new3=zscore(DATI(:, 5)); %pendenza arrivo
new4=zscore(DATI(:, 6)); %Hmax partenza
new5=zscore(DATI(:, 7)); %Hmax arrivo
new6=zscore(DATI(:, 8)); %rug partenza
new7=zscore(DATI(:, 9)); %rug arrivo

new1=zscore(DATI(:, 3)); %deltaH 1
new23=(new2+new3)/2; %pendenza 2
for j=1:size(new4, 1) %Hmax 3
    if new4(j)>=new5(j)
        new45(j, 1)=new4(j);
    else
        new45(j, 1)=new5(j);
    end
end
new67=(new6+new7)/2; %rug 4


output=DATI(:, 1);
new919=(DATI(:, 10:19));
% new23=(new2+new3)/2;
% new67=(new6+new7)/2;

% DATI=[new1 new23 new45 new67 output new919];
tmp1=0;
tmp0=0;
tmp=0;

num=size(DATI, 1);
blocco=100*1/100*num;

for i=1:100

DATI=[new1 new23 new45 new67 output new919];
DATI=datasample(DATI, dim2);

% a=DATI(:, 1:8);
DATI_LERNING=DATI(1:blocco, :); 
DATI_TEST=patterningresso_mediati_con_zscore;

% DATI_LERNING_2=DATI(1:blocco, :); 
% DATI_TEST_2=DATI(blocco+1:end, :);

P_LEARNING_INPUT=DATI_LERNING(:, 1:4);
P_LEARNING_OUTPUT=DATI_LERNING(:, 5);
P_TEST_INPUT=DATI_TEST(:, 1:4);

NET=newff(P_LEARNING_INPUT', P_LEARNING_OUTPUT', 20);
% clc
i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   NET.trainParam.epochs=10000
%   NET.trainParam.max_fail=1000
%   NET.trainParam.goal = 1e-9;
%   NET.trainParam.lr=0.00001
%   clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i
NET_TRAIN=train(NET, P_LEARNING_INPUT', P_LEARNING_OUTPUT');

LSIMULATED=sim(NET_TRAIN, P_LEARNING_INPUT');
TSIMULATED=sim(NET_TRAIN, P_TEST_INPUT');

e_learning = LSIMULATED'-P_LEARNING_OUTPUT;
e_medio_learning = mean(e_learning);

% figure(1);
% subplot(2, 2, 1)
% plot(e_learning);
% title('errore fase di learning');
% xlabel('campioni');
% ylabel('errore');
% legend('errore')
% 
% subplot(2, 2, 2)
% plot([LSIMULATED' P_LEARNING_OUTPUT]);
% title('uscite desiderate vs uscite reali in learning');
% xlabel('campioni');
% ylabel('uscite');
% legend('uscita simulata','uscita desiderata')

% e_medio_test = mean(e_learning);

for j=1:size(TSIMULATED, 2)
    if (TSIMULATED(j)>0.5)
        TSIMULATED2(j)=0.1; %ce la fa
    else
        TSIMULATED2(j)=1000000; %non ce la fa
    end
end

TSIMULATED2=TSIMULATED2';

tmp0=tmp0+TSIMULATED2;
clear TSIMULATED2
% close all
end

tmp1=tmp0/100;

totale_patteren_input_e_output=[patterningresso_mediati_con_zscore tmp1];

save('totale_patteren_input_e_output','totale_patteren_input_e_output');
