
%CARICAMENTO MAPPA ORIGINALE
n_downsaple		= 5; %change the downsample value
clearence       = 1;

%SCOMMENTARE O COMMENTARE I TERRENI IN BLOCCO

%terrain 1
[T_intera, P]	= geotiffread('Terreno1.tif');
T_taglia    = (T_intera(21:360,29:273));
T_intera=[];
T_intera=T_taglia;
load ('Rugosita_terreno1.mat');

%terrain 2
% load('terreno3');
% T_intera=terreno3;
% T_intera=im2single(T_intera);
% % load ('Rugosita_terreno3_5down.mat'); 
% % load ('Rugosita_terreno3_32down.mat'); 
% load ('Rugosita_terreno3_16down.mat'); 

% % %terrain 3
% load('terreno2');
% T_intera=terreno2;
% T_intera=im2single(T_intera);
% T_intera=T_intera(1:510, 1:510); %perchè 513 non è divisibile per 5!

% load ('Rugosita_terreno2_5down.mat');
% load ('Rugosita_terreno2_10down.mat');




%terreno 3 ridotto
% load('terreno3_ridotto');
% T_intera=terreno3;
% T_intera=im2single(T_intera);
% load ('Rugosita_terreno3ridotto_5down.mat'); 

% % %terreno 4
% load('terreno4');
% T_intera=terreno4;
% T_intera=im2single(T_intera);
% T_intera=T_intera(1:510, 1:510); %perchè 513 non è divisibile per 5!
% % for i=1:size(terreno4, 1)
% %     for j=1:size(terreno4, 2)
% %         if terreno4(i, j)>10
% %             terreno4(i, j)=10;
% %         end
% %     end
% % end
% load ('Rugosita_terreno4_5down.mat'); 

% [Rugosita]=Rugosita_finale(T_intera, n_downsaple);

[T_mediata ,Traversabilita] = AvgMap(T_intera,n_downsaple, clearence);
% T_mediata=T_mediata';
% r=reshape(Rugosita, [320, 180]);
% r=r';
% figure; surf(r)
% figure; surf(T_mediata)
% Rugosita=reshape(r, [320*180, 1]);

save('T_mediata','T_mediata')
% figure; surf(T_mediata);
h_max       = max(max(T_mediata));

matriceAltezze      = altezze(size(T_mediata,1),size(T_mediata,2),T_mediata);

pendenze_nuove=calcolaPendenze(T_mediata);

hmax=calcolaHmaxlungopercorso(T_intera, n_downsaple);

[patterningresso_non_mediati_senza_zscore] = genera_pattern_non_mediati(matriceAltezze, Rugosita, pendenze_nuove, hmax)

genera_pattern_finali(T_intera);

