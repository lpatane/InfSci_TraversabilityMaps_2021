%prova nuova rugosita
close all;
clear all;
clc;
perc = 0.9;
%calcola il valore medio della mappa con celle 5x5
[T_intera, R]	= geotiffread('polo_pad.tif');
n_downsample    = 5;

T_taglia        = (T_intera(21:360,29:273)); %taglio mappa
T_taglia        = T_taglia - min(min(T_taglia)); %normalizzazione
T_taglia        = T_taglia'
[sizeTx, sizeTy] = size(T_taglia);

%media 
%passo da vertici a caselle
for i=1:sizeTx-1 		%riga
    for j=1:sizeTy-1 	%colonna
         media(i, j)	= (T_taglia(i, j)+T_taglia(1+i, j)+T_taglia(i, 1+j)+T_taglia(1+i, 1+j))/4;
    end
end
    media(i+1, j) = media(i, j);
    media(i, j+1) = media(i, j);
    figure(1);
    surf(media);
    title('media');
% calcolo la media di ogni casella 5*5.
    for i = 1:1:(sizeTx/n_downsample)
       for j = 1:1:(sizeTy/n_downsample)
            somma = media(((1+(i-1)*n_downsample):((i)*n_downsample)),((1+(j-1)*n_downsample):((j)*n_downsample)));
            res(i,j) = sum(somma, 'all')/(n_downsample*n_downsample);
       end 
    end
    
    AvgMap = res; 
    figure(2)
    surf(AvgMap);
    
    zzz =0;
    mediaTx = sizeTx/n_downsample;
    mediaTy = sizeTy/n_downsample;
    for i = 1:1: mediaTx
       for j = 1:1: mediaTy
           k=0;
           for i2 = (((mediaTx-1)*n_downsample) +1):1:((mediaTx)*n_downsample)
               for j2 = (((mediaTy-1)*n_downsample)+1):1:((mediaTy)*n_downsample)
                   reale = T_taglia(i2,j2);
                   mediato = res(i,j);
                   if  T_taglia(i2,j2)>res(i,j)
                       k = k +1;
                   end 
               end
           end
           indicerug(i,j) = k;
        end 
    end
    figure(3);
    surf(indicerug);

  