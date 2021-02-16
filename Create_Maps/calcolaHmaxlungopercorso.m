function [hmax]=calcolaHmaxlungopercorso(T_taglia, n_downsaple)
    
    [sizeTx, sizeTy] = size(T_taglia);

    %passo da vertici a caselle
    for i=1:sizeTx-1 		%riga
        for j=1:sizeTy-1 	%colonna
             media(i, j)	= (T_taglia(i, j)+T_taglia(1+i, j)+T_taglia(i, 1+j)+T_taglia(1+i, 1+j))/4;
        end
    end
        media(i+1, j) = media(i, j);
        media(i, j+1) = media(i, j);
%         media(:, 514:515)=0;
%         media(514:515, :)=0;

        k=1;
        for i=n_downsaple+1:n_downsaple:sizeTx+4
            for j=n_downsaple+1:n_downsaple:sizeTy+4
                tmp0=media(i-n_downsaple:i-1, j-n_downsaple:j-1);
%                 tmp1=max(tmp0);
%                 tmp2=max(tmp1);
% %                 [tmp3,tmp4]=find(tmp0==tmp2);
%                 hmax(k)=tmp2;
% %                 row=tmp3(1, 1);
% %                 col=tmp4(1, 1);
                tmp1=max(tmp0);
                tmp2=max(tmp1);
                
                tmp3=min(tmp0);
                tmp4=min(tmp1);
                
                
                hmax(k)=tmp2-tmp4;
                k=k+1;
            end
        end
        hmax=hmax';
end