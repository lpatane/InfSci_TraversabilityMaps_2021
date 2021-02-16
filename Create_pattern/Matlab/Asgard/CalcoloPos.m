% Codice creato per
% - calcolare nodi data una mappa di dimensioni dimxXdimy
% - inserire punti(x,y) nei corrispettivi nodi
% - calcolo punto(x,y), direzione e tempo secondo una certa condizione
% temporale (per es t > 5 secondi nel caso sottostante)

function [TempiCord]=CalcoloPos(Map,matriceTempi)
  
    dimx = size(Map,1)
    dimy = size(Map,2)
    
    k = 1;
    for i = 1:dimy
       for j = 1:dimx
           v(k,1) = i;
           v(k,2) = j;
           v(k,3)= (i-1)*49+j;
           k = k+1;
       end
    end 

    for i=1:size(matriceTempi,1)
        for j=1:4    
           matriceTempi(i,5)=v(i,1);
           matriceTempi(i,6) = v(i,2);
        end 
    end 
% 
%     for i=1:size(matriceTempi,1)
%         for j=1:4
%               if matriceTempi(i,j) == -1 || matriceTempi(i,j) == 999 || isnan(matriceTempi(i,j))
%                      matriceTempi(i,j)=0;
%               end 
%         end
%     end

	k=1;
    for i=1:size(matriceTempi,1)
        for j=1:4
         if matriceTempi(i,4) >11 && matriceTempi(i,4) < 12 
            if (matriceTempi(i,j)>0)
               TempiCord(k,1) = matriceTempi(i,5);
               TempiCord(k,2) = matriceTempi(i,6);
               TempiCord(k,3) = j;
               TempiCord(k,4) = matriceTempi(i,j);
               
               if (j==1)
                    TempiCord(k,5) = 0;
                    TempiCord(k,6) = TempiCord(k,1);
                    TempiCord(k,7) = TempiCord(k,2)+1;
                if(TempiCord(k,6) == 0 ||TempiCord(k,7) == 0 || TempiCord(k,6) == dimx +1 || TempiCord(k,7) == dimy +1 || TempiCord(k,6) == dimy +1 ||  TempiCord(k,7) == dimx+1)
                      TempiCord(k,:)=[];
                      k=k-1;
                 end
                    
               end
               if j == 2
                   TempiCord(k,5) = -pi/2;
                   TempiCord(k,6) = TempiCord(k,1)+1;
                   TempiCord(k,7) = TempiCord(k,2);
                   if(TempiCord(k,6) == 0 ||TempiCord(k,7) == 0 || TempiCord(k,6) == dimx +1 || TempiCord(k,7) == dimy +1 || TempiCord(k,6) == dimy +1 ||  TempiCord(k,7) == dimx+1)
                      TempiCord(k,:)=[];
                      k=k-1;
                   end
               end
               if j == 3
                   TempiCord(k,5) = pi;
                   TempiCord(k,6) = TempiCord(k,1);
                   TempiCord(k,7) = TempiCord(k,2)-1;
                   if(TempiCord(k,6) == 0 || TempiCord(k,7) == 0 || TempiCord(k,6) == dimx +1 || TempiCord(k,7) == dimy +1 || TempiCord(k,6) == dimy +1 ||  TempiCord(k,7) == dimx+1)
                      TempiCord(k,:)=[];
                      k = k-1;
                   end                       
               end
               if j == 4
                   TempiCord(k,5) = pi/2;
                   TempiCord(k,6) = TempiCord(k,1)-1;
                   TempiCord(k,7) = TempiCord(k,2);
                   if(TempiCord(k,6) == 0 ||TempiCord(k,7) == 0 || TempiCord(k,6) == dimx +1 || TempiCord(k,7) == dimy +1 || TempiCord(k,6) == dimy +1 ||  TempiCord(k,6) == dimx+1)
                      TempiCord(k,:)=[];
                      k=k-1;
                   end
               end
               k=k+1;
            end
         end
        end
    end 

%     ff=1;
%     for i = 1:size(TempiCord,1)
%         if (TempiCord(i,1)> 0 && TempiCord(i,1)< 1e-4)
%          SameHigh(ff,1) = TempiCord(i,1);
%          SameHigh(ff,2) =  TempiCord(i,5);
%         end
%     end
% 
%     for i=1:size(TempiCord,1)
%         figure(1);
%         surf(Map);
%         hold on;
%         plot3(TempiCord(i,1),TempiCord(i,2),515,'.r','markersize',30);
%     end

   
end