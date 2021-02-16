% clear all
% clc
% close all

l=0;
f=1;
g=1; %serve in shortest_path
raggiunto=0;
control=0;
non_raggiunto=0;
coordinate_non_raggiunti=0;
SimulationParameters;
pioneerParameters;

[T,indicerug,T_taglia]   = AvgMap(T_intera,n_downsaple,clearence);
% surf(T)
% 
h_max           = max(max(T)); %h_max = max(max(T_taglia)); CAMBIATOOO!!

scaleX          = dimXVrep/ size(T,1);
scaleY          = dimYVrep/ size(T,2);
scaleZ          = (dimZVrep)/h_max;
MapX            =  size(T,1);
MapY            =  size(T,2);
tempi           = NaN(MapX*MapY,4);
%for j=1:100
    shortest_path
    load('OptimalPath'); %quello che viene salvato da "visualizePath.m
    for l=1:size(fin, 1)
        alfaAngle(l, :)=0;
        betaAngle(l, :)=0;
        gammaAngle(l, :)=0;
    end
    l=0;
    for i=1:1:size(fin, 1)
        l=0;
        control=0;
        i
        puntini=fin;
        puntifin=fin;
         driver      		= SimulationDriver();
                 
          zInit               = T(puntini(i, 2), puntini(i, 1));
          zFin                = T(puntifin(i, 2),  puntifin(i, 1));
          maxZ                = max(zFin, zInit);
          nodo                = (puntini(i,1)-1)*49+puntini(i,2);


          inizio = [puntini(i, 2)*scaleY, -puntini(i, 1)*scaleX, maxZ*scaleZ+0.17];
          fine   = [puntifin(i, 2)*scaleY,  -puntifin(i, 1)*scaleX, maxZ*scaleZ];

          driver.PosCuboid(inizio, fine, alfaAngle(i,:), betaAngle(i,:), gammaAngle(i,:)); 
          
          if i==1
            driver.PosRover(inizio, alfaAngle(i,:), betaAngle(i,:), gammaAngle(i,:)); 
          end
          
         converter           = Converter(R,L);    							 % dichiaro il converter
         tracker             = Tracker(dt,converter,20); 
         current_target      = [fine(1),fine(2)]';                   % mi definisco il goal ad ogni punto
         planner             = LowLevelPlanner(tracker,dt);               % mi definisco i planner
         planner             = planner.setGoalPosition(current_target);   % assegno il goal da raggingere
         rover_BlaNoce       = Rover(planner,driver,robot,dt);            % mi definisco il rover con il relativo goal da raggiungere
         pose                = rover_BlaNoce.getCurrentPose();

         while ~rover_BlaNoce.isGoalReached()                         % se ha raggiunto il goal, passa avanti
             
             pose = rover_BlaNoce.getCurrentPose();    % mi ricalcolo la posa attuale, per ciclarla
             rover_BlaNoce = rover_BlaNoce.nextStep();          % funzioni che fanno muovere il rover
             driver.triggerNextStep();                                                                 
             l=l+1;
             control=0;
%             raggiunto
%             non_raggiunto
%              if l>=1000
%                  non_raggiunto=non_raggiunto+1; %se il tempo (indice) supera il limite allora considero il percorso NON raggiunto
%                  coordinate_non_raggiunti(f, 1:2)=[punti_di_partenza(g-1)' punti_di_arrivo(g-1)'];
%                  control=1;
%                  f=f+1;
%                  break;
%              end
         end
        %driver.OriRover();
        %driver.finishSimulation();  
        if control == 1
            break;
        end
    end    
        if control==0
            raggiunto=raggiunto+1;
        end
        driver.OriRover();
        driver.finishSimulation();                                            

%end    

% save('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\test_robot\punti_di_partenza', 'punti_di_partenza');
% save('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\test_robot\punti_di_arrivo', 'punti_di_arrivo');
% save('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\test_robot\raggiunto', 'raggiunto');
% save('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\test_robot\non_raggiunto', 'non_raggiunto');
% a=[raggiunto; non_raggiunto];
% figure; pie(a);


