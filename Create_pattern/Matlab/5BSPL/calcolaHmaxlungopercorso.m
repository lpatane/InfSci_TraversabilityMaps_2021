function [hmax]=calcolaHmaxlungopercorso(T_taglia)
    
    [sizeTx, sizeTy] = size(T_taglia);

    %passo da vertici a caselle
    for i=1:sizeTx-1 		%riga
        for j=1:sizeTy-1 	%colonna
             media(i, j)	= (T_taglia(i, j)+T_taglia(1+i, j)+T_taglia(i, 1+j)+T_taglia(1+i, 1+j))/4;
        end
    end
        media(i+1, j) = media(i, j);
        media(i, j+1) = media(i, j);
        
        k=1;
        for i=6:5:sizeTx+4
            for j=6:5:sizeTy+4
                tmp0=media(i-5:i-1, j-5:j-1);
                tmp1=max(tmp0);
                tmp2=max(tmp1);
%                 [tmp3,tmp4]=find(tmp0==tmp2);
                hmax(k)=tmp2;
%                 row=tmp3(1, 1);
%                 col=tmp4(1, 1);
                k=k+1;
            end
        end
        hmax=hmax';
end