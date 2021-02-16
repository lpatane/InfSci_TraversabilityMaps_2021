
%questa funzione permette di calcolare la matrice della media e della
%rugosità. I parametri sono:
%T_intera -> è la mappa, in condizioni iniziali, che si deve passare;
%n_downsample-> è il valore del downsample da applicare, di cui viene calcolata la media.
%clearence-> è il valore da applicare, in funzione dell'altezzza del robot
%ceh si utilizza

function [AvgMap, Traversabilita,T_taglia] = AvgMap(T_intera,n_downsample, clearence)

%calcola il valore medio della mappa con celle 5x5
T_taglia        = (T_intera(21:360,29:273)); %taglio mappa
T_taglia        = T_taglia - min(min(T_taglia)); %normalizzazione
[sizeTx, sizeTy] = size(T_taglia);

%passo da vertici a caselle
for i=1:sizeTx-1 		%riga
    for j=1:sizeTy-1 	%colonna
         media(i, j)	= (T_taglia(i, j)+T_taglia(1+i, j)+T_taglia(i, 1+j)+T_taglia(1+i, 1+j))/4;
    end
end
    media(i+1, j) = media(i, j);
    media(i, j+1) = media(i, j);

% calcolo la media di ogni casella 5*5.
    for i = 1:1:(sizeTx/n_downsample)
       for j = 1:1:(sizeTy/n_downsample)
            somma = media(((1+(i-1)*n_downsample):((i)*n_downsample)),((1+(j-1)*n_downsample):((j)*n_downsample)));
            res(i,j) = sum(somma(:))/(n_downsample*n_downsample);
       end 
    end
    
    AvgMap = res';
%     [sizeTx, sizeTy] = size(AvgMap);
    mediaTy = sizeTx/n_downsample;
    mediaTx = sizeTy/n_downsample;
    for i = 1:1: mediaTx
       for j = 1:1: mediaTy
           k=0;
           for i2 = ((i-1)*n_downsample +1):(i)*n_downsample
               for j2 = ((j-1)*n_downsample +1):(j)*n_downsample
                   if  abs(media(j2,i2) - AvgMap(i,j)) > clearence
                       k = k +1;
                   end 
                   indicerug(i,j) = k;
               end
           end  
        end 
    end
    
    Traversabilita = indicerug;
end