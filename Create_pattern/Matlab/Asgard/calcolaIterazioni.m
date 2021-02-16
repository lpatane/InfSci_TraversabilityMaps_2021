% questa funzione permette di calcolare il numero di iterazioni necessarie
% per poter allenare la rete neurale. questa funzione va bene con qualsiasi
% mappa. 
% i parametri da passare in ingresso sono la mappa di cui bisogna calcolare
% le iterazioni e la percentuale di itereazioni necessarie per far
% funzionare il programma.Tale valore percentuale può essere passato come 
% valore inferiore ad 1, cioè 0.76 = 76%, sia come valore intero compreso 
% tra 1 e 100 come ad esempio 76 = 76%


function [k_iterazioni] = calcolaIterazioni(Map, percent)
    sizeX 		= size(Map,1);
    sizeY 		= size(Map,2);
    val 		= sizeX*sizeY;
    val 		= val*4;    %sono 4 perchè, per ogni casella abbiamo bisogno di N,S,E,W
    if (1<percent) && (percent<=100)
       numero_iterazioni 	= val*percent/100;
    end
    
    if (0<percent)&& (percent<=1)
       numero_iterazioni 	= val*percent;
    end
    
    if percent>100
       disp('Inserire un intervallo di percentuale valido per il calcolo delle interazioni');
       numero_iterazioni 	= NaN;
    end
	
    k_iterazioni 			= ceil(numero_iterazioni);
end