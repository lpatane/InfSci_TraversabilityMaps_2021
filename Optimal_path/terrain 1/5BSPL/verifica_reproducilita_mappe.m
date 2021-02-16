clear all;
clc;

for k=1:100

k = rete_neurale_3(k);

CreaP

load('nord_Fonte');
load('sud_Fonte');
load('est_Fonte');
load('ovest_Fonte');
load('nord_est_Fonte');
load('nord_ovest_Fonte');
load('sud_est_Fonte');
load('sud_ovest_Fonte');


devstd_N(k)=mse(nord_Fonte, nord);
devstd_S(k)=mse(sud_Fonte, sud);
devstd_E(k)=mse(est_Fonte, est);
devstd_O(k)=mse(ovest_Fonte, ovest);
devstd_NE(k)=mse(nord_est_Fonte, nord_est);
devstd_NO(k)=mse(nord_ovest_Fonte, nord_ovest);
devstd_SE(k)=mse(sud_est_Fonte, sud_est);
devstd_SO(k)=mse(sud_ovest_Fonte, sud_ovest);

end

% figure; plot(devstd_N/100000000); xlabel('Samples'); ylabel('MSE'); title('MSE (not average results)'); 
% figure;plot(devstd_S/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (not average results)'); 
% figure;plot(devstd_E/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (not average results)'); 
% figure;plot(devstd_O/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (not average results)'); 
% figure;plot(devstd_NE/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (not average results)'); 
% figure;plot(devstd_NO/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (not average results)'); 
% figure;plot(devstd_SE/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (not average results)'); 
% figure;plot(devstd_SO/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (not average results)'); 

figure; plot(devstd_N/100000000); xlabel('Samples'); ylabel('MSE'); title('MSE (binary results)'); 
figure;plot(devstd_S/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (average results)');
figure;plot(devstd_E/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (average results)');
figure;plot(devstd_O/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (average results)');
figure;plot(devstd_NE/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (average results)'); 
figure;plot(devstd_NO/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (average results)'); 
figure;plot(devstd_SE/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (average results)'); 
figure;plot(devstd_SO/100000000);xlabel('Samples'); ylabel('MSE'); title('MSE (average results)'); 



% 
% for i=1:size(nord, 1)
%     for j=1:size(nord, 2)
%         tmp=nord(i, j);
%     end
% end
% media(i)=tmp/49*68;
%         
% end
% 
% plot(media);