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
                diff_h(k, 5)	= 0; %NORD-OVEST
                diff_h(k, 6)	= 0; %NORD-EST
                diff_h(k, 7)	= 0; %SUD-OVEST
                diff_h(k, 8)	= media(i, j)-media(i+1, j+1); %SUD-EST


            elseif (i==1 && j==sizey) %angolo in alto a dx
                diff_h(k, 1)	= 0;%NORD
                diff_h(k, 2)	= 0;%EST
                diff_h(k, 3)	= media(i, j)-media(i+1, j);%SUD
                diff_h(k, 4)	= media(i, j)-media(i, j-1);%OVEST
                diff_h(k, 5)	= 0; %NORD-OVEST
                diff_h(k, 6)	= 0; %NORD-EST
                diff_h(k, 7)	= media(i, j)-media(i+1, j-1); %SUD-OVEST
                diff_h(k, 8)	= 0; %SUD-EST

            elseif (i==sizex && j==1) %angolo in basso a sx
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= 0;
                diff_h(k, 4)	= 0;
                
                diff_h(k, 5)	= 0; %NORD-OVEST
                diff_h(k, 6)	= media(i, j)-media(i-1, j+1); %NORD-EST
                diff_h(k, 7)	= 0; %SUD-OVEST
                diff_h(k, 8)	= 0; %SUD-EST

            elseif (i==sizex && j==sizey) %angolo in basso a dx
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= 0;
                diff_h(k, 3)	= 0;
                diff_h(k, 4)	= media(i, j)-media(i, j-1);
                
                diff_h(k, 5)	= media(i, j)-media(i-1, j-1); %NORD-OVEST
                diff_h(k, 6)	= 0; %NORD-EST
                diff_h(k, 7)	= 0; %SUD-OVEST
                diff_h(k, 8)	= 0; %SUD-EST

            elseif (1<i<sizex && j==1) %lato sx
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= media(i, j)-media(i+1, j);
                diff_h(k, 4)	= 0;
                
                diff_h(k, 5)	= 0; %NORD-OVEST
                diff_h(k, 6)	= media(i, j)-media(i-1, j+1); %NORD-EST 
                diff_h(k, 7)	= 0; %SUD-OVEST
                diff_h(k, 8)	= media(i, j)-media(i+1, j+1); %SUD-EST

            elseif (i==1 && 1<j<sizey) %lato superiore
                diff_h(k, 1)	= 0;
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= media(i, j)-media(i+1, j);
                diff_h(k, 4)	= media(i, j)-media(i, j-1);
                
                diff_h(k, 5)	= 0; %NORD-OVEST
                diff_h(k, 6)	= 0; %NORD-EST
                diff_h(k, 7)	= media(i, j)-media(i+1, j-1); %SUD-OVEST
                diff_h(k, 8)	= media(i, j)-media(i+1, j+1); %SUD-EST

            elseif (1<i<sizex && j==sizey) %lato dx
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= 0;
                diff_h(k, 3)	= media(i, j)-media(i+1, j);
                diff_h(k, 4)	= media(i, j)-media(i, j-1);
                
                diff_h(k, 5)	= media(i, j)-media(i-1, j-1); %NORD-OVEST
                diff_h(k, 6)	= 0; %NORD-EST
                diff_h(k, 7)	= media(i, j)-media(i+1, j-1); %SUD-OVEST
                diff_h(k, 8)	= 0; %SUD-EST

            elseif (i==sizex && 1<j<sizey) %lato inferiore
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= 0;
                diff_h(k, 4)	= media(i, j)-media(i, j-1);
                
                diff_h(k, 5)	= media(i, j)-media(i-1, j-1); %NORD-OVEST
                diff_h(k, 6)	= media(i, j)-media(i-1, j+1); %NORD-EST 
                diff_h(k, 7)	= 0; %SUD-OVEST
                diff_h(k, 8)	= 0; %SUD-EST

            elseif (1<i<sizex && 1<j<sizey) %corpo centrale
                diff_h(k, 1)	= media(i, j)-media(i-1, j);
                diff_h(k, 2)	= media(i, j)-media(i, j+1);
                diff_h(k, 3)	= media(i, j)-media(i+1, j);
                diff_h(k, 4)	= media(i, j)-media(i, j-1);
                
                diff_h(k, 5)	= media(i, j)-media(i-1, j-1); %NORD-OVEST
                diff_h(k, 6)	= media(i, j)-media(i-1, j+1); %NORD-EST 
                diff_h(k, 7)	= media(i, j)-media(i+1, j-1); %SUD-OVEST
                diff_h(k, 8)	= media(i, j)-media(i+1, j+1); %SUD-EST
            end	
                k = k+1;
                if k==67
                    a=5;
                end
        end
    end
    diff_h = diff_h/100;    %porto in metri.
 

a=(reshape(diff_h(:, 1), [sizeTx, sizeTy])');
prima=a(:);

b=(reshape(diff_h(:, 2), [sizeTx, sizeTy])');
seconda=b(:);

c=(reshape(diff_h(:, 3), [sizeTx, sizeTy])');
terza=c(:);

d=(reshape(diff_h(:, 4), [sizeTx, sizeTy])');
quarta=d(:);

e=(reshape(diff_h(:, 5), [sizeTx, sizeTy])');
quinta=e(:);

f=(reshape(diff_h(:, 6), [sizeTx, sizeTy])');
sesta=f(:);

g=(reshape(diff_h(:, 7), [sizeTx, sizeTy])');
settima=g(:);

h=(reshape(diff_h(:, 8), [sizeTx, sizeTy])');
ottava=h(:);

diff_h_new=[prima seconda terza quarta quinta sesta settima ottava];
% surf(reshape(prima, [49, 68]));
% surf(reshape(seconda, [49, 68]));
% surf(reshape(terza, [49, 68]));
% surf(reshape(quarta, [49, 68]));
% 
% surf(reshape(quinta, [49, 68]));
% surf(reshape(sesta, [49, 68]));
% surf(reshape(settima, [49, 68]));
% surf(reshape(ottava, [49, 68]));
end

