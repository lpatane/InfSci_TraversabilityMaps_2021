%File di avvio per la simulazione e il calcolo dei maggiori parametri:
%differenza di altezza punto-punto(m),attrito(adimensionale),
%rugosità(micrometri->10^-6 m),%pendenza(gradi),tempistiche(s).
%PRIMA PARTE: Acquisizione mappa e opportuni ritagli legati a zona di
%percorrenza robot
%SECONDA PARTE: calcolo parametri sopra elencati. 

%Per salvataggio di mappa usato il seguente codice
% 
% [T_intera, R1]=geotiffread('C:\Users\Salvo\Desktop\13_Sett_Robotnik\polo_pad.tif');
% T_taglia    = (T_intera(21:360,29:273));
% T           = AvgMap(T_intera,5);


% T=T*0.3;
% T=uint8(T);
% % % T=Downsample_map(T_taglia,n_downsaple);
% % % T = (T - min(min(T))); %normalizzazione delle altezze in cm.
% T=T';
% imwrite(T,'Taglia.png');

close all 
clear all
clc 

%CARICAMENTO MAPPA ORIGINALE
SimulationParameters
T_taglia    = (T_intera(21:360,29:273));
load ('Rugosita_finale.mat');

% [Rugosita]=Rugosita_finale(T_taglia);

[T ,Traversabilita] = AvgMap(T_intera,n_downsaple, clearence);
h_max       = max(max(T));

figure;
surf(T);

% figure;
% surf(Traversabilita);
% 
% Traversabilita  = reshape(Traversabilita,(size(Traversabilita,1)*size(Traversabilita,2)),1);

%valori utili per conversione di scala da matlab a Vrep.
scaleX  = dimXVrep/ size(T,1);
scaleY  = dimYVrep/ size(T,2);
scaleZ  = (dimZVrep)/h_max;
s       = [scaleX, scaleY, scaleZ];

matriceAltezze      = altezze(size(T,1),size(T,2),T);
pendenze_nuove=calcolaPendenze(T);
hmax=calcolaHmaxlungopercorso(T_taglia);


% figure;
% surf(reshape(matriceAltezze(:, 1),[49, 68]))
% figure;
% surf(reshape(matriceAltezze(:, 2),[49, 68]))
% figure;
% surf(reshape(matriceAltezze(:, 3),[49, 68]))
% figure;
% surf(reshape(matriceAltezze(:, 4),[49, 68]))

matricePendenze     = CalcolaPendenze_vecchio(matriceAltezze, P.CellExtentInWorldX); 
pendmax             = max(matricePendenze(:));
pendenze            = matricePendenze/pendmax;

[totalepattern] = totali_pattern(matriceAltezze, Rugosita, pendenze_nuove, hmax)

[matriceTempi, tmp, ...
alfaAngle, betaAngle, gammaAngle, ...
coordinate_nodo_partenza1, coordinate_nodo_partenza2, coordinate_nodo_arrivo1, coordinate_nodo_arrivo2, direzione, nodo_partenza, nodo_arrivo, matriceRug_partenza, matriceRug_arrivo, pendenza_partenza, pendenza_arrivo, hmax_partenza, hmax_arrivo ] = ...
calcolo_tempistiche_indici(T, dt,maximumTime,minimumTime,s, percent, graph,pendenze, Rugosita, pendenze_nuove, hmax);

[MatriceDati] = calcolaInputRete(matriceAltezze, matriceTempi, matriceRug_partenza, matriceRug_arrivo, T, alfaAngle, betaAngle, gammaAngle, nodo_partenza, nodo_arrivo, coordinate_nodo_partenza1, coordinate_nodo_partenza2, coordinate_nodo_arrivo1, coordinate_nodo_arrivo2, direzione, pendenza_partenza, pendenza_arrivo, hmax_partenza, hmax_arrivo);

[NotReached, TooFast, Reached] = Statistica(matriceTempi);

if stats == 1
    
end
save('ResultRugosita.mat', 'Rugosita');
save('ResultAltezze.mat' , 'matriceAltezze');
save('ResultPendenze.mat', 'matricePendenze');
save('ResultTempi.mat'   , 'matriceTempi');
save('ResultRugositaStart.mat', 'Traversabilita');
% save('indice_di_slip.mat', 'indice_di_slip');
save('output','MatriceDati'); %poi fallo coi indici! cambia qui, riga 47, il nome a riga 62 e poi in simualtionparameters
%Suona(song);
