function [tempi, tmpVector, tmp1, tmp2, tmp3, tmp4, tmp45, tmp5, tmp55, tmp6, tmp7, tmp8, tmp9, tmp10, tmp11, tmp12, tmp13, tmp14] = calcolo_tempistiche(Map, dt,maximumTime,minimumTime,s, percent, graph,pendenze, Rugosita, pendenze_nuove, hmax)
    pioneerParameters;
   
    i= 1;
    l=0;
    a = 0;
    j=1;
    tmp2=0;
    stop=0;
    
    tmp1=NaN(3332,4);
    tmp2=NaN(3332,4);
    tmp3=NaN(3332,4);
    tmp4=NaN(3332,4);
    tmp45=NaN(3332,4);
    tmp5=NaN(3332,4);
    tmp55=NaN(3332,4);
    tmp6=NaN(3332,4);
    tmp7=NaN(3332,4);
    tmp8=NaN(3332,4);
    tmp9=NaN(3332,4);
    tmp10=NaN(3332,4);
    tmp11=NaN(3332,4);
    tmp12=NaN(3332,4);
    tmp13=NaN(3332,4);
    tmp14=NaN(3332,4);
    
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
    
%     alfa=radtodeg(alfaAngle)
%     beta=radtodeg(betaAngle)
%     gamma=radtodeg(gammaAngle)       
    alfa=(alfaAngle)
    beta=(betaAngle)
    gamma=(gammaAngle)   
    direzione=direction    
    coordinate_nodo_partenza=coordInit
    coordinate_nodo_arrivo=coordinate_nodo_arrivo
    
    nodo_partenza=nodo_partenza
    nodo_arrivo=nodo_arrivo   
    
    Pendenza_di_partenza=pendenze_nuove(nodo_partenza, direzione);
    Pendenza_di_arrivo=pendenze_nuove(nodo_arrivo, direzione);
    hmax_di_partenza=hmax(nodo_partenza);
    hmax_di_arrivo=hmax(nodo_arrivo);
    
    Rugosita_di_partenza=Rugosita(nodo_partenza)
    Rugosita_di_arrivo=Rugosita(nodo_arrivo)
    
    
    inizio=inizio;
    fine=fine;

    converter           = Converter(R,L);    							 % dichiaro il converter
    tracker             = Tracker(dt,converter,20); 					 % dichiaro il tracker
    
            current_target	= [fine(1), fine(2)]';                        % mi definisco il goal ad ogni punto
            planner         = LowLevelPlanner(tracker,dt);               % mi definisco i planner
            planner         = planner.setGoalPosition(current_target);   % assegno il goal da raggingere
            rover_BlaNoce   = Rover(planner,driver,robot,dt);            % mi definisco il rover con il relativo goal da raggiungere
            pose            = rover_BlaNoce.getCurrentPose();             % mi calcolo la posizione corrente
            l=0;
            while ~rover_BlaNoce.isGoalReached()                         % se ha raggiunto il goal, passa avanti
                   while(stop<=20)
                            for stop=1:21
                                driver.NoVel();
                                driver.triggerNextStep(); 
                            end% salvo il tempo iniziale nella variabile tempoIniziale                                
                   end
                   robot_kinematics
                    pos             = rover_BlaNoce.getCurrentPose();    % mi ricalcolo la posa attuale, per ciclarla
%                     driver.start();
%                     rover_BlaNoce   = rover_BlaNoce.nextStep();          % funzioni che fanno muovere il rover
%                     forceVector = driver.AccVar();
                        
                      
%                       landed = 1;
                      tempoDelta      = l
                      driver.triggerNextStep();

                    if(pos.x1<0)      % se cade nel vuoto
                        tempoDelta=999;
                        disp('E caduto nel vuoto!');
                        break
                    end

                    if(pos.phi1(1)>degtorad(100) || pos.phi1(1)<degtorad(-100)) && tempoDelta>=2
                        tempoDelta=0; %quando si cappotta
                        disp('Si è accappottato lungo il percorso!');

                        break;
                    end                        
		    
                    if(pos.phi1(1)>degtorad(100) || pos.phi1(1)<degtorad(-100)) && tempoDelta<2
                    tempoDelta=999; %quando si cappotta appena si poggia (problema lungo i pendii)
                    disp('Si è accappottato appena ha poggiato!');

                    break;
                    end        
                     
                    if tempoDelta >= maximumTime
                        tempoDelta = 0;                           %se è fuori tempo MODIFICATO
                        disp('Timeout!You cant reach this point!');
                        break;
                    end
                    l=l+1;
                    j=j+1;
            end
           
            [tempi, presente] = salvaTempi(MapX, MapY, coordInit, tempoDelta, direction, tempi); %salva i tempi
            if(presente == -1)
                i = i - 1;
            else
                tmpVector(i) = tempoDelta;
            end
%function [tempi, tmpVector, matriceRug_partenza, matriceRug_arrivo, alfaAngle, betaAngle, gammaAngle, nodo_partenza, nodo_arrivo, coordinate_nodo_partenza, coordinate_nodo_arrivo direzione] = calcolo_tempistiche(Map, dt,maximumTime,minimumTime,s, percent, graph,pendenze, Rugosita)

    tmp1(nodo_partenza, direzione)=alfaAngle;
    tmp2(nodo_partenza, direzione)=betaAngle;
    tmp3(nodo_partenza, direzione)=gammaAngle;
    
    tmp4(nodo_partenza, direzione)=coordinate_nodo_partenza(1);
    tmp45(nodo_partenza, direzione)=coordinate_nodo_partenza(2);

    tmp5(nodo_partenza, direzione)=coordinate_nodo_arrivo(1);
    tmp55(nodo_partenza, direzione)=coordinate_nodo_arrivo(2);

    tmp6(nodo_partenza, direzione)=direzione;
    
    tmp7(nodo_partenza, direzione)=nodo_partenza;
    tmp8(nodo_partenza, direzione)=nodo_arrivo;

    tmp9(nodo_partenza, direzione)=Rugosita(nodo_partenza);
    tmp10(nodo_partenza, direzione)=Rugosita(nodo_arrivo);  
    
    tmp11(nodo_partenza, direzione)=pendenze_nuove(nodo_partenza);
    tmp12(nodo_partenza, direzione)=pendenze_nuove(nodo_arrivo);
    tmp13(nodo_partenza, direzione)=hmax(nodo_partenza);
    tmp14(nodo_partenza, direzione)=hmax(nodo_arrivo);
        
    i=i+1;          % se esce dal ciclo, ha raggiunto l'obiettivo
    
%     for h = 1:1:size(tempi,1)
%         for j = 1:1:size(tempi,2)
%             if tempi(h,j) <= minimumTime
%                 tempi(h,j) = -1; %* se è troppo veloce a raggiungere l'obiettivo
%             end
%         end
%     end
    j=1;
    tempo=tempoDelta;
    driver.OriRover();
    driver.finishSimulation();                                            
 end
end