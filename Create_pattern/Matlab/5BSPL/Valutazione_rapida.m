% puntini = [65, 4; 11,28; 61,4;35,6;4,13;16,7;13,39;26,19;49,15;64,25;64,38;56,30;35,44;42,24;28,32;20,30;4,44;18,22;38,24;59,25;50,45];
% puntifin = [65, 5; 10,28; 61,5;34,6;4,14;17,7;13,38;27,19;48,15;63,25;63,38;56,31;35,43;42,23;27,32;21,30;4,45;19,22;37,24;58,25;50,44];
% direction = [3; 2; 3;2;3;4;1;4;2;2;2;3;1;1;2;4;3;4;2;2;1];
% alfaAngle=[];
% betaAngle=[];
% gammaAngle = [0; pi/2; 0; pi/2;0;-pi/2;pi;-pi/2;pi/2;pi/2;pi/2;0;pi;pi;pi/2;-pi/2;0;-pi/2;pi/2;pi/2;pi];
clear all
clc
load('casi_di_0_simulati_come_1');
puntini         = casi_di_0_simulati_come_1(:, 14:15);
puntifin        = casi_di_0_simulati_come_1(:, 16:17);
direction       = casi_di_0_simulati_come_1(:, 18);
alfaAngle       = casi_di_0_simulati_come_1(:, 9);
betaAngle       = casi_di_0_simulati_come_1(:, 10);
gammaAngle      = casi_di_0_simulati_come_1(:, 11);
stop=0;
l=0;
SimulationParameters;
pioneerParameters;

[T,indicerug,T_taglia]   = AvgMap(T_intera,n_downsaple,clearence);
% matriceAltezze           = altezze(size(T,1),size(T,2),T);
% matricePendenze          = CalcolaPendenze(matriceAltezze, P.CellExtentInWorldX);    
% 
h_max           = max(max(T)); %h_max = max(max(T_taglia)); CAMBIATOOO!!

scaleX          = dimXVrep/ size(T,1);
scaleY          = dimYVrep/ size(T,2);
scaleZ          = (dimZVrep)/h_max;
MapX            =  size(T,1);
MapY            =  size(T,2);
tempi           = NaN(MapX*MapY,4);

for i=1:1:133
%     for j=1:1:20
     driver      		= SimulationDriver();
     landed             = 0;
     i
     cond               = 0;
     l=0;
     tempoDelta=0;
%       inizio             = [puntini(1,1),puntini(2,1)];
%       fine               = [puntifin(1,1),puntifin(2,1)];
 
      zInit               = T(puntini(i, 2), puntini(i, 1));
      zFin                = T(puntifin(i, 2),  puntifin(i, 1));
      maxZ                = max(zFin, zInit);
      nodo                = (puntini(i,1)-1)*49+puntini(i,2);
     %betaAngle           = matricePendenze(nodo,direction(i));

      inizio = [puntini(i, 2)*scaleY, -puntini(i, 1)*scaleX, maxZ*scaleZ+0.115]
      fine   = [puntifin(i, 2)*scaleY,  -puntifin(i, 1)*scaleX, maxZ*scaleZ]
%     [inizio, fine, direction, gammaAngle,coordInit] = coordinates(Map, s);


     driver.PosRoverECuboi(inizio, fine, alfaAngle(i,:), betaAngle(i,:), gammaAngle(i,:)); 
     
%      driver.PosCuboid(puntifin);

     converter           = Converter(R,L);    							 % dichiaro il converter
     tracker             = Tracker(dt,converter,20); 
     current_target      = [fine(1),fine(2)]'                   % mi definisco il goal ad ogni punto
     planner             = LowLevelPlanner(tracker,dt);               % mi definisco i planner
     planner             = planner.setGoalPosition(current_target);   % assegno il goal da raggingere
     rover_BlaNoce       = Rover(planner,driver,robot,dt);            % mi definisco il rover con il relativo goal da raggiungere
     pose                = rover_BlaNoce.getCurrentPose();

     while ~rover_BlaNoce.isGoalReached()                         % se ha raggiunto il goal, passa avanti
                        pos             = rover_BlaNoce.getCurrentPose();    % mi ricalcolo la posa attuale, per ciclarla
                        rover_BlaNoce   = rover_BlaNoce.nextStep();          % funzioni che fanno muovere il rover

                        forceVector = driver.AccVar();
                         while(stop<=20)
                            for stop=1:21
%                               forceVector = driver.AccVar();
                              driver.NoVel();
%                               disp('Stop!!');
                             driver.triggerNextStep(); 
%                                tempoIniziale       = timestamp;  
                            end% salvo il tempo iniziale nella variabile tempoIniziale
                                
                        end 
                          
                         tempoDelta      = l
                      driver.triggerNextStep();
                      

                        if(pos.x1<0)                                         % se cade nel vuoto
                        tempoDelta=999;
                        break
                    end

                    if(pos.phi1(1)>2.28 && pos.phi1(1)<4.02)
                        tempoDelta=0; %quando si cappotta, � -1 pure quando tocca il target troppo presto %* MODIFICATO
                        break;
                    end                        
		    
                    if(pos.phi1(1)>2.28 && pos.phi1(1)<4.02) && tempoDelta<15
                    tempoDelta=999; %quando si cappotta appena si poggia (problema lungo i pendii)
                    break;
                    end        
                     
                    if tempoDelta >= maximumTime
                        tempoDelta = 0;                           %se � fuori tempo MODIFICATO
                        disp('Timeout!You cant reach this point!');
                        break;
                    end
                    l=l+1;
                    j=j+1;
            end
            [tempi, presente] = salvaTempi(MapX, MapY, puntini(i, :), tempoDelta, direction(i), tempi); %salva i tempi
            if(presente == -1)
                i = i - 1;
            else
                tmpVector(i) = tempoDelta;
            end
                    
    
i=i+1;          % se esce dal ciclo, ha raggiunto l'obiettivo
    
%     for h = 1:1:size(tempi,1)
%         for j = 1:1:size(tempi,2)
%             if tempi(h,j) <= minimumTime
%                 tempi(h,j) = -1; %* se � troppo veloce a raggiungere l'obiettivo
%             end
%         end
%     end
    tempo=tempoDelta;
    driver.OriRover();
    driver.finishSimulation();                                            
 end                                           
 
   
%end