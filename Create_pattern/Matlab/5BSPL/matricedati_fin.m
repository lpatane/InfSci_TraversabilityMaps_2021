

load('SimulationResult.mat');

matricedati=MatriceDati
matricedati_finale=[matricedati(:, 1), matricedati(:, 2), zeros(2894, 1), matricedati(:, 3)];

for i=1:size(matricedati, 1)-1
    
    matricedati_finale(i, 3)=matricedati_finale(i+1, 2);
    
end