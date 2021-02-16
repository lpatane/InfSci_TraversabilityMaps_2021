clear all;
clc;
close all;

load ('totale_patteren_input_e_output.mat');

nord=reshape(totale_patteren_input_e_output(1:3332, 5), [49 68]);

est=reshape(totale_patteren_input_e_output(3332+1:3332*2, 5), [49 68]);

sud=reshape(totale_patteren_input_e_output(3332*2+1:3332*3, 5), [49 68]);

ovest=reshape(totale_patteren_input_e_output(3332*3+1:3332*4, 5), [49 68]);

nord_est=reshape(totale_patteren_input_e_output(3332*4+1:3332*5, 5), [49 68]);

nord_ovest=reshape(totale_patteren_input_e_output(3332*5+1:3332*6, 5), [49 68]);

sud_est=reshape(totale_patteren_input_e_output(3332*6+1:3332*7, 5), [49 68]);

sud_ovest=reshape(totale_patteren_input_e_output(3332*7+1:3332*8, 5), [49 68]);

% % for i=1:size(nord, 1) %righe
% %     for j=1:size(nord, 2)
% %         if(nord(i, j)>=100000/2)
% %             nord(i, j)=100000; %non ci arrivo
% %         else
% %             nord(i, j)=0.1; %ci arrivo
% %         end
% %     end
% % end
% % 
% % for i=1:size(sud, 1) %righe
% %     for j=1:size(sud, 2)
% %         if(sud(i, j)>=100000/2)
% %             sud(i, j)=100000;
% %         else
% %             sud(i, j)=0.1;
% %         end
% %     end
% % end
% % 
% % for i=1:size(est, 1) %righe
% %     for j=1:size(est, 2)
% %         if(est(i, j)>=100000/2)
% %             est(i, j)=100000;
% %         else
% %             est(i, j)=0.1;
% %         end
% %     end
% % end
% % 
% % for i=1:size(ovest, 1) %righe
% %     for j=1:size(ovest, 2)
% %         if(ovest(i, j)>=100000/2)
% %             ovest(i, j)=100000;
% %         else
% %             ovest(i, j)=0.1;
% %         end
% %     end
% % end
% % 
% % for i=1:size(nord_est, 1) %righe
% %     for j=1:size(nord_est, 2)
% %         if(nord_est(i, j)>=100000/2)
% %             nord_est(i, j)=100000;
% %         else
% %             nord_est(i, j)=0.1;
% %         end
% %     end
% % end
% % 
% % for i=1:size(nord_ovest, 1) %righe
% %     for j=1:size(nord_ovest, 2)
% %         if(nord_ovest(i, j)>=100000/2)
% %             nord_ovest(i, j)=100000;
% %         else
% %             nord_ovest(i, j)=0.1;
% %         end
% %     end
% % end
% % 
% % for i=1:size(sud_est, 1) %righe
% %     for j=1:size(sud_est, 2)
% %         if(sud_est(i, j)>=100000/2)
% %             sud_est(i, j)=100000;
% %         else
% %             sud_est(i, j)=0.1;
% %         end
% %     end
% % end
% % 
% % for i=1:size(sud_ovest, 1) %righe
% %     for j=1:size(sud_ovest, 2)
% %         if(sud_ovest(i, j)>=100000/2)
% %             sud_ovest(i, j)=100000;
% %         else
% %             sud_ovest(i, j)=0.1;
% %         end
% %     end
% % end
% 
% %da qui in poi setto per ottenere ciò spiegato nella publicazione pag 3
% 
% %NORD
% tmp(49, 68)=0;
% tmp(2:end, :)=nord(1:end-1, :);
% tmp(1, :)=100000;
% nord=tmp;
% clear tmp
% 
% %SUD
% tmp(49, 68)=0;
% tmp(1:end-1, :)=sud(2:end, :);
% tmp(end, :)=100000;
% sud=tmp;
% clear tmp
% 
% %EST
% tmp(49, 68)=0;
% tmp(1:end, 2:end)=est(1:end, 1:end-1);
% tmp(1:end, 1)=est(:, end);
% tmp(1:end, 1)=100000;
% est=tmp;
% clear tmp
% 
% %OVEST
% tmp(49, 68)=0;
% tmp(1:end, 1:end-1)=ovest(1:end, 2:end);
% tmp(1:end, end)=ovest(:, 1);
% tmp(1:end, end)=100000;
% ovest=tmp;
% clear tmp
% 
% %NORD-EST OK
% orig=nord_est;
% nord_est(:, 1)=100000;
% nord_est(1, :)=100000;
% 
% for i=3:49
%     for j=3:68
%         nord_est(i, j)=orig(i-1,j-1);            
%     end
% end
% clear orig
% 
% %NORD-OVEST OK
% orig=nord_ovest;
% nord_ovest(:, end)=100000;
% nord_ovest(1, :)=100000;
% 
% for i=2:49
%     for j=1:68-1
%         nord_ovest(i, j)=orig(i-1,j+1);
%             
%     end
% end
% clear orig
% 
% 
% %SUD-EST OK
% sud_est(:, 1)=100000;
% sud_est(end, :)=100000;
% orig=sud_est;
% 
% for i=1:49-1
%     for j=2:68
%          sud_est(i, j)=orig(i+1,j-1);
%             
%     end
% end
% 
% 
% 
% %SUD-OVEST OK
% sud_ovest(end, :)=100000;
% sud_ovest(:, end)=100000;
% orig=sud_ovest;
% 
% for i=1:49-1
%     for j=1:68-1
%         sud_ovest(i, j)=orig(i+1,j+1);
%         
%         
%     end
% end
% 
% % 
save('nord.mat', 'nord');
save('sud.mat','sud');
save('est.mat','est');
save('ovest.mat','ovest');
save('nord_est.mat','nord_est');
save('nord_ovest.mat','nord_ovest');
save('sud_est.mat','sud_est');
save('sud_ovest.mat','sud_ovest');
% 
% % nord_Fonte=nord;
% % sud_Fonte=sud;
% % est_Fonte=est;
% % ovest_Fonte=ovest;
% % nord_est_Fonte=nord_est;
% % nord_ovest_Fonte=nord_ovest;
% % sud_est_Fonte=sud_est;
% % sud_ovest_Fonte=sud_ovest;
% 
% % save('nord_Fonte.mat', 'nord_Fonte');
% % save('sud_Fonte.mat','sud_Fonte');
% % save('est_Fonte.mat','est_Fonte');
% % save('ovest_Fonte.mat','ovest_Fonte');
% % save('nord_est_Fonte.mat','nord_est_Fonte');
% % save('nord_ovest_Fonte.mat','nord_ovest_Fonte');
% % save('sud_est_Fonte.mat','sud_est_Fonte');
% % save('sud_ovest_Fonte.mat','sud_ovest_Fonte');
% % 
% % figure; surf(nord); title('North (Robotnik Summit-XL)');
% % figure; surf(sud); title('South (Robotnik Summit-XL)');
% % figure; surf(est); title('East (Robotnik Summit-XL)');
% % figure; surf(ovest); title('West (Robotnik Summit-XL)');
% % 
% % figure; surf(nord_est); title('North-east (Robotnik Summit-XL)');
% % figure; surf(nord_ovest); title('North-west (Robotnik Summit-XL)');
% % figure; surf(sud_est); title('South-east (Robotnik Summit-XL)');
% % figure; surf(sud_ovest); title('South-west (Robotnik Summit-XL)');
% 
