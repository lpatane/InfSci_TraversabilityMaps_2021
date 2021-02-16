function [matriceRug_new]= CalcoloMatRug(Traversabilita)

% Traversabilita = reshape(Traversabilita,(size(Traversabilita,1)*size(Traversabilita,2)),1);
dimx= 49;
dimy=68;
k=1;
    for i=1:size(Traversabilita,1)
        for j=1:size(Traversabilita,2)
           
            for m=1:4
                
                if (m == 1)
                   x = i;
                   y = j+1;
        
                    if(x == 0 ||y == 0 || x == dimx +1 || y == dimy +1 || x == dimy +1 ||  y == dimx+1)
                          disp('No');
                    else
                       matriceRug(k,1)=Traversabilita(x,y);

                    end 
                end

               if (m==2)
                   x = i+1;
                   y = j;
                if(x == 0 ||y == 0 || x == dimx +1 || y == dimy +1 || x == dimy +1 ||  y == dimx+1)
                     disp('No');
                else
                   matriceRug(k,2)=Traversabilita(x,y);
                end
               end
            
               if(m==3)
                   x = i;
                   y = j-1;
                   if(x == 0 ||y == 0 || x == dimx +1 || y == dimy +1 || x == dimy +1 ||  y == dimx+1)
                      disp('No');
                   else  
                    matriceRug(k,3)=Traversabilita(x,y);
                   end
               end
               
               if (m == 4)
                   x = i-1;
                   y = j;
                   if(x == 0 ||y == 0 || x == dimx +1 || y == dimy +1 || x == dimy +1 ||  y == dimx+1)
                      disp('No');
                   else  
                    matriceRug(k,4)=Traversabilita(x,y);
                   end
               end
            end
             k=k+1;
        end
    end
    
    a=(reshape(matriceRug(:, 1), [68, 49])');
prima=a(:);
b=(reshape(matriceRug(:, 2), [68, 49])');
seconda=b(:);
c=(reshape(matriceRug(:, 3), [68, 49])');
terza=c(:);
d=(reshape(matriceRug(:, 4), [68, 49])');
quarta=d(:);
matriceRug_new=[prima seconda terza quarta];
end
