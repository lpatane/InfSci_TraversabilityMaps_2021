function [OptimalPath] = processPredMat(T);

[sizeTx, sizeTy]=size(T);
tot_cell=sizeTx*sizeTy;
tot_cell_otto_mappe=tot_cell*8;
%lato basso
for i=1:sizeTy 
    if i==1
        basso(1)=1;
    else
    basso(i)=basso(i-1)+sizeTx;
    end
end

%lato alto
for i=1:sizeTy
    if i==1
        alto(1)=sizeTx;
    else
    alto(i)=alto(i-1)+sizeTx;    
    end
end

%lato destro
a=1:tot_cell;
for i=1:sizeTx
    destra(i)=a(end+1-i);    
end

%lato sinistro
a=1:tot_cell;
for i=1:sizeTx
    sinistra(i)=a(i);    
end

A=[];
for i=1:1:tot_cell
    for j=1:8
        tmp(j)=i;
    end
    A=[A tmp];
end

b=1:tot_cell_otto_mappe; %tot_cell*8
B=[];
control=0;
for i=1:tot_cell
        %N
        for j=1:size(alto, 2)
            if b(i)==alto(j)
                control=1;
                break;
            else
                control=0;
            end
        end
        if control == 1
             tmp1(1)=b(i); 
        else            
            tmp1(1)=b(i+1); 

        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        %NE
        tmp1(2)=99999999999;
        for j=1:size(alto, 2)
            if b(i)==alto(j)
                tmp1(2)=b(i);
                break;
            end
        end
        
        for j=1:size(destra, 2)
            if b(i)==destra(j)
                tmp1(2)=b(i); 
                break;
            end
        end
        
        if tmp1(2)==99999999999
            tmp1(2)=b(i+sizeTx+1);  
        end   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %E
        for j=1:size(destra, 2)
            if b(i)==destra(j)
                control=1;
                break;
            else
                control=0;
            end
        end
        
        if control == 1
             tmp1(3)=b(i);
        else
            tmp1(3)=b(i+sizeTx);  
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              
        %SE    
        tmp1(4)=99999999999;
        for j=1:size(basso, 2)
            if b(i)==basso(j)
               tmp1(4)=b(i);
               break;           
            end
        end
        
        for j=1:size(destra, 2)
            if b(i)==destra(j)
               tmp1(4)=b(i);                                         
            end
        end
        
        if tmp1(4)==99999999999
            tmp1(4)=b(i+sizeTx-1);
        end
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %S
        for j=1:size(basso, 2)
            if b(i)==basso(j)
                control=1;
                break;
            else
                control=0;
            end
        end
        if control == 1
             tmp1(5)=b(i); 
        else            
            tmp1(5)=b(i-1); 
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %SO
        tmp1(6)=99999999999;
        for j=1:size(basso, 2)
            if b(i)==basso(j)
                 tmp1(6)=b(i);
                 break;            
            end
        end
        
        for j=1:size(sinistra, 2)
            if b(i)==sinistra(j)
                tmp1(6)=b(i);
                break;
            end
        end
        if tmp1(6)==99999999999
            tmp1(6)=b(i-sizeTx-1);
        end
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %O
        for j=1:size(sinistra, 2)
            if b(i)==sinistra(j)
                control=1;
                break;
            else
                control=0;
            end
        end
        
        if control == 1
             tmp1(7)=b(i);
        else
            tmp1(7)=b(i-sizeTx);  
        end
        %%%%%%%%%%%%%%%%%%%%%%%%
        
        %NO
        tmp1(8)=99999999999;
        for j=1:size(alto, 2)
            if b(i)==alto(j)
                tmp1(8)=b(i);
                break;
            end
        end
        
        for j=1:size(sinistra, 2)
            if b(i)==sinistra(j)
                 tmp1(8)=b(i);
                 break;
            end
        end  
        
        if tmp1(8)==99999999999
            tmp1(8)=b(i-sizeTx+1);  
        end
        
        B=[B tmp1];

end
k=1;
% 
% coord=[sizeTx*5+5, sizeTx*86+69;...
%     sizeTx*5+5, sizeTx*86+75;...
%     sizeTx*59+9, sizeTx*26+69;...
%     sizeTx*30+26, sizeTx*58+90;...
%     sizeTx*7+59, sizeTx*63+80;...
%     sizeTx*83+32, sizeTx*48+14;...
%     sizeTx*75+63, sizeTx*27+42;...
%     sizeTx*16+26, sizeTx*52+86;...
%     sizeTx*70+6, sizeTx*29+63;...
%     sizeTx*46+83, sizeTx*72+52;...
%     ];
% figure;
% surf(T);
hold on
%     coord(1, 1)=randi([1 101],1,1);
%     coord(1, 2)=randi([1 101],1,1);

      load (['.\long\nord']) %queste sono le mappe uscenti da trasfomrazione.m
      load (['.\long\sud'])
      load (['.\long\est'])
      load (['.\long\ovest'])
      load (['.\long\nord_est'])
      load (['.\long\nord_ovest'])
      load (['.\long\sud_est'])
      load (['.\long\sud_ovest'])

%       load (['C:\Users\Salvo\Desktop\Dottorato\2 articolo\vecchi\Matlab e Vrep\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_Asg_lungo\nord_sogliata']) %queste sono le vecchie mappe sogliate
%       load (['C:\Users\Salvo\Desktop\Dottorato\2 articolo\vecchi\Matlab e Vrep\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_Asg_lungo\sud_sogliata'])
%       load (['C:\Users\Salvo\Desktop\Dottorato\2 articolo\vecchi\Matlab e Vrep\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_Asg_lungo\est_sogliata'])
%       load (['C:\Users\Salvo\Desktop\Dottorato\2 articolo\vecchi\Matlab e Vrep\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_Asg_lungo\ovest_sogliata'])
%       load (['C:\Users\Salvo\Desktop\Dottorato\2 articolo\vecchi\Matlab e Vrep\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_Asg_lungo\nord_est_sogliata'])
%       load (['C:\Users\Salvo\Desktop\Dottorato\2 articolo\vecchi\Matlab e Vrep\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_Asg_lungo\nord_ovest_sogliata'])
%       load (['C:\Users\Salvo\Desktop\Dottorato\2 articolo\vecchi\Matlab e Vrep\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_Asg_lungo\sud_est_sogliata'])
%       load (['C:\Users\Salvo\Desktop\Dottorato\2 articolo\vecchi\Matlab e Vrep\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_Asg_lungo\sud_ovest_sogliata'])
%      for xx= 1:9
%       load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\Mappe_sogliate_Asguard\mappe_asguard_soglia0' num2str(xx) '\nord'])
%       load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\Mappe_sogliate_Asguard\mappe_asguard_soglia0' num2str(xx) '\sud'])
%       load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\Mappe_sogliate_Asguard\mappe_asguard_soglia0' num2str(xx) '\est'])
%       load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\Mappe_sogliate_Asguard\mappe_asguard_soglia0' num2str(xx) '\ovest'])
%       load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\Mappe_sogliate_Asguard\mappe_asguard_soglia0' num2str(xx) '\nord_est'])
%       load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\Mappe_sogliate_Asguard\mappe_asguard_soglia0' num2str(xx) '\nord_ovest'])
%       load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\Mappe_sogliate_Asguard\mappe_asguard_soglia0' num2str(xx) '\sud_est'])
%       load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\Mappe_sogliate_Asguard\mappe_asguard_soglia0' num2str(xx) '\sud_ovest'])
%       
     
    clear tmp
    tmp=1;
    w=[];
    for i=1:1:tot_cell
        for j=1:8
            if j==1
                tmp(j)=nord(i);
            end
            if j==2
                tmp(j)=nord_est(i);
            end
            if j==3
                tmp(j)=est(i);
            end
            if j==4
                tmp(j)=sud_est(i);
            end
            if j==5
                tmp(j)=sud(i);
            end
            if j==6
                tmp(j)=sud_ovest(i);% problema
            end
            if j==7
                tmp(j)=ovest(i);    % problema
            end
            if j==8
                tmp(j)=nord_ovest(i); % problema
            end

        end
        w=[w tmp];
    end

    G = digraph(A, B, w); %This is the graph whose weight are set using the traversability maps previously otbained.
    [OptimalPath,d,edgepath] = shortestpath(G, sizeTx*46+54, sizeTy*20+35, 'Method', 'auto');
     %if xx==5         
     save('OptimalPath', 'OptimalPath');
    %end
 xx=5;
    OptimalPath_tot{xx}=OptimalPath;
    d_tot{xx}=d/size(OptimalPath, 2);

%     Path(k, :)=OptimalPath(1:113);
%     Peso(k)=d/size(OptimalPath, 2);

    k=k+1;
visualizePath
   % end
% Path_totali(y, :)=[Path];
% Pesi_totali(y, :)=[Peso];
k=1;

% for i=1:10
%     plot(Pesi_totali(i, :), Path_totali(i, :));
%     xlabel('Pesi');
%     ylabel('Path');
%     hold on
% end
% for i=1:10
%     plot(Path_totali(i, :));
%     xlabel('Pesi');
%     ylabel('Path');
%     hold on
% end

% for i=1:9    
%    num(i)=(size([OptimalPath_tot{1,i}], 2));    
% end
%    
%     figure; plot(num);
%     xlabel('Threshold');
%     ylabel('Path lenght');
%     
% for i=1:9
%     
%    num2(i)=(([d_tot{1,i}]));
% 
%     
% end
% 
%     figure; plot(num2);
%     xlabel('Threshold');
%     ylabel('Medium weight');


end
