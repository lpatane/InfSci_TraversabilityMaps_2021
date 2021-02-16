function [attr_medio]=attriti(nbx,nby,T, graph)

    for i=2:nbx 							%riga
        for j=2:nby 						%colonna
            if T(i, j)>150 || T(i, j)<50 	% parte sopra e sotto
                Attriti(i, j) 	= 0.8;
            else 							%parte centrale lungo i pendii
                Attriti(i, j) 	= 0.3;
            end
        end
    end
    
    Attriti(i+1, j) = Attriti(i, j);
    Attriti(i, j+1) = Attriti(i, j);
    if graph == 1
        figure;
        surf(Attriti);
        title('Matrice degli Attriti');
    end

    [sizeTx, sizeTy] 			= size(Attriti);

    for i=1:sizeTx-1 						%riga
        for j=1:sizeTy-1 					%colonna
            attr_medio(i, j) 	= (Attriti(i, j)+Attriti(1+i, j)+Attriti(i, 1+j)+Attriti(1+i, 1+j))/4;
        end
    end

    attr_medio 					= reshape(attr_medio,(nbx)*(nby),1);
end 