    k = 1;
   for i=1:size(TempiCord,1)
       Rug(k,1) = TempiCord(i,1);
       Rug(k,2) = TempiCord(i,2);
       n1(i)= (TempiCord(i,1)-1)*49+ TempiCord(i,2);
       Rug(k,3) = matriceRugosita(n1(i));
       Rug(k,4) = TempiCord(i,6);
       Rug(k,5) = TempiCord(i,7);
       n2(i) = (TempiCord(i,6)-1)*49+ TempiCord(i,7);
       Rug(k,6) = matriceRugosita(n2(i));
       k = k+1;
   end 
   
ff=1;
    for i = 1:size(TempiCord,1)
        if (TempiCord(i,1)> 0 && TempiCord(i,1)< 1e-4)
         SameHigh(ff,1) = TempiCord(i,1);
         SameHigh(ff,2) =  TempiCord(i,5);
        end
    end
   
    
    