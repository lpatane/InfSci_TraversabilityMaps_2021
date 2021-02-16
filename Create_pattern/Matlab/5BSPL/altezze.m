function [diff_h_new]=altezze(sizeTx,sizeTy,T_intera)
    
    for i=1:sizeTx-1 		%riga
        for j=1:sizeTy-1 	%colonna
            media(i, j)	= (T_intera(i, j)+T_intera(1+i, j)+T_intera(i, 1+j)+T_intera(1+i, 1+j))/4;
        end
    end
%     surf(media);
    media(i+1, j) = media(i, j);
    media(i, j+1) = media(i, j);

    [sizex, sizey] 		= size(media);
    
    k=1;
    for i=1:sizex
        for j=1:sizey        
            if (i==1 && j==1) %angolo in alto a sx
                diff_h(k, 1)	= 0; %NORD
                diff_h(k, 2)	= media(i, j)-media(i, j+1); %EST
                diff_h(k, 3)	= media(i, j)-media(i+1, j); %SUD           
                diff_h(k, 4)	= 0; %OVEST

            elseif (i==1 && j==sizey) %angolo in alto a dx
                diff_h(k, 1)	= 0;
                diff_h(k, 2)	= 0;
                diff_h(k, 3)	= media(i, j)-media(i+1, j);
                diff_h(k, 4)	= media(i, j)-media(i, j-1);

            elseif (i==sizex && j==1) %angolo in basso a sx
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= 0;
                diff_h(k, 4)	= 0;

            elseif (i==sizex && j==sizey) %angolo in basso a dx
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= 0;
                diff_h(k, 3)	= 0;
                diff_h(k, 4)	= media(i, j)-media(i, j-1);

            elseif (1<i<sizex && j==1) %lato sx
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= media(i, j)-media(i+1, j);
                diff_h(k, 4)	= 0;

            elseif (i==1 && 1<j<sizey) %lato superiore
                diff_h(k, 1)	= 0;
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= media(i, j)-media(i+1, j);
                diff_h(k, 4)	= media(i, j)-media(i, j-1);

            elseif (1<i<sizex && j==sizey) %lato dx
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= 0;
                diff_h(k, 3)	= media(i, j)-media(i+1, j);
                diff_h(k, 4)	= media(i, j)-media(i, j-1);

            elseif (i==sizex && 1<j<sizey) %lato inferiore
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= 0;
                diff_h(k, 4)	= media(i, j)-media(i, j-1);

            elseif (1<i<sizex && 1<j<sizey) %corpo centrale
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= media(i, j)-media(i+1, j);
                diff_h(k, 4)	= media(i, j)-media(i, j-1);
            end	
                k = k+1;
                if k==67
                    a=5;
                end
        end
    end
    diff_h = diff_h/100;    %porto in metri.
 

a=(reshape(diff_h(:, 1), [68, 49])');
prima=a(:);
b=(reshape(diff_h(:, 2), [68, 49])');
seconda=b(:);
c=(reshape(diff_h(:, 3), [68, 49])');
terza=c(:);
d=(reshape(diff_h(:, 4), [68, 49])');
quarta=d(:);
diff_h_new=[prima seconda terza quarta];
 surf(reshape(prima, [49, 68]));
surf(reshape(seconda, [49, 68]));
surf(reshape(terza, [49, 68]));
surf(reshape(quarta, [49, 68]));
end

