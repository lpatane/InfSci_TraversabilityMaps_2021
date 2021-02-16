load ('totale_patteren_input_e_output.mat');

load ('dim.mat');
load ('T_mediata.mat');

[sizeTx, sizeTy]=size(T_mediata);
nord=reshape(totale_patteren_input_e_output(1:dim, 5), [sizeTx sizeTy]);

est=reshape(totale_patteren_input_e_output(dim+1:dim*2, 5), [sizeTx sizeTy]);

sud=reshape(totale_patteren_input_e_output(dim*2+1:dim*3, 5), [sizeTx sizeTy]);

ovest=reshape(totale_patteren_input_e_output(dim*3+1:dim*4, 5), [sizeTx sizeTy]);

nord_est=reshape(totale_patteren_input_e_output(dim*4+1:dim*5, 5), [sizeTx sizeTy]);

nord_ovest=reshape(totale_patteren_input_e_output(dim*5+1:dim*6, 5), [sizeTx sizeTy]);

sud_est=reshape(totale_patteren_input_e_output(dim*6+1:dim*7, 5), [sizeTx sizeTy]);

sud_ovest=reshape(totale_patteren_input_e_output(dim*7+1:dim*8, 5), [sizeTx sizeTy]);

%da qui in poi setto per ottenere ciò spiegato nella publicazione pag 3

%NORD
tmp(sizeTx, sizeTy)=0;
tmp(2:end, :)=nord(1:end-1, :);
tmp(1, :)=1;
nord=tmp;
clear tmp

%SUD
tmp(sizeTx, sizeTy)=0;
tmp(1:end-1, :)=sud(2:end, :);
tmp(end, :)=1;
sud=tmp;
clear tmp

%EST
tmp(sizeTx, sizeTy)=0;
tmp(1:end, 2:end)=est(1:end, 1:end-1);
tmp(1:end, 1)=est(:, end);
tmp(1:end, 1)=1;
est=tmp;
clear tmp

%OVEST
tmp(sizeTx, sizeTy)=0;
tmp(1:end, 1:end-1)=ovest(1:end, 2:end);
tmp(1:end, end)=ovest(:, 1);
tmp(1:end, end)=1;
ovest=tmp;
clear tmp

%NORD-EST OK
orig=nord_est;
nord_est(:, 1)=1;
nord_est(1, :)=1;

for i=3:sizeTx
    for j=3:sizeTy
        nord_est(i, j)=orig(i-1,j-1);            
    end
end
clear orig

%NORD-OVEST OK
orig=nord_ovest;
nord_ovest(:, end)=1;
nord_ovest(1, :)=1;

for i=2:sizeTx
    for j=1:sizeTy-1
        nord_ovest(i, j)=orig(i-1,j+1);
            
    end
end
clear orig


%SUD-EST OK
sud_est(:, 1)=1;
sud_est(end, :)=1;
orig=sud_est;

for i=1:sizeTx-1
    for j=2:sizeTy
         sud_est(i, j)=orig(i+1,j-1);
            
    end
end

%SUD-OVEST OK
sud_ovest(end, :)=1;
sud_ovest(:, end)=1;
orig=sud_ovest;

for i=1:sizeTx-1
    for j=1:sizeTy-1
        sud_ovest(i, j)=orig(i+1,j+1);
        
        
    end
end

%il codice sotto serve per sogliare
soglia=0.5;

for i=1:size(nord, 1) %righe
    for j=1:size(nord, 2)
        if(nord(i, j)>=soglia)
            nord(i, j)=1000; %non ci arrivo
        else
            nord(i, j)=nord(i, j); %ci arrivo
        end
    end
end

for i=1:size(sud, 1) %righe
    for j=1:size(sud, 2)
        if(sud(i, j)>=soglia)
            sud(i, j)=1000;
        else
            sud(i, j)=sud(i, j);
        end
    end
end

for i=1:size(est, 1) %righe
    for j=1:size(est, 2)
        if(est(i, j)>=soglia)
            est(i, j)=1000;
        else
            est(i, j)=est(i, j);
        end
    end
end

for i=1:size(ovest, 1) %righe
    for j=1:size(ovest, 2)
        if(ovest(i, j)>=soglia)
            ovest(i, j)=1000;
        else
            ovest(i, j)=ovest(i, j);
        end
    end
end

for i=1:size(nord_est, 1) %righe
    for j=1:size(nord_est, 2)
        if(nord_est(i, j)>=soglia)
            nord_est(i, j)=1000;
        else
            nord_est(i, j)=nord_est(i, j);
        end
    end
end

for i=1:size(nord_ovest, 1) %righe
    for j=1:size(nord_ovest, 2)
        if(nord_ovest(i, j)>=soglia)
            nord_ovest(i, j)=1000;
        else
            nord_ovest(i, j)=nord_ovest(i, j);
        end
    end
end

for i=1:size(sud_est, 1) %righe
    for j=1:size(sud_est, 2)
        if(sud_est(i, j)>=soglia)
            sud_est(i, j)=1000;
        else
            sud_est(i, j)=sud_est(i, j);
        end
    end
end

for i=1:size(sud_ovest, 1) %righe
    for j=1:size(sud_ovest, 2)
        if(sud_ovest(i, j)>=soglia)
            sud_ovest(i, j)=1000;
        else
            sud_ovest(i, j)=sud_ovest(i, j);
        end
    end
end

% 
save('.\maps\nord.mat', 'nord');
save('.\maps\sud.mat','sud');
save('.\maps\est.mat','est');
save('.\maps\ovest.mat','ovest');
save('.\maps\nord_est.mat','nord_est');
save('.\maps\nord_ovest.mat','nord_ovest');
save('.\maps\sud_est.mat','sud_est');
save('.\maps\sud_ovest.mat','sud_ovest');

% figure; surf(nord);
% figure; surf(sud);
% figure; surf(est);
% figure; surf(ovest);
% figure; surf(nord_est);
% figure; surf(nord_ovest);
% figure; surf(sud_est);
% figure; surf(sud_ovest);
