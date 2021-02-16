function [tempi, tmpVector, matriceRug_partenza, matriceRug_arrivo, indice_di_slip, momenti_blocco] = calcolo_tempistiche(Map, dt,maximumTime,minimumTime,s, percent, graph,pendenze, Traversabilita)
    pioneerParameters;
    
    i= 1;
    l=0;
    a = 0;
    j=1;
    tmp2=0;
    stop=0;
       N_iterazioni        = calcolaIterazioni(Map, percent);
    %N_iterazioni        = 20;
    MapX 				= size(Map,1);
    MapY 				= size(Map,2);
    tempi 				= NaN(MapX*MapY,4);
  while i<=N_iterazioni	 % scorro il vettore dei punti per cambiare goal ogni volta che il goal è raggiunto.
    i   
    stop=0;
    driver      		= SimulationDriver(); 
    [inizio, fine, direction, gammaAngle,coordInit] = coordinates(Map, s);

    nodo_partenza = (coordInit(1)-1)*49+coordInit(2); %nodo di partenza
                                                           
    nodo=nodo_partenza;
    if direction == 1
        betaAngle=-pendenze(nodo,direction);
        alfaAngle=pendenze(nodo,direction+1);
        nodo_arrivo=(coordInit(1)-1)*49+coordInit(2)+1;
        coordinate_nodo_arrivo=[coordInit(1) coordInit(2)+1];
    end

    if direction == 2
        alfaAngle=pendenze(nodo,direction);
        betaAngle=pendenze(nodo,direction+1);
        nodo_arrivo=((coordInit(1)-1)*49)+49+coordInit(2); %una colonna dopo da rivedere
        coordinate_nodo_arrivo=[coordInit(1)+1 coordInit(2)];

    end
    
    if direction == 3
        alfaAngle=-pendenze(nodo,direction+1);
        betaAngle=pendenze(nodo,direction); 
        nodo_arrivo=(coordInit(1)-1)*49+coordInit(2)-1;
        coordinate_nodo_arrivo=[coordInit(1) coordInit(2)-1];        
    end

    if direction == 4
        alfaAngle=-pendenze(nodo,direction);
        betaAngle=-pendenze(nodo,1);
        nodo_arrivo=((coordInit(1)-1)*49)-49+coordInit(2); %una colonna prima da rivedere
        coordinate_nodo_arrivo=[coordInit(1)-1 coordInit(2)];                
    end
    
    if isnan(betaAngle)
        betaAngle = 0;
    end 

    if isnan(alfaAngle)
        alfaAngle = 0;
    end 

    driver.PosRoverECuboi(inizio, fine, alfaAngle, betaAngle, gammaAngle); 
    %alfa ruota intorno alla y del robot. 
    %beta intorno alla x
    
    alfa=radtodeg(alfaAngle);
    beta=radtodeg(betaAngle);
    gamma=radtodeg(gammaAngle);
    nodo_partenza=nodo_partenza
    nodo_arrivo=nodo_arrivo    
    direzione=direction
    coordinate_nodo_partenza=coordInit
    coordinate_nodo_arrivo=coordinate_nodo_arrivo
    Rugosita_di_partenza=Traversabilita(nodo_partenza)
    Rugosita_di_arrivo=Traversabilita(nodo_arrivo)
    inizio=inizio;
    fine=fine;

    converter           = Converter(R,L);    							 % dichiaro il converter
    tracker             = Tracker(dt,converter,20); 					 % dichiaro il tracker
    
            current_target	= [fine(1), fine(2)]';                        % mi definisco il goal ad ogni punto
            planner         = LowLevelPlanner(tracker,dt);               % mi definisco i planner
            planner         = planner.setGoalPosition(current_target);   % assegno il goal da raggingere
            rover_BlaNoce   = Rover(planner,driver,robot,dt);            % mi definisco il rover con il relativo goal da raggiungere
            pose            = rover_BlaNoce.getCurrentPose();             % mi calcolo la posizione corrente

            while ~rover_BlaNoce.isGoalReached()                         % se ha raggiunto il goal, passa avanti
                    tmp(j, 1)=driver.AngeLinVel_indice_di_slip;

                     velocitalineare_robot=driver.AngeLinVel_velocitalineare_robot;
                    [coppia_motore]=driver.CoppiaMotore();

%                     if (coppia_motore >= 10) &&  (velocitalineare_robot <= 0.1)
                    if (velocitalineare_robot <= 0.01) && (coppia_motore >= 1)
                        tmp2=tmp2+1;
                    end  
                      
                    
                    pos             = rover_BlaNoce.getCurrentPose();    % mi ricalcolo la posa attuale, per ciclarla
 
                    rover_BlaNoce   = rover_BlaNoce.nextStep();    
                       while(stop<=50)
                            for stop=1:51
                              driver.NoVel();
                             driver.triggerNextStep(); 
                              tempoIniziale       = timestamp;                                 % salvo il tempo iniziale nella variabile tempoIniziale
                                
                            end 
                       end
                      tempoAttuale    = timestamp;                      
                      tempoDelta      = tempoAttuale-tempoIniziale;
                      driver.triggerNextStep();
                    if(pos.x1<0)                                         % se cade dal terreno
                        tempoDelta=999;
                        break
                    end

                    if(pos.phi1(1)>2.28 && pos.phi1(1)<4.02)
                        tempoDelta=999; %non dovrebbe essere -1?
                        break;
                    end
%                         
                    if tempoDelta < 0 
                        tempoDelta  = tempoDelta+60;
                    end 
%                     
                    if tempoDelta >= maximumTime
                        tempoDelta = 999;
                        disp('Timeout!You cant reach this point!');
                        break;
                    end
            j=j+1;
            end
           
            [tempi, presente] = salvaTempi(MapX, MapY, coordInit, tempoDelta, direction, tempi); %salva i tempi
            if(presente == -1)
                i = i - 1;
            else
                tmpVector(i) = tempoDelta;
            end

    matriceRug_partenza(i, 1)=Traversabilita(nodo_partenza);
    matriceRug_arrivo(i, 1)=Traversabilita(nodo_arrivo);  
    indice_di_slip(i,1)=mean(tmp(5:end, 1)); 
    tmp(:, :)=[];    
    
    if tmp2~0
        momenti_blocco(i, 1)= tmp2;
        tmp2(:, :)=0;
    else
        momenti_blocco(i, 1)= 0;
    end
    tempoDelta
    i=i+1;          % se esce dal ciclo, ha raggiunto l'obiettivo
    
    for h = 1:1:size(tempi,1)
        for j = 1:1:size(tempi,2)
            if tempi(h,j) <= minimumTime
                tempi(h,j) = -1;
            end
        end
    end
    j=1;
    tempo=tempoDelta;
    driver.OriRover();
    driver.finishSimulation();                                            
 end
end