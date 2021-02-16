%1)https://it.mathworks.com/matlabcentral/answers/452377-plane-fitting-using-3d-points
%(piano di fitting dati dei punti con una certa x, y e z)
%2)http://www2.math.umd.edu/~jmr/241/lines_planes.html (trovare l'equazione
%di un piano dati 3 punti, che sarebbe quello del punto precedente)
%3)
%https://www.youmath.it/lezioni/algebra-lineare/geometria-dello-spazio/695-formula-per-la-distanza-di-un-punto-da-un-piano.html
%(equazione, al punto precedente) della distanza tra un punto, quelli del punto 1, e un piano)

function [Rugosita]=Rugosita_finale(T_taglia, n_downsaple)
%     [T ,Traversabilita] = AvgMap(T_intera,n_downsaple, clearence);

    k=1;
    
    [sizeTx, sizeTy] = size(T_taglia);
   sizeTx_2=sizeTx/n_downsaple; %n_downsaple è il numero di campionamento
   sizeTy_2=sizeTy/n_downsaple;
    %passo da vertici a caselle
    for i=1:sizeTx-1 		%riga
        for j=1:sizeTy-1 	%colonna
             media(i, j)	= (T_taglia(i, j)+T_taglia(1+i, j)+T_taglia(i, 1+j)+T_taglia(1+i, 1+j))/4;
        end
    end
        media(i+1, j) = media(i, j);
        media(i, j+1) = media(i, j);

T_taglia=media;

    for j=n_downsaple:n_downsaple:size(T_taglia, 1) %righe

        for i=n_downsaple:n_downsaple:size(T_taglia, 2) %colonne
            
            if i==n_downsaple && j==n_downsaple
                T_small(:, :)=T_taglia(1:n_downsaple, 1:n_downsaple);
            else
                T_small(:, :)=T_taglia(j-(n_downsaple-1):j, i-(n_downsaple-1):i);
            end
            %esegui da qui fino a riga 113 compresa
            load('B');
            mat=b;
            k=1;
            clear tmp2;
%             T_small= rand(5);
            mat=reshape(mat, [5, 5]);
            T_small= mat;            
            r=mat;
            imwrite(r,'r.tiff','tiff');
            surf(r);
            n_downsaple=5;
            tmp=(1:n_downsaple)';
            tmp2(:, 1)=tmp;
            tmp2(:, 2)=1;
            l=2;
            
            for i=n_downsaple:n_downsaple:n_downsaple*n_downsaple-n_downsaple
                tmp2(i+1:n_downsaple*l, 1)=tmp(:, 1);
                tmp2(i+1:n_downsaple*l, 2)=l;
                l=l+1;
            end
            
            tmp2(:, 3)=reshape(T_small, [n_downsaple*n_downsaple, 1]);
            
            clear tmp
            tmp=tmp2;
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

    r=reshape(Rugosita, [sizeTx_2, sizeTy_2]); %terreno 1
    surf(r)
    save('Rugosita_n', 'Rugosita');
    %i valori della reshape li prende dalle grandezze di T che esce da
    %"AvgMap.m"
%     tmp=tmp';
    %surf(tmp)
    %Rugosita=uint8(Rugosita)
end       
    

%VECCHIO FUNZIONANTE
% %1)https://it.mathworks.com/matlabcentral/answers/452377-plane-fitting-using-3d-points
% %(piano di fitting dati dei punti con una certa x, y e z)
% %2)http://www2.math.umd.edu/~jmr/241/lines_planes.html (trovare l'equazione
% %di un piano dati 3 punti, che sarebbe quello del punto precedente)
% %3)
% %https://www.youmath.it/lezioni/algebra-lineare/geometria-dello-spazio/695-formula-per-la-distanza-di-un-punto-da-un-piano.html
% %(equazione, al punto precedente) della distanza tra un punto, quelli del punto 1, e un piano)
% 
% function [Rugosita]=Rugosita_finale(T_taglia, n_downsaple)
% %     [T ,Traversabilita] = AvgMap(T_intera,n_downsaple, clearence);
% 
%     k=1;
%     
%     [sizeTx, sizeTy] = size(T_taglia);
%    sizeTx_2=sizeTx/n_downsaple; %n_downsaple è il numero di campionamento
%    sizeTy_2=sizeTy/n_downsaple;
%     %passo da vertici a caselle
%     for i=1:sizeTx-1 		%riga
%         for j=1:sizeTy-1 	%colonna
%              media(i, j)	= (T_taglia(i, j)+T_taglia(1+i, j)+T_taglia(i, 1+j)+T_taglia(1+i, 1+j))/4;
%         end
%     end
%         media(i+1, j) = media(i, j);
%         media(i, j+1) = media(i, j);
% 
% T_taglia=media;
% 
%     for j=n_downsaple:n_downsaple:size(T_taglia, 1) %righe
% 
%         for i=n_downsaple:n_downsaple:size(T_taglia, 2) %colonne
%             
%             if i==n_downsaple && j==n_downsaple
%                 T_small(:, :)=T_taglia(1:n_downsaple, 1:n_downsaple);
%             else
%                 T_small(:, :)=T_taglia(j-(n_downsaple-1):j, i-(n_downsaple-1):i);
%             end
%             
%             clear tmp2;
%             tmp=(1:n_downsaple)';
%             tmp2(:, 1)=tmp;
%             tmp2(:, 2)=1;
%             l=2;
%             
%             for i=n_downsaple:n_downsaple:n_downsaple*n_downsaple-n_downsaple
%                 tmp2(i+1:n_downsaple*l, 1)=tmp(:, 1);
%                 tmp2(i+1:n_downsaple*l, 2)=l;
%                 l=l+1;
%             end
%             
%             tmp2(:, 3)=reshape(T_small, [n_downsaple*n_downsaple, 1]);
%             
%             clear tmp
%             tmp=tmp2;
%             P = bsxfun(@times, tmp, [1 10 100]);                            % Create Matrix [x, y, z] MODIFICATOOOOOOOOOOO
%             B = [P(:,1), P(:,2), ones(size(P,1),1)] \ P(:,3);               % Linear Regression
%             xv = [min(P(:,1)) max(P(:,1))];
%             yv = [min(P(:,2)) max(P(:,2))];
%             zv = [xv(:), yv(:), ones(2,1)] * B;                             % Calculate Regression Plane
% 
%             %
%             P1=[xv(1), yv(2), zv(2)];
%             P2=[xv(1), yv(1), zv(2)];
%             P3=[xv(2), yv(2), zv(1)];
%             normal = cross(P1-P2, P1-P3);
%             syms x y z;
%             coord = [x,y,z];
%             planefunction = dot(normal, coord-P1)
%         %     dot(coord-P1, normal)
%         %     realdot = @(u, v) u*transpose(v);
%         %     realdot(coord-P1,normal)
% 
%             %
% 
%             coeff=coeffs(planefunction, 'All');
%             coeff = fliplr(coeff)
% 
%         %     figure
%         %     stem3(P(:,1), P(:,2), P(:,3), '.')
%         %     hold on
%         %     patch([min(xv) min(xv) max(xv) max(xv)], [min(yv) max(yv) max(yv) min(yv)], [min(zv) min(zv) max(zv) max(zv)], 'r', 'FaceAlpha',0.5)
%         %     hold off
%         %     grid on
%         %     xlabel('X')
%         %     ylabel('Y')
% 
%             if size(coeff, 1)==1
%             tmp3=zeros(2,2);
%             coeff2=double(coeff);
%             tmp3(2,1:2)=coeff2(1, 1:2);
%             coeff=tmp3;
%             end
% 
%             coeff=double(coeff);
% 
%             for i=1:size(P, 1)
%                 tmp1=(abs(coeff(1, 1)*P(i, 1)+coeff(1, 2)*P(i, 2)+coeff(2, 2)*P(i, 3)+coeff(2, 1))); %modificatooooooooo
%                 tmp2=(sqrt(coeff(1).^2+coeff(2).^2+coeff(3).^2));
%                 distance(i)=(tmp1/tmp2);
%             end
% 
%             sum=0;
% 
%             for i=1:size(distance, 2)
%                 sum=sum+distance(i);
% 
%             end
%             Rugosita(k)=sum/i;
%             k=k+1;
%         end
%     %     i=5;
%     end
%     Rugosita=Rugosita';
% 
%     r=reshape(Rugosita, [sizeTx_2, sizeTy_2]); %terreno 1
%     surf(r)
%     save('Rugosita_n', 'Rugosita');
%     %i valori della reshape li prende dalle grandezze di T che esce da
%     %"AvgMap.m"
% %     tmp=tmp';
%     %surf(tmp)
%     %Rugosita=uint8(Rugosita)
% end       
%     