close all
clc
clear all

load ('finale_classificatore.mat');

DATI=MatriceDati;


a=find(DATI(:, 4)==0);
tutti_zeri=DATI(a, :);

a=find(DATI(:, 4)==1);
tutti_uni=DATI(a, :);
tutti_uni=tutti_uni(1: 833, :);

DATI=[tutti_uni; tutti_zeri];
DATI=datasample(DATI, 1666);

new1=zscore(DATI(:, 1));
new2=zscore(DATI(:, 2));
new3=zscore(DATI(:, 3));

DATI=[new1 new2 new3 DATI(:, 4)];

DATI_LERNING=DATI(1:1332, :); 
DATI_TEST=DATI(1332+1:end, :);

P_LEARNING_INPUT=DATI_LERNING(:, [1, 2, 3]);
P_LEARNING_OUTPUT=DATI_LERNING(:, 4);
P_TEST_INPUT=DATI_TEST(:, [1, 2, 3]);
P_TEST_OUTPUT=DATI_TEST(:, 4);

NET=newff(P_LEARNING_INPUT', P_LEARNING_OUTPUT', 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  NET.trainParam.epochs=1000
  NET.trainParam.max_fail=1000
  NET.trainParam.goal = 1e-9;
  NET.trainParam.lr=0.0001
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NET_TRAIN=train(NET, P_LEARNING_INPUT', P_LEARNING_OUTPUT');

LSIMULATED=sim(NET_TRAIN, P_LEARNING_INPUT');
TSIMULATED=sim(NET_TRAIN, P_TEST_INPUT');

e_learning = LSIMULATED'-P_LEARNING_OUTPUT;
e_medio_learning = mean(e_learning);

figure(1);
subplot(2, 2, 1)
plot(e_learning);
title('errore fase di learning');
xlabel('campioni');
ylabel('errore');
legend('errore')

subplot(2, 2, 2)
plot([LSIMULATED' P_LEARNING_OUTPUT]);
title('uscite desiderate vs uscite reali in learning');
xlabel('campioni');
ylabel('uscite');
legend('uscita simulata','uscita desiderata')

% e_medio_test = mean(e_learning);

for i=1:size(TSIMULATED, 2)
    if (TSIMULATED(i)>0.5)
        TSIMULATED2(i)=1;
    else
        TSIMULATED2(i)=0;
    end
end

subplot(2, 2, 3)
plot(TSIMULATED2'-P_TEST_OUTPUT);
title('errore fase di test');
xlabel('campioni');
ylabel('errore');
legend('errore')

subplot(2, 2, 4)
plot([TSIMULATED2' P_TEST_OUTPUT]);
title('uscite desiderate vs uscite reali in test');
xlabel('campioni');
ylabel('uscite');
legend('uscita simulata','uscita desiderata')

cm = confusionmat(P_TEST_OUTPUT,TSIMULATED2')

perc=cm/size(P_TEST_OUTPUT, 1)

totale=perc(1, 1)+perc(2, 2)

figure;
confusionchart(cm)
%%%%%%%%%%%%%%%%%%%%%%
k=1;
TSIMULATED2=TSIMULATED2';

for i=1:size(P_TEST_OUTPUT, 1)
    if (P_TEST_OUTPUT(i)==0) && (TSIMULATED2(i)==1)
        indic(k)= i;
        k=k+1;
    end
end

casi_di_0_simulati_come_1=DATI_TEST(indic, :);

k=1;
TSIMULATED2=TSIMULATED2';
for i=1:size(P_TEST_OUTPUT, 1)
    if (P_TEST_OUTPUT(i)==0) && (TSIMULATED2(i)==0)
        indic2(k)= i;
        k=k+1;
    end
end
casi_di_0_simulati_come_0=DATI_TEST(indic2, :);

mean1=mean(casi_di_0_simulati_come_0)
mean2=mean(casi_di_0_simulati_come_1)

ris1=mean1-mean2

new1(:, 1)=new1(:, 1)+ris1(1);

new2=zscore(DATI(:, 2));
new3=zscore(DATI(:, 3));

DATI=[new1 new2 new3 DATI(:, 4)];

DATI_LERNING=DATI(1:1332, :); 
DATI_TEST=DATI(1332+1:end, :);

P_LEARNING_INPUT=DATI_LERNING(:, [1, 2, 3]);
P_LEARNING_OUTPUT=DATI_LERNING(:, 4);
P_TEST_INPUT=DATI_TEST(:, [1, 2, 3]);
P_TEST_OUTPUT=DATI_TEST(:, 4);

NET=newff(P_LEARNING_INPUT', P_LEARNING_OUTPUT', 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  NET.trainParam.epochs=1000
  NET.trainParam.max_fail=1000
  NET.trainParam.goal = 1e-9;
  NET.trainParam.lr=0.0001
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NET_TRAIN=train(NET, P_LEARNING_INPUT', P_LEARNING_OUTPUT');

LSIMULATED=sim(NET_TRAIN, P_LEARNING_INPUT');
TSIMULATED=sim(NET_TRAIN, P_TEST_INPUT');

e_learning = LSIMULATED'-P_LEARNING_OUTPUT;
e_medio_learning = mean(e_learning);

figure(1);
subplot(2, 2, 1)
plot(e_learning);
title('errore fase di learning');
xlabel('campioni');
ylabel('errore');
legend('errore')

subplot(2, 2, 2)
plot([LSIMULATED' P_LEARNING_OUTPUT]);
title('uscite desiderate vs uscite reali in learning');
xlabel('campioni');
ylabel('uscite');
legend('uscita simulata','uscita desiderata')

% e_medio_test = mean(e_learning);

for i=1:size(TSIMULATED, 2)
    if (TSIMULATED(i)>0.5)
        TSIMULATED2(i)=1;
    else
        TSIMULATED2(i)=0;
    end
end

subplot(2, 2, 3)
plot(TSIMULATED2'-P_TEST_OUTPUT);
title('errore fase di test');
xlabel('campioni');
ylabel('errore');
legend('errore')

subplot(2, 2, 4)
plot([TSIMULATED2' P_TEST_OUTPUT]);
title('uscite desiderate vs uscite reali in test');
xlabel('campioni');
ylabel('uscite');
legend('uscita simulata','uscita desiderata')

cm = confusionmat(P_TEST_OUTPUT,TSIMULATED2')

perc=cm/size(P_TEST_OUTPUT, 1)

totale=perc(1, 1)+perc(2, 2)

figure;
confusionchart(cm)