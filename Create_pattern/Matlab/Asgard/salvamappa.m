[T_intera, R1]=geotiffread('C:\Users\Salvo\Desktop\21112019\finale con classificatore\polo_pad.tif');
T    = (T_intera(21:360,29:273));
% T           = AvgMap(T_intera,5);


T=T*0.3;
T=uint8(T);
% % T=Downsample_map(T_taglia,n_downsaple);
% % T = (T - min(min(T))); %normalizzazione delle altezze in cm.
T=T';
imwrite(T','Taglia.png');