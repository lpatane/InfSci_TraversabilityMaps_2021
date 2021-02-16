clear;
clc;
close all;

%lato basso
for i=1:7 
    if i==1
        basso(1)=1;
    else
    basso(i)=basso(i-1)+5;
    end
end

%lato alto
for i=1:7
    if i==1
        alto(1)=5;
    else
    alto(i)=alto(i-1)+5;    
    end
end

%lato destro
a=1:35
for i=1:5
    destra(i)=a(end+1-i);    
end

%lato sinistro
a=1:35
for i=1:5
    sinistra(i)=a(i);    
end

A=[];
for i=1:1:35
    for j=1:8
        tmp(j)=i;
    end
    A=[A tmp];
end

b=1:280
B=[];
control=0;
for i=1:35
        %N
        for j=1:size(alto, 2)
            if b(i)==alto(j)
                control=1;
                break;
            else
                control=0;
            end
        end
        if control == 1
             tmp1(1)=b(i); 
        else            
            tmp1(1)=b(i+1); 

        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        %NE
        tmp1(2)=999;
        for j=1:size(alto, 2)
            if b(i)==alto(j)
                tmp1(2)=b(i);
                break;
            end
        end
        
        for j=1:size(destra, 2)
            if b(i)==destra(j)
                tmp1(2)=b(i); 
                break;
            end
        end
        
        if tmp1(2)==999
            tmp1(2)=b(i+5+1);  
        end   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %E
        for j=1:size(destra, 2)
            if b(i)==destra(j)
                control=1;
                break;
            else
                control=0;
            end
        end
        
        if control == 1
             tmp1(3)=b(i);
        else
            tmp1(3)=b(i+5);  
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              
        %SE    
        tmp1(4)=999;
        for j=1:size(basso, 2)
            if b(i)==basso(j)
               tmp1(4)=b(i);
               break;           
            end
        end
        
        for j=1:size(destra, 2)
            if b(i)==destra(j)
               tmp1(4)=b(i);                                         
            end
        end
        
        if tmp1(4)==999
            tmp1(4)=b(i+5-1);
        end
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %S
        for j=1:size(basso, 2)
            if b(i)==basso(j)
                control=1;
                break;
            else
                control=0;
            end
        end
        if control == 1
             tmp1(5)=b(i); 
        else            
            tmp1(5)=b(i-1); 
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %SO
        tmp1(6)=999;
        for j=1:size(basso, 2)
            if b(i)==basso(j)
                 tmp1(6)=b(i);
                 break;            
            end
        end
        
        for j=1:size(sinistra, 2)
            if b(i)==sinistra(j)
                tmp1(6)=b(i);
                break;
            end
        end
        if tmp1(6)==999
            tmp1(6)=b(i-5-1);
        end
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %O
        for j=1:size(sinistra, 2)
            if b(i)==sinistra(j)
                control=1;
                break;
            else
                control=0;
            end
        end
        
        if control == 1
             tmp1(7)=b(i);
        else
            tmp1(7)=b(i-5);  
        end
        %%%%%%%%%%%%%%%%%%%%%%%%
        
        %NO
        tmp1(8)=999;
        for j=1:size(alto, 2)
            if b(i)==alto(j)
                tmp1(8)=b(i);
                break;
            end
        end
        
        for j=1:size(sinistra, 2)
            if b(i)==sinistra(j)
                 tmp1(8)=b(i);
                 break;
            end
        end  
        
        if tmp1(8)==999
            tmp1(8)=b(i-5+1);  
        end
        
        B=[B tmp1];

end
% load ('B');
% B=B(1:26656);
w=randi([1,100],1,280);
G = digraph(A,B, w);
plot(G,'EdgeLabel',G.Edges.Weight)

