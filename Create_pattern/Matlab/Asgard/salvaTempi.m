%questa funzione serve per poter salvare tutti i tempi all'interno della matrice dei tempi

function [matriceTempi, result] = salvaTempi(MapX, MapY, coordInit, tempoImpiegato, direction, matriceTempi) 
    x 		= coordInit(1);
    y 		= coordInit(2);
    id_nodo = (x-1)*MapX + y               % calcolo coe quello della dpa
    
    if(isnan(matriceTempi(id_nodo, direction)))
        matriceTempi(id_nodo, direction) = tempoImpiegato;
%         matriceTempi(id_nodo,5) = x;
%         matriceTempi(id_nodo,6) = y;
        result = 0;
    else
        matriceTempi(id_nodo, direction) = matriceTempi(id_nodo, direction);
        result = -1;                        %nodo già calcolato
    end
end
