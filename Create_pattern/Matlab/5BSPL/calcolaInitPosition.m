% questa funzione serve per calcolare posizioni iniziali in maniera
% randomica. 
% X = calcolaInitPosition(maxX, maxY);
% maxX = l'estensione della mappa lungo l'asse Y
% maxY = l'estensione della mappa lungo l'asse X
% X = coordinata (x,y) generata randomicamente 

function [initPosition] = calcolaInitPosition(maxX,maxY)
    XInit 			= randi([1, maxY]);
    YInit 			= randi([1, maxX]);
    initPosition 	= [XInit, YInit];
end