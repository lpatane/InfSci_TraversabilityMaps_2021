function [MatriceDati] = calcolaInputRete(matriceAltezze, matriceTempi, matriceRug_partenza, matriceRug_arrivo, AvgMap, alfaAngle, betaAngle, gammaAngle, nodo_partenza, nodo_arrivo, coordinate_nodo_partenza1, coordinate_nodo_partenza2, coordinate_nodo_arrivo1, coordinate_nodo_arrivo2, direzione, pendenza_partenza, pendenza_arrivo, hmax_partenza, hmax_arrivo)

    Altezze     = reshape(matriceAltezze,(size(matriceAltezze,1)*size(matriceAltezze,2)),1);
    matriceRug_partenza       = reshape(matriceRug_partenza, (size(matriceRug_partenza,1)*size(matriceRug_partenza,2)),1); 
    matriceRug_arrivo       = reshape(matriceRug_arrivo, (size(matriceRug_arrivo,1)*size(matriceRug_arrivo,2)),1); 
    alfaAngle       = reshape(alfaAngle, (size(alfaAngle,1)*size(alfaAngle,2)),1); 
    betaAngle       = reshape(betaAngle, (size(betaAngle,1)*size(betaAngle,2)),1); 
    gammaAngle       = reshape(gammaAngle, (size(gammaAngle,1)*size(gammaAngle,2)),1); 
    nodo_partenza       = reshape(nodo_partenza, (size(nodo_partenza,1)*size(nodo_partenza,2)),1); 
    nodo_arrivo       = reshape(nodo_arrivo, (size(nodo_arrivo,1)*size(nodo_arrivo,2)),1); 
    coordinate_nodo_partenza1       = reshape(coordinate_nodo_partenza1, (size(coordinate_nodo_partenza1,1)*size(coordinate_nodo_partenza1,2)),1); 
    coordinate_nodo_partenza2       = reshape(coordinate_nodo_partenza2, (size(coordinate_nodo_partenza2,1)*size(coordinate_nodo_partenza2,2)),1); 
    coordinate_nodo_arrivo1       = reshape(coordinate_nodo_arrivo1, (size(coordinate_nodo_arrivo1,1)*size(coordinate_nodo_arrivo1,2)),1); 
    coordinate_nodo_arrivo2       = reshape(coordinate_nodo_arrivo2, (size(coordinate_nodo_arrivo2,1)*size(coordinate_nodo_arrivo2,2)),1); 
    direzione       = reshape(direzione, (size(direzione,1)*size(direzione,2)),1); 
    pendenza_partenza       = reshape(pendenza_partenza, (size(pendenza_partenza,1)*size(pendenza_partenza,2)),1); 
    pendenza_arrivo       = reshape(pendenza_arrivo, (size(pendenza_arrivo,1)*size(pendenza_arrivo,2)),1); 
    hmax_partenza       = reshape(hmax_partenza, (size(hmax_partenza,1)*size(hmax_partenza,2)),1); 
    hmax_arrivo       = reshape(hmax_arrivo, (size(hmax_arrivo,1)*size(hmax_arrivo,2)),1); 
    Tempi       = reshape(matriceTempi, (size(matriceTempi,1)*size(matriceTempi,2)),1); 

    MatriceDati = [Altezze Tempi];
    delete=0;    
    k=0;
    tmp = MatriceDati;

    %da qui a qui* sono quelli che non sono stati visionati e di cui, quindi, non si
%hanno info sulle tempistiche
    for i = 1:1:size(MatriceDati,1)
       if ((isnan(MatriceDati(i,1))) && (isnan(MatriceDati(i,2)))) || ((~isnan(MatriceDati(i,1))) && (isnan(MatriceDati(i,2))))
            tmp(i-k,:)=[];
            k = k+1;
            delete(i)=i;
                delete(delete==0) = [];    
        else 
            tmp(i-k,:) = MatriceDati(i,:);
        end
    end
    
    if delete~0 
       
        pendenza_partenza(delete)=[];
        pendenza_arrivo(delete)=[];
        hmax_partenza(delete)=[];
        hmax_arrivo(delete)=[];

        matriceRug_partenza(delete)=[];
        matriceRug_arrivo(delete)=[];
        alfaAngle(delete)=[];
        betaAngle(delete)=[];
        gammaAngle(delete)=[];
        nodo_partenza(delete)=[];
        nodo_arrivo(delete)=[];
        coordinate_nodo_partenza1(delete, :)=[];
        coordinate_nodo_partenza2(delete, :)=[];
        coordinate_nodo_arrivo1(delete, :)=[];
        coordinate_nodo_arrivo2(delete, :)=[];
        direzione(delete)=[];
%         indice_di_slip(delete)=[];
%         mome

    MatriceDati = tmp;
    clear tmp;
%qui*
   delete=0;
    k=0;
    tmp = MatriceDati;
    
    for i = 1:1:size(MatriceDati,1)
           if (isnan(MatriceDati(i,1))) && (~isnan(MatriceDati(i,2)))
                tmp(i-k,:)=[];
                delete(i)=i;
                delete(delete==0) = [];    
                k = k+1;                
            else 
                tmp(i-k,:) = MatriceDati(i,:);
           end
    end
     if delete~0 
       
        pendenza_partenza(delete)=[];
        pendenza_arrivo(delete)=[];
        hmax_partenza(delete)=[];
        hmax_arrivo(delete)=[];

        matriceRug_partenza(delete)=[];
        matriceRug_arrivo(delete)=[];
        alfaAngle(delete)=[];
        betaAngle(delete)=[];
        gammaAngle(delete)=[];
        nodo_partenza(delete)=[];
        nodo_arrivo(delete)=[];
        coordinate_nodo_partenza1(delete, :)=[];
        coordinate_nodo_partenza2(delete, :)=[];
        coordinate_nodo_arrivo1(delete, :)=[];
        coordinate_nodo_arrivo2(delete, :)=[];
        direzione(delete)=[];
%         indice_di_slip(delete)=[];
%         momentiblocco(delete)=[];
     end
    
    MatriceDati = tmp;
    
     clear tmp;
%      clear delete;
       delete=0;
    k = 0;
    tmp=MatriceDati;
    
    for i = 1:1:size(MatriceDati,1)

       if (MatriceDati(i,2) == 999) || (MatriceDati(i,2) == -1 )                      
            tmp(i-k,:)=[];
            delete(i)=i;
            delete(delete==0) = [];      
            k = k+1;            
        else 
            tmp(i-k,:) = MatriceDati(i,:);                   
        end
    end
   if delete~0
        pendenza_partenza(delete)=[];
        pendenza_arrivo(delete)=[];
        hmax_partenza(delete)=[];
        hmax_arrivo(delete)=[];

        matriceRug_partenza(delete)=[];
        matriceRug_arrivo(delete)=[];
        alfaAngle(delete)=[];
        betaAngle(delete)=[];
        gammaAngle(delete)=[];
        nodo_partenza(delete)=[];
        nodo_arrivo(delete)=[];
        coordinate_nodo_partenza1(delete, :)=[];
        coordinate_nodo_partenza2(delete, :)=[];
        coordinate_nodo_arrivo1(delete, :)=[];
        coordinate_nodo_arrivo2(delete, :)=[];
        direzione(delete)=[];
%         indice_di_slip(delete)=[];
%         momentiblocco(delete)=[];
   end
    
    pendenza_partenza=double(pendenza_partenza)';
    pendenza_arrivo=double(pendenza_arrivo)';
    hmax_partenza=double(hmax_partenza)';
    hmax_arrivo=double(hmax_arrivo)';
        
    MatriceDati = double(tmp);   
    matriceRug_partenza = double(matriceRug_partenza)';
    matriceRug_arrivo = double(matriceRug_arrivo)';
    alfaAngle=double(alfaAngle)';
    betaAngle=double(betaAngle)';
    gammaAngle=double(gammaAngle)';
    nodo_partenza=double(nodo_partenza)';
    nodo_arrivo=double(nodo_arrivo)';
    coordinate_nodo_partenza1=double(coordinate_nodo_partenza1);
    coordinate_nodo_arrivo1=double(coordinate_nodo_arrivo1);
    coordinate_nodo_partenza2=double(coordinate_nodo_partenza2);
    coordinate_nodo_arrivo2=double(coordinate_nodo_arrivo2);
    direzione=double(direzione)';
%     indice_di_slip=double(indice_di_slip);
%     momentiblocco=double(momentiblocco);
    clear tmp;
    zerieuni=0;
    for i=1:size(MatriceDati(:, 2), 1)        
        if MatriceDati(i, 2)>0 
            zerieuni(i)=1;
        else
            zerieuni(i)=0;
        end
    end
   
    MatriceDati = [zerieuni' MatriceDati(:, 2) MatriceDati(:, 1) pendenza_partenza' pendenza_arrivo' ...
        hmax_partenza' hmax_arrivo' matriceRug_partenza' matriceRug_arrivo' ...
        alfaAngle'  betaAngle'  gammaAngle'  nodo_partenza'  nodo_arrivo'  ...
        coordinate_nodo_partenza1 coordinate_nodo_partenza2 coordinate_nodo_arrivo1 coordinate_nodo_arrivo2 direzione'];

end