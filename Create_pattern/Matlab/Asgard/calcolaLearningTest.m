function [matriceLearning,matriceTest]=calcolaLearningTest(matrice)

    ottanta = ceil((size(matrice,1))*0.8);

    for i = 1:1:ottanta
        for j = 1:1:size(matrice,2)
            matriceLearning(i,j) = matrice(i,j);    
        end
    end

    for i = ottanta+1:1:size(matrice,1)
        for j = 1:1:size(matrice,2)
            matriceTest((i-ottanta),j) = matrice(i,j);    
        end
    end
end