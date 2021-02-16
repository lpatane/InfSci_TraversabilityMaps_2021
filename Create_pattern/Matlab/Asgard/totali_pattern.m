function [totalepattern] = calcolaInputRete(matriceAltezze, Rugosita, pendenze_nuove, hmax)

Altezze     = reshape(matriceAltezze,(size(matriceAltezze,1)*size(matriceAltezze,2)),1);

pendenze_nuove       = reshape(pendenze_nuove, (size(pendenze_nuove,1)*size(pendenze_nuove,2)),1); 

hmax       = reshape(hmax, (size(hmax,1)*size(hmax,2)),1); 

Rugosita_fin=[Rugosita; Rugosita; Rugosita; Rugosita];

hmax_fin=[hmax; hmax; hmax; hmax];

a=zscore(Altezze); 
b=zscore(pendenze_nuove); 
c=zscore(hmax_fin); 
d=zscore(Rugosita_fin); 


totalepattern=[a b c d ];
% totalepattern=zscore(totalepattern);



end