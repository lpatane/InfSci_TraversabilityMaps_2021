% % clear;
% % clc;
% % close all;
% 
% clear A
% clear B
% clear w
% %lato basso
% for i=1:68 
%     if i==1
%         basso(1)=1;
%     else
%     basso(i)=basso(i-1)+49;
%     end
% end
% 
% %lato alto
% for i=1:68
%     if i==1
%         alto(1)=49;
%     else
%     alto(i)=alto(i-1)+49;    
%     end
% end
% 
% %lato destro
% a=1:3332;
% for i=1:49
%     destra(i)=a(end+1-i);    
% end
% 
% %lato sinistro
% a=1:3332;
% for i=1:49
%     sinistra(i)=a(i);    
% end
% 
% A=[];
% for i=1:1:3332
%     for j=1:8
%         tmp(j)=i;
%     end
%     A=[A tmp];
% end
% 
% b=1:26656;
% B=[];
% control=0;
% for i=1:3332
%         %N
%         for j=1:size(alto, 2)
%             if b(i)==alto(j)
%                 control=1;
%                 break;
%             else
%                 control=0;
%             end
%         end
%         if control == 1
%              tmp1(1)=b(i); 
%         else            
%             tmp1(1)=b(i+1); 
% 
%         end
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %NE
%         tmp1(2)=99999999999;
%         for j=1:size(alto, 2)
%             if b(i)==alto(j)
%                 tmp1(2)=b(i);
%                 break;
%             end
%         end
%         
%         for j=1:size(destra, 2)
%             if b(i)==destra(j)
%                 tmp1(2)=b(i); 
%                 break;
%             end
%         end
%         
%         if tmp1(2)==99999999999
%             tmp1(2)=b(i+49+1);  
%         end   
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %E
%         for j=1:size(destra, 2)
%             if b(i)==destra(j)
%                 control=1;
%                 break;
%             else
%                 control=0;
%             end
%         end
%         
%         if control == 1
%              tmp1(3)=b(i);
%         else
%             tmp1(3)=b(i+49);  
%         end
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              
%         %SE    
%         tmp1(4)=99999999999;
%         for j=1:size(basso, 2)
%             if b(i)==basso(j)
%                tmp1(4)=b(i);
%                break;           
%             end
%         end
%         
%         for j=1:size(destra, 2)
%             if b(i)==destra(j)
%                tmp1(4)=b(i);                                         
%             end
%         end
%         
%         if tmp1(4)==99999999999
%             tmp1(4)=b(i+49-1);
%         end
%                 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %S
%         for j=1:size(basso, 2)
%             if b(i)==basso(j)
%                 control=1;
%                 break;
%             else
%                 control=0;
%             end
%         end
%         if control == 1
%              tmp1(5)=b(i); 
%         else            
%             tmp1(5)=b(i-1); 
%         end
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         
%         %SO
%         tmp1(6)=99999999999;
%         for j=1:size(basso, 2)
%             if b(i)==basso(j)
%                  tmp1(6)=b(i);
%                  break;            
%             end
%         end
%         
%         for j=1:size(sinistra, 2)
%             if b(i)==sinistra(j)
%                 tmp1(6)=b(i);
%                 break;
%             end
%         end
%         if tmp1(6)==99999999999
%             tmp1(6)=b(i-49-1);
%         end
%                 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%
%         
%         %O
%         for j=1:size(sinistra, 2)
%             if b(i)==sinistra(j)
%                 control=1;
%                 break;
%             else
%                 control=0;
%             end
%         end
%         
%         if control == 1
%              tmp1(7)=b(i);
%         else
%             tmp1(7)=b(i-49);  
%         end
%         %%%%%%%%%%%%%%%%%%%%%%%%
%         
%         %NO
%         tmp1(8)=99999999999;
%         for j=1:size(alto, 2)
%             if b(i)==alto(j)
%                 tmp1(8)=b(i);
%                 break;
%             end
%         end
%         
%         for j=1:size(sinistra, 2)
%             if b(i)==sinistra(j)
%                  tmp1(8)=b(i);
%                  break;
%             end
%         end  
%         
%         if tmp1(8)==99999999999
%             tmp1(8)=b(i-49+1);  
%         end
%         
%         B=[B tmp1];
% 
% end
% % load ('B');
% % B=B(1:26656);
% % w=randi([1,100],1,26656);
% 
% % load('nord');
% % load('nord_est');
% % load('est');
% % load('sud_est');
% % load('sud');
% % load('sud_ovest');
% % load('ovest');
% % load('nord_ovest');
% 
% load('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\mse_ciclica\nord_Fonte');
% load('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\mse_ciclica\nord_est_Fonte');
% load('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\mse_ciclica\est_Fonte');
% load('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\mse_ciclica\sud_est_Fonte');
% load('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\mse_ciclica\sud_Fonte');
% load('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\mse_ciclica\sud_ovest_Fonte');
% load('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\mse_ciclica\ovest_Fonte');
% load('C:\Users\Salvo\Desktop\test_correttezza_dpa\dpa\mse_ciclica\nord_ovest_Fonte');
% 
% 
% % figure; surf(nord_Fonte);
% % figure; surf(nord_est_Fonte);
% % figure; surf(est_Fonte);
% % figure; surf(sud_est_Fonte);
% % figure; surf(sud_Fonte);
% % figure; surf(sud_ovest_Fonte);
% % figure; surf(ovest_Fonte);
% % figure; surf(nord_ovest_Fonte);
% 
% clear tmp
% tmp=1;
% w=[];
% for i=1:1:3332
%     for j=1:8
%         if j==1
%             tmp(j)=nord_Fonte(i);
%         end
%         if j==2
%             tmp(j)=nord_est_Fonte(i);
%         end
%         if j==3
%             tmp(j)=est_Fonte(i);
%         end
%         if j==4
%             tmp(j)=sud_est_Fonte(i);
%         end
%         if j==5
%             tmp(j)=sud_Fonte(i);
%         end
%         if j==6
%             tmp(j)=sud_ovest_Fonte(i);
%         end
%         if j==7
%             tmp(j)=ovest_Fonte(i);
%         end
%         if j==8
%             tmp(j)=nord_ovest_Fonte(i);
%         end
%             
%     end
%     w=[w tmp];
% end
% 
% 
% % for i=1:1:3332
% %     for j=1:8
% %         if j==1
% %             tmp(j)=nord(i);
% %         end
% %         if j==2
% %             tmp(j)=nord_est(i);
% %         end
% %         if j==3
% %             tmp(j)=est(i);
% %         end
% %         if j==4
% %             tmp(j)=sud_est(i);
% %         end
% %         if j==5
% %             tmp(j)=sud_ovest(i);
% %         end
% %         if j==6
% %             tmp(j)=sud_ovest(i);
% %         end
% %         if j==7
% %             tmp(j)=ovest(i);
% %         end
% %         if j==8
% %             tmp(j)=nord_ovest(i);
% %          end             
% %      end
% %     w=[w tmp];
% % end
% 
% G = digraph(A, B, w);

% start=1;
% finale=1;
% 
% %1)
% %elimino i punti afferenti al gabiotto centrale
% lato_sinistro=[49*32+30:49*32+42]'; 
% tmp=lato_sinistro;
% for i=1:12
%     for j=2:28       
%             tmp(i,j)=tmp(i, j-1)+49;
%     end
% end
% gabiotto=tmp;
% clear lato_sinistro
% %2)
% %elimino i punti afferenti al gomito
% lato_sinistro=[49*17+11:49*17+33]'; 
% tmp=lato_sinistro;
% for i=1:23
%     for j=2:9       
%             tmp(i,j)=tmp(i, j-1)+49;
%     end
% end
% gomito=tmp;
% 
% gomito=reshape(gomito, [1, size(gomito, 1)*size(gomito, 2)])';
% gabiotto=reshape(gabiotto, [1, size(gabiotto, 1)*size(gabiotto, 2)])';
% 
% da_eliminare=[gomito; gabiotto];
% %riprendi da quiiiiiiiiiii
% while(true)
%     for i=1:size(gabiotto, 1)
%         for j=1:size(gabiotto, 2)
%             while start==gabiotto(i, j) || finale==gabiotto(i, j)
%                 start = randi([1,3332],1,1);
%                 finale = randi([1,3332],1,1);
%             end
%         end
%     end
%     
% end

%https://it.mathworks.com/matlabcentral/answers/450814-randi-except-one-variable
% valid_vals = setdiff(1:3332, da_eliminare);
% % start = valid_vals( randi(length(valid_vals), 1, 1) );
% % fine = valid_vals( randi(length(valid_vals), 1, 1) );
% 
% while (start==finale) || abs(start-finale)>400 %modificato per rendere i percorsi di lunghezza desiderata
%     start = valid_vals( randi(length(valid_vals), 1, 1) );
%     finale = valid_vals( randi(length(valid_vals), 1, 1) );
% end

    %2)
% %se il punto di partenza/arrivo è all'interno del gabbiotto allora
% %il punto di arrivo/partenza deve essere dentro il gabbiotto!!!
% lato_sinistro=[49*33+31:49*33+41];
% lato_destro=[49*59+31:49*59+41];
% lato_superiore=49*33+41;
% for j=1:59-26
%     tmp=49*33+41+49*j;
%     lato_superiore=[lato_superiore tmp];
% end
% clear tmp
% lato_inferiore=49*33+31;
% for j=1:59-26
%     tmp=49*33+31+49*j;
%     lato_inferiore=[lato_inferiore tmp];
% end
% if 49*33+31<=start<=49*33+41 && 49*59+31<=start<=49*59+41
% punti_di_partenza(g)=start;
% punti_di_arrivo(g)=finale;
%OptimalPath = shortestpath(G,49*60+47,49*17+31); %buono

load('Graph_AsgCoop');
OptimalPath = shortestpath(G,49*60+44,49*15+31);

save('OptimalPath', 'OptimalPath');
visualizePath
% g=g+1;
%plot(G);

