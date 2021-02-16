% questa funzione serve per calcolare la posizione target a partire da una
% posizione nota InitPosition descritta in coordinate X,Y.
% La posizione finale si trova a distanza 1 
% InitPosition = coordinata di partenza espressa in (x,y)
% target è un vettore che restituisce posizione finale, direzione dello
% spostamento e angolo sull'asse z
% Posizione finale è composta da target(1) e target(2) in cui target(1) = x
% e target(2) = y.
% Direction è data un valore numerico
%   1 = Nord;
%   2 = Est;
%   3 = Sud;
%   4 = Ovest;
% Da questi valori viene calcolato gamma, ossia l'angolo espresso in gradi
% lungo l'asse z.
% Se una coordinata iniziale si trova sul bordo, e la sua coordinata finale
% si trova ad indice 0, restituisce NaN

function [target] = calcolaTarget(InitPosition, Map)
    continua 		= 1;
    while continua == 1
        direction 	= randi([1,4]);
        switch direction
            case 1 %verso Nord
                pos_finaleX = InitPosition(1);
                pos_finaleY = InitPosition(2)+1;
                gamma 		= 0;
                continua 	= 0;

            case 2 %verso Est
                pos_finaleX = InitPosition(1)+1;
                pos_finaleY = InitPosition(2);
                gamma 		= -pi/2;
                continua 	= 0;

            case 3 %verso Sud
                pos_finaleX = InitPosition(1);
                pos_finaleY = InitPosition(2)-1;
                gamma 		= pi;
                continua 	= 0;

            case 4 %verso Ovest
                pos_finaleX = InitPosition(1)-1;
                pos_finaleY = InitPosition(2);
                gamma 		= pi/2;
                continua 	= 0;
        end

        if(pos_finaleX == 0 || pos_finaleY == 0 ...
			|| pos_finaleX == (size(Map,1) + 1)|| pos_finaleY == (size(Map,2) + 1 )...
			|| pos_finaleY == (size(Map,1) + 1)|| pos_finaleX == (size(Map,2) + 1))
                pos_finaleX = NaN;
                pos_finaleY = NaN;
                continua  	= 1;            
        end        
    end
	
    target = [pos_finaleX, pos_finaleY; direction, gamma];
end
