%NB: il codice sopra serve per verificare l'accuracy in test, quello
%sotto in learning

clear all;
clc;

load ('pattern_LucaDiStefano.mat');
tmp0=0;
tmp1=0;
tmp2=0;
DATI=MatriceDati;

a=find(DATI(:, 1)==0);
tutti_zeri=DATI(a, :);
dim=size(tutti_zeri, 1);

a=find(DATI(:, 1)==1);
tutti_uni=DATI(a, :);
tutti_uni=tutti_uni(1: dim, :);

DATI=[tutti_uni; tutti_zeri];

Data.input=DATI(:, [3, 4, 6, 8]);
Data.output=DATI(:, 1);

Data.dataset=[Data.input Data.output]; %All features (Paper SMC 2019)

datifin=[Data.input Data.output];

%[Data.learn Data.vald Data.test]=dividerand(Data.dataset',0.8,0,0.2);

%names=['a' 'b' 'c' 'd'];

for k=1:150 %100 hidden diversi AUMETALO PER PIU' HIDDEN!!!
    for i=1:100 %per ogni numero di hidden ciclo 100 volte
    
    [Data.learn Data.vald Data.test]=dividerand(Data.dataset',0.8,0,0.2);
    BaggedEnsemble = TreeBagger(k,Data.learn(1:end-1,:)',Data.learn(end,:),'OOBPred','On','Method', 'classification', 'MaxNumSplits', 1000);
%    oobErrorBaggedEnsemble = oobError(BaggedEnsemble);
%    oobAccuracy(i, 1) = 1 - oobError(BaggedEnsemble, 'mode', 'ensemble')

%     ClassTreeEns = fitensemble(Data.input,Data.output,'AdaBoostM1', 1000, 'Tree')
%     rsLoss = resubLoss(ClassTreeEns,'Mode','Cumulative');
%     fin=1-rsLoss;

    %
    output=Data.output;
    TreeOutput = predict(BaggedEnsemble, Data.test(1:end-1,:)');
    TreeOutput=str2double(TreeOutput);
    %[pred_model2r_oobY1, pred_model2r_oobY1scores] = oobPredict(BaggedEnsemble);
    %pred_model2r_oobY1=str2double(pred_model2r_oobY1);
    %B = [pred_model2r_oobY1{:,1}];
    %B=str2double(B);
    cm = confusionmat(Data.test(end,:)', TreeOutput)
    %disp(dataset({conf,classorder{:}}, 'obsnames', classorder));

    %Mdl = TreeBagger(32,Data.input, Data.output, names);

    %perc=cm/size(Data.test(end,:)', 1);
perc=cm/size(Data.test(end,:)', 1);

    accuracy(i, k)=perc(1, 1)+perc(2, 2);
    tmp0=tmp0+accuracy(i, k); %accuracy

    sensitivity(i, k)=cm(1, 1)/(cm(1, 1)+cm(2, 1));
    specificity(i, k)=cm(2, 2)/(cm(2, 2)+cm(1, 2));
    tmp1=tmp1+sensitivity(i, k); %sensitivity
    tmp2=tmp2+specificity(i, k); %specificity
    
    figID = figure;
    %plot(oobErrorBaggedEnsemble)
    %xlabel 'Number of grown trees';
    %ylabel 'Out-of-bag classification error';
    %print(figID, '-dpdf', sprintf('randomforest_errorplot_%s.pdf', date));
    oobPredict(BaggedEnsemble)
    % view trees
   % view(BaggedEnsemble.Trees{1}) % text description
   % view(BaggedEnsemble.Trees{1},'mode','graph') % graphic description
   close all;
end

accuracy_media(k)=tmp0/i
std_accuracy=std(accuracy)

sensitivity_media(k)=tmp1/i
std_sensitivity=std(sensitivity)

specificity_media(k)=tmp2/i
std_specificity=std(specificity)

tmp0=0;
tmp1=0;
tmp2=0;
end

plot(accuracy_media)

% clear all;
% clc;
% 
% load ('pattern_LucaDiStefano.mat');
% tmp0=0;
% tmp1=0;
% tmp2=0;
% DATI=MatriceDati;
% 
% a=find(DATI(:, 1)==0);
% tutti_zeri=DATI(a, :);
% dim=size(tutti_zeri, 1);
% 
% a=find(DATI(:, 1)==1);
% tutti_uni=DATI(a, :);
% tutti_uni=tutti_uni(1: dim, :);
% 
% DATI=[tutti_uni; tutti_zeri];
% 
% Data.input=DATI(:, [3, 4, 6, 8]);
% Data.output=DATI(:, 1);
% 
% Data.dataset=[Data.input Data.output]; %All features (Paper SMC 2019)
% 
% datifin=[Data.input Data.output];
% 
% %[Data.learn Data.vald Data.test]=dividerand(Data.dataset',0.8,0,0.2);
% 
% %names=['a' 'b' 'c' 'd'];
% 
% for k=1:150 %100 hidden diversi AUMETALO PER PIU' HIDDEN!!!
%     for i=1:100 %per ogni numero di hidden ciclo 100 volte
%     
%     [Data.learn Data.vald Data.test]=dividerand(Data.dataset',0.8,0,0.2);
%     BaggedEnsemble = TreeBagger(k,Data.learn(1:end-1,:)',Data.learn(end,:),'OOBPred','On','Method', 'classification', 'MaxNumSplits', 1000);
% %    oobErrorBaggedEnsemble = oobError(BaggedEnsemble);
% %    oobAccuracy(i, 1) = 1 - oobError(BaggedEnsemble, 'mode', 'ensemble')
% 
% %     ClassTreeEns = fitensemble(Data.input,Data.output,'AdaBoostM1', 1000, 'Tree')
% %     rsLoss = resubLoss(ClassTreeEns,'Mode','Cumulative');
% %     fin=1-rsLoss;
% 
%     %
%     output=Data.output;
%     TreeOutput = predict(BaggedEnsemble, Data.learn(1:end-1,:)');
%     TreeOutput=str2double(TreeOutput);
%     %[pred_model2r_oobY1, pred_model2r_oobY1scores] = oobPredict(BaggedEnsemble);
%     %pred_model2r_oobY1=str2double(pred_model2r_oobY1);
%     %B = [pred_model2r_oobY1{:,1}];
%     %B=str2double(B);
%     cm = confusionmat(Data.learn(end,:)', TreeOutput)
%     %disp(dataset({conf,classorder{:}}, 'obsnames', classorder));
% 
%     %Mdl = TreeBagger(32,Data.input, Data.output, names);
% 
%     %perc=cm/size(Data.learn(end,:)', 1);
% perc=cm/size(Data.learn(end,:)', 1);
% 
%     accuracy(i, k)=perc(1, 1)+perc(2, 2);
%     tmp0=tmp0+accuracy(i, k); %accuracy
% 
%     sensitivity(i, k)=cm(1, 1)/(cm(1, 1)+cm(2, 1));
%     specificity(i, k)=cm(2, 2)/(cm(2, 2)+cm(1, 2));
%     tmp1=tmp1+sensitivity(i, k); %sensitivity
%     tmp2=tmp2+specificity(i, k); %specificity
%     
%     figID = figure;
%     %plot(oobErrorBaggedEnsemble)
%     %xlabel 'Number of grown trees';
%     %ylabel 'Out-of-bag classification error';
%     %print(figID, '-dpdf', sprintf('randomforest_errorplot_%s.pdf', date));
%     oobPredict(BaggedEnsemble)
%     % view trees
%    % view(BaggedEnsemble.Trees{1}) % text description
%    % view(BaggedEnsemble.Trees{1},'mode','graph') % graphic description
%    close all;
% end
% 
% accuracy_media(k)=tmp0/i
% std_accuracy=std(accuracy)
% 
% sensitivity_media(k)=tmp1/i
% std_sensitivity=std(sensitivity)
% 
% specificity_media(k)=tmp2/i
% std_specificity=std(specificity)
% 
% tmp0=0;
% tmp1=0;
% tmp2=0;
% end
% 
% plot(accuracy_media)
