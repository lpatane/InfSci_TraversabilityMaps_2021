% %valori da x a y è definita come il valore medio delle altezze
%unità di misura rugosità-> micrometro(10^-6 m)

function [rugosita]=rugosita(n_downsample,nbx,nby,Map,graph) 

	T_intera			= double(Map); %passa matrice 340x245
	k					= 1;
	new_dx				= n_downsample*nbx;
	new_dy				= n_downsample*nby;
	sizeTx 				= ceil(size(T_intera,1)/n_downsample);
	sizeTy 				= ceil(size(T_intera,2)/n_downsample);
	v					= cell(sizeTx*sizeTy,1);

	MatriceContenitore 	= zeros(new_dx,new_dy);

	for i=1:size(T_intera,1)
		for j=1:size(T_intera,2)
			MatriceContenitore(i,j) = T_intera(i,j);
		end 
	end 

	for i=1:1:nbx-1
		for j=1:1:nby-1
			v{k}		= MatriceContenitore((n_downsample*(i-1)+1):(n_downsample*(i)), (n_downsample*(j-1)+1):(n_downsample*(j)));
			k 			= k +1;
		end
	end

	v2					= cell(sizeTx*sizeTy,1);

	for h=1:size(v,1)
		v2{h}			= (mean(mean(v{h})))*ones(n_downsample,n_downsample);
	end 

	media_rugosita		= cell2mat(reshape(v2,sizeTx,sizeTy));
	matriceRugosita		= abs(T_intera-media_rugosita(1:size(Map,1),1:size(Map,2)));
	matriceRugosita		= matriceRugosita(1:sizeTx,1:sizeTy);
	rugosita  			= reshape(matriceRugosita,nbx*nby,1);
	if graph == 1
        figure;
        surf(matriceRugosita);
        title('Matrice  della Rugosità');
    end
end 