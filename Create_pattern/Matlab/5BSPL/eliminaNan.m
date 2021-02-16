function [DataOut] = eliminaNan(DataInput)
    k = 0;
    tmp = DataInput;
    for i = 1:1:size(DataInput,1)
           if isnan(DataInput(i,5))|| DataInput(i,5) == 999 
                tmp(i-k,:)=[];
                k = k+1;
            else 
                tmp(i-k,:) = DataInput(i,:);
            end
    end

    DataOut = tmp;
end