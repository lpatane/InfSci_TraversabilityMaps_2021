% NB: il codice spa serve per verificare l'accuracy in test, quello
% sotto in learning

% close all
clc
clear all

load ('finale09112019.mat');

DATI=MatriceDati;

a=find(DATI(:, 1)==0);
tutti_zeri=DATI(a, :);

a=find(DATI(:, 1)==1);
tutti_uni=DATI(a, :);
tutti_uni=tutti_uni(1: 835, :);

DATI=[tutti_uni; tutti_zeri];

DATI=datasample(DATI, 1670);
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

DATI=[new1 new23 new45 new67 output new919];
tmp0=0;
tmp1=0;
tmp2=0;
tmp3=0;
tmp4=0;
tmp5=0;
tmp6=0;
tmp7=0;
tmp8=0;
tmp9=0;
tmp10=0;
tmp11=0;
num=size(DATI, 1);
blocco=80*1/100*num;

for k=1:100 %4 hidden diversi
for i=1:100 %per ogni numero di hidden ciclo 3 volte

DATI=[new1 new23 new45 new67 output new919];
DATI=datasample(DATI, 1670);

% a=DATI(:, 1:8);
DATI_LERNING=DATI(1:blocco, :);
DATI_TEST=DATI(blocco+1:end, :);

% DATI_LERNING_2=DATI(1:blocco, :); 
% DATI_TEST_2=DATI(blocco+1:end, :);

P_LEARNING_INPUT=DATI_LERNING(:, 1:4);
P_LEARNING_OUTPUT=DATI_LERNING(:, 5);
P_TEST_INPUT=DATI_TEST(:, 1:4);
P_TEST_OUTPUT=DATI_TEST(:, 5);

NET=newff(P_LEARNING_INPUT', P_LEARNING_OUTPUT', k);
clc
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

for j=1:size(TSIMULATED, 2)
    if (TSIMULATED(j)>0.5)
        TSIMULATED2(j)=1;
    else
        TSIMULATED2(j)=0;
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

cm = confusionmat(P_TEST_OUTPUT,TSIMULATED2');

perc=cm/size(P_TEST_OUTPUT, 1);

accuracy=perc(1, 1)+perc(2, 2);

sensitivity(i, k)=cm(1, 1)/(cm(1, 1)+cm(2, 1));
specificity(i, k)=cm(2, 2)/(cm(2, 2)+cm(1, 2));
figure;
confusionchart(cm);

tmp1(i, k)=accuracy; %accuracy

tmp2(i, k)=perc(1, 2); %prevedo1ede0
tmp3(i, k)=perc(2, 1); %prevedo0ede1
tmp4(i, k)=perc(1, 1); %prevedo0ede0
tmp5(i, k)=perc(2, 2); %prevedo1ede1

tmp0=tmp0+tmp1(i, k); %accuracy
tmp6=tmp6+tmp2(i, k);
tmp7=tmp7+tmp3(i, k);
tmp8=tmp8+tmp4(i, k);
tmp9=tmp9+tmp5(i, k);
tmp10=tmp10+sensitivity(i, k); %sensitivity
tmp11=tmp11+specificity(i, k); %specificity

% tmp1=tmp1+cm;
close all

end

% devstd=std(tmp)

accuracy_media(k)=tmp0/i
std_accuracy=std(tmp1)
uno_due_media(k)=tmp6/i;
due_uno_media(k)=tmp7/i;
uno_uno_media(k)=tmp8/i;
due_due_media(k)=tmp9/i;

sensitivity_media(k)=tmp10/i
std_sensitivity=std(sensitivity)
specificity_media(k)=tmp11/i
std_specificity=std(specificity)

tmp0=0;
tmp6=0;
tmp7=0;
tmp8=0;
tmp9=0;
tmp10=0;
tmp11=0;
end

% figure;
% plot(1:100, accuracy_media); title('Accuracy vs hidden neurons'); xlabel('Hidden neurons'); ylabel('Accuracy'); 
% 
% figure;
% plot(1:40, uno_due_media); title('Percentage predicted:1, true: 0'); xlabel('Hidden neurons'); ylabel('Percentage'); 
% 
% figure;
% plot(1:40, due_uno_media); title('Percentage predicted:0, true: 1 - Robotnik'); xlabel('Hidden neurons'); ylabel('Percentage'); 
% 
% figure;
% plot(1:40, uno_uno_media); title('Percentage predicted:0, true: 0 - Robotnik'); xlabel('Hidden neurons'); ylabel('Percentage'); 
% 
% figure;
% plot(1:40, due_due_media); title('Percentage predicted:1, true: 1 - Robotnik'); xlabel('Hidden neurons'); ylabel('Percentage'); 

%%%%%%%%%%%%%%%
% k=1;
% TSIMULATED2=TSIMULATED2';
% 
% for i=1:size(P_TEST_OUTPUT, 1)
%     if (P_TEST_OUTPUT(i)==0) && (TSIMULATED2(i)==1)
%         indic(k)= i;
%         k=k+1;
%     end
% end
% 
% casi_di_0_simulati_come_1=DATI_TEST(indic, :);
% clear indic
% k=1;
% 
% for i=1:size(P_TEST_OUTPUT, 1)
%     if (P_TEST_OUTPUT(i)==1) && (TSIMULATED2(i)==1)
%         indic(k)= i;
%         k=k+1;
%     end
% end
% 
% casi_di_1_simulati_come_1=DATI_TEST(indic, :);
% 
% clear indic
% k=1;
% 
% k=1;
% TSIMULATED2=TSIMULATED2';
% for i=1:size(P_TEST_OUTPUT, 1)
%     if (P_TEST_OUTPUT(i)==0) && (TSIMULATED2(i)==0)
%         indic(k)= i;
%         k=k+1;
%     end
% end
% casi_di_0_simulati_come_0=DATI_TEST(indic, :);
% 
% clear indic
% k=1;
% 
% k=1;
% TSIMULATED2=TSIMULATED2';
% for i=1:size(P_TEST_OUTPUT, 1)
%     if (P_TEST_OUTPUT(i)==1) && (TSIMULATED2(i)==0)
%         indic(k)= i;
%         k=k+1;
%     end
% end
% casi_di_1_simulati_come_0=DATI_TEST(indic, :);
% 
% mean1=mean(casi_di_0_simulati_come_0);
% mean2=mean(casi_di_0_simulati_come_1);

% close all
% clc
% clear all
% 
% load ('finale09112019.mat');
% 
% DATI=MatriceDati;
% 
% a=find(DATI(:, 1)==0);
% tutti_zeri=DATI(a, :);
% 
% a=find(DATI(:, 1)==1);
% tutti_uni=DATI(a, :);
% tutti_uni=tutti_uni(1: 835, :);
% 
% DATI=[tutti_uni; tutti_zeri];
% 
% DATI=datasample(DATI, 1670);
% new2=zscore(DATI(:, 4)); %pendenza partenza
% new3=zscore(DATI(:, 5)); %pendenza arrivo
% new4=zscore(DATI(:, 6)); %Hmax partenza
% new5=zscore(DATI(:, 7)); %Hmax arrivo
% new6=zscore(DATI(:, 8)); %rug partenza
% new7=zscore(DATI(:, 9)); %rug arrivo
% 
% new1=zscore(DATI(:, 3)); %deltaH 1
% new23=(new2+new3)/2; %pendenza 2
% for j=1:size(new4, 1) %Hmax 3
%     if new4(j)>=new5(j)
%         new45(j, 1)=new4(j);
%     else
%         new45(j, 1)=new5(j);
%     end
% end
% new67=(new6+new7)/2; %rug 4
% 
% 
% output=DATI(:, 1);
% new919=(DATI(:, 10:19));
% % new23=(new2+new3)/2;
% % new67=(new6+new7)/2;
% 
% DATI=[new1 new23 new45 new67 output new919];
% tmp0=0;
% tmp1=0;
% tmp2=0;
% tmp3=0;
% tmp4=0;
% tmp5=0;
% tmp6=0;
% tmp7=0;
% tmp8=0;
% tmp9=0;
% tmp10=0;
% tmp11=0;
% num=size(DATI, 1);
% blocco=80*1/100*num;
% 
% for k=1:150 %4 hidden diversi
% for i=1:100 %per ogni numero di hidden ciclo 3 volte
% 
% DATI=[new1 new23 new45 new67 output new919];
% DATI=datasample(DATI, 1670);
% 
% % a=DATI(:, 1:8);
% DATI_LERNING=DATI(1:blocco, :);
% DATI_TEST=DATI(blocco+1:end, :);
% 
% % DATI_LERNING_2=DATI(1:blocco, :); 
% % DATI_TEST_2=DATI(blocco+1:end, :);
% 
% P_LEARNING_INPUT=DATI_LERNING(:, 1:4);
% P_LEARNING_OUTPUT=DATI_LERNING(:, 5);
% P_TEST_INPUT=DATI_TEST(:, 1:4);
% P_TEST_OUTPUT=DATI_TEST(:, 5);
% 
% NET=newff(P_LEARNING_INPUT', P_LEARNING_OUTPUT', k);
% clc
% i
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %   NET.trainParam.epochs=10000
% %   NET.trainParam.max_fail=1000
% %   NET.trainParam.goal = 1e-9;
% %   NET.trainParam.lr=0.00001
% %   clc
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% i
% NET_TRAIN=train(NET, P_LEARNING_INPUT', P_LEARNING_OUTPUT');
% 
% TSIMULATED=sim(NET_TRAIN, P_LEARNING_INPUT');
% 
% for j=1:size(TSIMULATED, 2)
%     if (TSIMULATED(j)>0.5)
%         TSIMULATED2(j)=1;
%     else
%         TSIMULATED2(j)=0;
%     end
% end
% 
% cm = confusionmat(P_LEARNING_OUTPUT,TSIMULATED2');
% 
% perc=cm/size(P_LEARNING_OUTPUT, 1);
% 
% accuracy=perc(1, 1)+perc(2, 2);
% 
% sensitivity(i, k)=cm(1, 1)/(cm(1, 1)+cm(2, 1));
% specificity(i, k)=cm(2, 2)/(cm(2, 2)+cm(1, 2));
% figure;
% confusionchart(cm);
% 
% tmp1(i, k)=accuracy; %accuracy
% 
% tmp2(i, k)=perc(1, 2); %prevedo1ede0
% tmp3(i, k)=perc(2, 1); %prevedo0ede1
% tmp4(i, k)=perc(1, 1); %prevedo0ede0
% tmp5(i, k)=perc(2, 2); %prevedo1ede1
% 
% tmp0=tmp0+tmp1(i, k); %accuracy
% tmp6=tmp6+tmp2(i, k);
% tmp7=tmp7+tmp3(i, k);
% tmp8=tmp8+tmp4(i, k);
% tmp9=tmp9+tmp5(i, k);
% tmp10=tmp10+sensitivity(i, k); %sensitivity
% tmp11=tmp11+specificity(i, k); %specificity
% 
% % tmp1=tmp1+cm;
% close all
% 
% end
% 
% % devstd=std(tmp)
% 
% accuracy_media(k)=tmp0/i
% std_accuracy=std(tmp1)
% uno_due_media(k)=tmp6/i;
% due_uno_media(k)=tmp7/i;
% uno_uno_media(k)=tmp8/i;
% due_due_media(k)=tmp9/i;
% 
% sensitivity_media(k)=tmp10/i
% std_sensitivity=std(sensitivity)
% specificity_media(k)=tmp11/i
% std_specificity=std(specificity)
% 
% tmp0=0;
% tmp6=0;
% tmp7=0;
% tmp8=0;
% tmp9=0;
% tmp10=0;
% tmp11=0;
% end
% 
%  figure;
%  plot(1:150, accuracy_media); title('Accuracy vs hidden neurons'); xlabel('Hidden neurons'); ylabel('Accuracy'); 
% % 
% % figure;
% % plot(1:40, uno_due_media); title('Percentage predicted:1, true: 0'); xlabel('Hidden neurons'); ylabel('Percentage'); 
% % 
% % figure;
% % plot(1:40, due_uno_media); title('Percentage predicted:0, true: 1 - Robotnik'); xlabel('Hidden neurons'); ylabel('Percentage'); 
% % 
% % figure;
% % plot(1:40, uno_uno_media); title('Percentage predicted:0, true: 0 - Robotnik'); xlabel('Hidden neurons'); ylabel('Percentage'); 
% % 
% % figure;
% % plot(1:40, due_due_media); title('Percentage predicted:1, true: 1 - Robotnik'); xlabel('Hidden neurons'); ylabel('Percentage'); 
% 
% %%%%%%%%%%%%%%%
% % k=1;
% % TSIMULATED2=TSIMULATED2';
% % 
% % for i=1:size(P_TEST_OUTPUT, 1)
% %     if (P_TEST_OUTPUT(i)==0) && (TSIMULATED2(i)==1)
% %         indic(k)= i;
% %         k=k+1;
% %     end
% % end
% % 
% % casi_di_0_simulati_come_1=DATI_TEST(indic, :);
% % clear indic
% % k=1;
% % 
% % for i=1:size(P_TEST_OUTPUT, 1)
% %     if (P_TEST_OUTPUT(i)==1) && (TSIMULATED2(i)==1)
% %         indic(k)= i;
% %         k=k+1;
% %     end
% % end
% % 
% % casi_di_1_simulati_come_1=DATI_TEST(indic, :);
% % 
% % clear indic
% % k=1;
% % 
% % k=1;
% % TSIMULATED2=TSIMULATED2';
% % for i=1:size(P_TEST_OUTPUT, 1)
% %     if (P_TEST_OUTPUT(i)==0) && (TSIMULATED2(i)==0)
% %         indic(k)= i;
% %         k=k+1;
% %     end
% % end
% % casi_di_0_simulati_come_0=DATI_TEST(indic, :);
% % 
% % clear indic
% % k=1;
% % 
% % k=1;
% % TSIMULATED2=TSIMULATED2';
% % for i=1:size(P_TEST_OUTPUT, 1)
% %     if (P_TEST_OUTPUT(i)==1) && (TSIMULATED2(i)==0)
% %         indic(k)= i;
% %         k=k+1;
% %     end
% % end
% % casi_di_1_simulati_come_0=DATI_TEST(indic, :);
% % 
% % mean1=mean(casi_di_0_simulati_come_0);
% % mean2=mean(casi_di_0_simulati_come_1);
