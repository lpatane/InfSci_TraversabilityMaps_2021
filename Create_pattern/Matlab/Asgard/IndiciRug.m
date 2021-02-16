function [Rug,indicerug] = IndiciRug(Map,matriceTempi,indicerug)   

TempiCord = CalcoloPos(Map,matriceTempi);

indicerug = reshape(indicerug,49*68,1);

k = 1;
   for i=1:size(TempiCord,1)
       Rug(k,1) = TempiCord(i,1);
       Rug(k,2) = TempiCord(i,2);
       n1(i)= (TempiCord(i,1)-1)*49+ TempiCord(i,2);
       Rug(k,3) = indicerug(n1(i));
       Rug(k,4) = TempiCord(i,6);
       Rug(k,5) = TempiCord(i,7);
       n2(i) = (TempiCord(i,6)-1)*49+ TempiCord(i,7);
       Rug(k,6) = indicerug(n2(i));
       k = k+1;
   end
   
end
   
   
    
    