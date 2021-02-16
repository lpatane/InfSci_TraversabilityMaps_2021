function [pendenza_fin]=calcolaPendenze(T) %T_taglia?
    
    [sizeTx, sizeTy] = size(T);

    %NORD e SUD
    k=1;
    for i=1:sizeTx-1 		%riga
        for j=1:sizeTy-1 	%colonna
            tmp1=T(i, j)+T(1+i, j)/2;
            tmp2=T(i, 1+j)+T(1+i, 1+j)/2;
            pendenza(k)	= tmp1-tmp2;
            clear tmp1
            clear tmp2
            k=k+1;
        end
    end
    pendenza=(reshape(pendenza, [67, 48])');
    pendenza(49, :)=pendenza(48, :);
    pendenza(:, 68)=pendenza(:, 67);

    tmp=pendenza(:);
    pendenza_fin(:, 1)=tmp;
    pendenza_fin(:, 3)=tmp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %EST e OVEST
    clear pendenza
    k=1;
    for i=1:sizeTx-1 		%riga
        for j=1:sizeTy-1 	%colonna
            tmp1=T(i+1, j)+T(1+i, j+1)/2;
            tmp2=T(i, j)+T(i, 1+j)/2;
            pendenza(k)	= tmp1-tmp2;
            clear tmp1
            clear tmp2
            k=k+1;
        end
    end
    pendenza=(reshape(pendenza, [67, 48])');
    pendenza(49, :)=pendenza(48, :);
    pendenza(:, 68)=pendenza(:, 67);

    tmp=pendenza(:);
    pendenza_fin(:, 2)=tmp;
    pendenza_fin(:, 4)=tmp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  