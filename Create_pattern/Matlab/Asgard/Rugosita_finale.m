%1)https://it.mathworks.com/matlabcentral/answers/452377-plane-fitting-using-3d-points
%(piano di fitting dati dei punti con una certa x, y e z)
%2)http://www2.math.umd.edu/~jmr/241/lines_planes.html (trovare l'equazione
%di un piano dati 3 punti, che sarebbe quello del punto precedente)
%3)
%https://www.youmath.it/lezioni/algebra-lineare/geometria-dello-spazio/695-formula-per-la-distanza-di-un-punto-da-un-piano.html
%(equazione, al punto precedente) della distanza tra un punto, quelli del punto 1, e un piano)




function [Rugosita]=Rugosita_finale(T_taglia)
%     [T ,Traversabilita] = AvgMap(T_intera,n_downsaple, clearence);

    k=1;
    
    [sizeTx, sizeTy] = size(T_taglia);

    %passo da vertici a caselle
    for i=1:sizeTx-1 		%riga
        for j=1:sizeTy-1 	%colonna
             media(i, j)	= (T_taglia(i, j)+T_taglia(1+i, j)+T_taglia(i, 1+j)+T_taglia(1+i, 1+j))/4;
        end
    end
        media(i+1, j) = media(i, j);
        media(i, j+1) = media(i, j);

T_taglia=media;

    for j=5:5:size(T_taglia, 1) %righe

        for i=5:5:size(T_taglia, 2) %colonne

        if i==5 && j==5
            T_small(:, :)=T_taglia(1:5, 1:5);
        else
            T_small(:, :)=T_taglia(j-4:j, i-4:i);
        end

        for i=1:5
            tmp(i, :)=[i 1 T_small(1, i)]; 
        end

        for i=6:10
            tmp(i, :)=[i-5 2 T_small(2, i-5)]; 
        end

        for i=11:15
            tmp(i, :)=[i-10 3 T_small(3, i-10)]; 
        end

        for i=16:20
            tmp(i, :)=[i-15 4 T_small(4, i-15)]; 
        end

        for i=21:25
            tmp(i, :)=[i-20 5 T_small(5, i-20)]; 
        end

        P = bsxfun(@times, tmp, [1 10 100]);                            % Create Matrix [x, y, z] MODIFICATOOOOOOOOOOO
        B = [P(:,1), P(:,2), ones(size(P,1),1)] \ P(:,3);               % Linear Regression
        xv = [min(P(:,1)) max(P(:,1))];
        yv = [min(P(:,2)) max(P(:,2))];
        zv = [xv(:), yv(:), ones(2,1)] * B;                             % Calculate Regression Plane

        %
        P1=[xv(1), yv(2), zv(2)];
        P2=[xv(1), yv(1), zv(2)];
        P3=[xv(2), yv(2), zv(1)];
        normal = cross(P1-P2, P1-P3);
        syms x y z;
        coord = [x,y,z];
        planefunction = dot(normal, coord-P1)
    %     dot(coord-P1, normal)
    %     realdot = @(u, v) u*transpose(v);
    %     realdot(coord-P1,normal)

        %

        coeff=coeffs(planefunction, 'All');
        coeff = fliplr(coeff)

    %     figure
    %     stem3(P(:,1), P(:,2), P(:,3), '.')
    %     hold on
    %     patch([min(xv) min(xv) max(xv) max(xv)], [min(yv) max(yv) max(yv) min(yv)], [min(zv) min(zv) max(zv) max(zv)], 'r', 'FaceAlpha',0.5)
    %     hold off
    %     grid on
    %     xlabel('X')
    %     ylabel('Y')

        if size(coeff, 1)==1
        tmp3=zeros(2,2);
        coeff2=double(coeff);
        tmp3(2,1:2)=coeff2(1, 1:2);
        coeff=tmp3;
        end

        coeff=double(coeff);

        for i=1:size(P, 1)
            tmp1=(abs(coeff(1, 1)*P(i, 1)+coeff(1, 2)*P(i, 2)+coeff(2, 2)*P(i, 3)+coeff(2, 1))); %modificatooooooooo
            tmp2=(sqrt(coeff(1).^2+coeff(2).^2+coeff(3).^2));
            distance(i)=(tmp1/tmp2);
        end

        sum=0;

        for i=1:size(distance, 2)
            sum=sum+distance(i);

        end
        Rugosita(k)=sum/i;
        k=k+1;
        end
    %     i=5;
    end
    Rugosita=Rugosita';
    
    tmp=reshape(Rugosita, [49, 68]); %Rugosita=reshape(Rugosita, [68, 49]);
%     tmp=tmp';
    surf(tmp)
    %Rugosita=uint8(Rugosita)
end       
    