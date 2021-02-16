% clc
% clear all
% close all

SimulationParameters;
pioneerParameters;
clearance = 15;
% load('Tempi_1_2.mat');

% [T_intera,P]      = geotiffread('polo_pad.tif');
T_taglia        = (T_intera(21:360,29:273));
[T,indicerug]= AvgMap(T_intera,n_downsaple,clearence);
% matriceAltezze      = altezze(size(T,1),size(T,2),T);
% matricePendenze     = CalcolaPendenze(matriceAltezze, P.CellExtentInWorldX);    
dimXVrep 		= 29.4;
dimYVrep 		= 40.84;
dimZVrep 		= 5.5;
h_max           = max(max(T_taglia));
% distogoal       = 0.05;
scaleX          = dimXVrep/ size(T,1);
scaleY          = dimYVrep/ size(T,2);
scaleZ          = (dimZVrep)/h_max;
MapX            =  size(T,1);
MapY            =  size(T,2);
tempi           = NaN(MapX*MapY,4);
i               = 1;

R = 0.1168;
L = 0.468;

 
 while i<size(TempiCord,1)
     driver      		= SimulationDriver();
     landed = 0;
     i
     cond = 0;
     inizio = [TempiCord(i,1),TempiCord(i,2)];
     fine   = [TempiCord(i,6),TempiCord(i,7)];
     
     gammaAngle = TempiCord(i,5);
 
     zInit               = T(inizio(2), inizio(1));
     zFin                = T(fine(2),  fine(1));
     maxZ                = max(zFin, zInit);
%      nodo                = (TempiCord(i,1)-1)*49+TempiCord(i,2);
     betaAngle           = TempiCord(i,9);
     
     
     inizio = [TempiCord(i,2)*scaleY -TempiCord(i,1)*scaleX maxZ*scaleZ+1]
     fine   = [TempiCord(i,7)*scaleY  -TempiCord(i,6)*scaleX 1.5]

     driver.PosRoverECuboi(inizio,fine,betaAngle,gammaAngle);

    figure(1);
    surf(T);
    hold on;
    plot3(TempiCord(i,1),TempiCord(i,2),515,'.r','markersize',10);
    hold on;
     plot3(TempiCord(i,6),TempiCord(i,7),515,'.g','markersize',10);

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
                          while(forceVector > -11 && landed == 0)
                                 forceVector = driver.AccVar();
                                 driver.NoVel();
                                 disp('Stop!!');
                                 driver.triggerNextStep(); 
                                 tempoIniziale       = timestamp;                                 % salvo il tempo iniziale nella variabile tempoIniziale
                          end 
                          
                         tempoAttuale    = timestamp;      
                         landed = 1;
                         tempoDelta      = tempoAttuale - tempoIniziale;
                         driver.triggerNextStep();

                       if(pos.x1<0)                                         % se cade dal terreno
                             tempoDelta=999;
                             break
                       end

                        if(pos.phi1(1)>2.28 && pos.phi1(1)<4.02)
                            tempoDelta=999;
                            break;
                        end
                        
                        if tempoDelta < 0 
                            tempoDelta  = tempoDelta+60;
                        end 
                    
                        if tempoDelta >= maximumTime
                            tempoDelta = 999;
                            disp('Timeout!You cant reach this point!');
                            break;
                        end 
     end
     
            inizio = [TempiCord(i,1) TempiCord(i,2)];
            [tempi, presente] = salvaTempi(MapX, MapY, inizio, tempoDelta, TempiCord(i,3), tempi); %salva i tempi
            if(presente == -1)
                i = i - 1;
            else
                tmpVector(i) = tempoDelta;
            end
                    
    
    i=i+1;          % se esce dal ciclo, ha raggiunto l'obiettivo
    
    for h = 1:1:size(tempi,1)
        for j = 1:1:size(tempi,2)
            if tempi(h,j) <= minimumTime
                tempi(h,j) = -1;
            end
        end
    end
                       
 
    driver.OriRover();
    driver.finishSimulation();  
 end
 