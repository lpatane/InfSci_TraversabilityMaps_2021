function [patterningresso_non_mediati_senza_zscore] = totali_pattern(matriceAltezze, Rugosita, pendenze_nuove, hmax)

save('matrice_altezze', 'matriceAltezze'); 
%Altezze     = reshape(matriceAltezze,(size(matriceAltezze,1)*size(matriceAltezze,2)),1);

pendenze_nuove       = reshape(pendenze_nuove, (size(pendenze_nuove,1)*size(pendenze_nuove,2)),1); 

hmax       = reshape(hmax, (size(hmax,1)*size(hmax,2)),1); 

Rugosita       = reshape(Rugosita, (size(Rugosita,1)*size(Rugosita,2)),1); 

Rugosita_fin=[Rugosita; Rugosita; Rugosita; Rugosita];

hmax_fin=[hmax; hmax; hmax; hmax];

% a=zscore(Altezze); 
% b=zscore(pendenze_nuove); 
% c=zscore(hmax_fin); 
% d=zscore(Rugosita_fin); 
tmp=rand(size(pendenze_nuove, 1), 1);

patterningresso_non_mediati_senza_zscore=[tmp pendenze_nuove hmax_fin Rugosita_fin ]; %Altezze(1:13328) non la userò, la cambio in pattern_18122019.m
dim=size(patterningresso_non_mediati_senza_zscore, 1)/4;

save('dim', 'dim');
%save('C:\Users\Salvo\Desktop\proseguimento\generazione mappe di trav\dim', 'dim');
save('patterningresso_non_mediati_senza_zscore', 'patterningresso_non_mediati_senza_zscore');
%in uscita ho "patterningresso_non_mediati_senza_zscore.mat"

% totalepattern=zscore(totalepattern);



end