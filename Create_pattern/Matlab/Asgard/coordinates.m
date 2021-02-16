function [inizio, fine, direction, gammaAngle,coordInit] = coordinates(Map, s)

    coordInit           = calcolaInitPosition(size(Map,1), size(Map,2));
    finalPositionElem   = calcolaTarget(coordInit, Map);
    coordFin            = [finalPositionElem(1, 1), finalPositionElem(1, 2)];
    direction           = finalPositionElem(2, 1);
    gammaAngle          = finalPositionElem(2, 2);
    zInit               = Map(coordInit(2), coordInit(1));
    zFin                = Map(coordFin(2),  coordFin(1));

    %conversione di coordinate
    maxZ = max(zFin, zInit);
    inizio              = [coordInit(2)*s(2), -coordInit(1)*s(1), maxZ*s(3)+0.15]; %sono le coordinate che vengono usate in calcolo_tempistiche 
                                                                                  %e sono le coordinate della mappa mediata moltiplicate 
                                                                                  %per un fattore di scala per adattarsi alla mappa vrep intera
    fine                = [coordFin(2)*s(2),  -coordFin(1)*s(1),  maxZ*s(3)];
end

    %inizio              = [coordInit(2)*s(2), -coordInit(1)*s(1), maxZ*s(3)+0.23]; %robot grande