SimulationParameters;
pioneerParameters;

[T,indicerug]= AvgMap(T_intera,n_downsaple,clearence);

matriceAltezze      = altezze(size(T,1),size(T,2),T);
matricePendenze     = CalcolaPendenze(matriceAltezze, P.CellExtentInWorldX);    
h_max           = max(max(T_taglia));


scaleX          = dimXVrep/ size(T,1);
scaleY          = dimYVrep/ size(T,2);
scaleZ          = (dimZVrep)/h_max;
MapX            =  size(T,1);
MapY            =  size(T,2);
tempi           = NaN(MapX*MapY,4);
i               = 1;

R = 0.1168;
L = 0.468;