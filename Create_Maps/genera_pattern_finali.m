function [patterningresso_mediati_con_zscore] = genera_pattern_finali(T_intera)


[sizeTx, sizeTy]=size(T_intera);
load("patterningresso_non_mediati_senza_zscore.mat");%creata con totali_pattern.m non applicando la zscore
load("matrice_altezze"); 
load("dim");

rugosita=patterningresso_non_mediati_senza_zscore(1:dim, 4);

%S
for i=1:dim %OK
    if i==1 
        rugositaS(i)=0;
    else
        rugositaS(i)=(rugosita(i)+rugosita(i-1))/2;
    end
end

%O
for i=1:dim %OK
    if i-sizeTx<=0 
        rugositaO(i)=0;
    else
        rugositaO(i)=(rugosita(i)+(rugosita(i-sizeTx)))/2;
    end
end

%N
for i=1:dim %OK
    if  i+1>dim 
        rugositaN(i)=0;
    else
        rugositaN(i)=(rugosita(i)+rugosita(i+1))/2;
    end
end

%E
for i=1:dim %OK
    if i+sizeTx>=dim 
        rugositaE(i)=0;
    else
        rugositaE(i)=(rugosita(i)+rugosita(i+sizeTx))/2;
    end
end


%SO OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=1;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i<=sizeTx || tmp2==1
        rugositaSO(i)=0;
    else
        rugositaSO(i)=(rugosita(i)+rugosita(i-sizeTx-1))/2;
    end
end

%SE OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=1;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i>=dim-sizeTx || tmp2==1
        rugositaSE(i)=0;
    else
        rugositaSE(i)=(rugosita(i)+rugosita(i+sizeTx-1))/2;
    end
end

%NO OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=sizeTx;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i<=sizeTx || tmp2==1
        rugositaNO(i)=0;
    else
        rugositaNO(i)=(rugosita(i)+rugosita(i-sizeTx+1))/2;
    end
end

%NE OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=sizeTx;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i>=dim-sizeTx || tmp2==1
        rugositaNE(i)=0;
    else
        rugositaNE(i)=(rugosita(i)+rugosita(i+sizeTx+1))/2;
    end
end
totalepattern=patterningresso_non_mediati_senza_zscore;
rugositamediata=[rugositaN'; rugositaE'; rugositaS'; rugositaO'; rugositaNE'; rugositaNO'; rugositaSE'; rugositaSO' ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hmax=totalepattern(1:dim, 3);

for i=1:dim %OK
    if i==1
        hmaxS(i)=0;
    else
        hmaxS(i)=(hmax(i)+hmax(i-1))/2;
    end
end

for i=1:dim %OK
    if i-sizeTx<=0 
        hmaxO(i)=0;
    else
        hmaxO(i)=(hmax(i)+(hmax(i-sizeTx)))/2;
    end
end

for i=1:dim
    if  i+1>dim 
        hmaxN(i)=0;
    else
        hmaxN(i)=(hmax(i)+hmax(i+1))/2;
    end
end

for i=1:dim
    if i+sizeTx>=dim 
        hmaxE(i)=0;
    else
        hmaxE(i)=(hmax(i)+hmax(i+sizeTx))/2;
    end
end

%SO OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=1;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i<=sizeTx || tmp2==1
        hmaxSO(i)=0;
    else
        hmaxSO(i)=(hmax(i)+hmax(i-sizeTx-1))/2;
    end
end

%SE OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=1;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i>=dim-sizeTx || tmp2==1
        hmaxSE(i)=0;
    else
        hmaxSE(i)=(hmax(i)+hmax(i+sizeTx-1))/2;
    end
end

%NO OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=sizeTx;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i<=sizeTx || tmp2==1
        hmaxNO(i)=0;
    else
        hmaxNO(i)=(hmax(i)+hmax(i-sizeTx+1))/2;
    end
end

%NE OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=sizeTx;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i>=dim-sizeTx || tmp2==1
        hmaxNE(i)=0;
    else
        hmaxNE(i)=(hmax(i)+hmax(i+sizeTx+1))/2;
    end
end

hmaxmediata=[hmaxN'; hmaxE'; hmaxS'; hmaxO'; hmaxNE'; hmaxNO'; hmaxSE'; hmaxSO'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pendenze=totalepattern(1:dim*4, 2);

a=matriceAltezze(:, 1);
b=matriceAltezze(:, 2);
c=matriceAltezze(:, 3);
d=matriceAltezze(:, 4);
e=matriceAltezze(:, 5);
f=matriceAltezze(:, 6);
g=matriceAltezze(:, 7);
h=matriceAltezze(:, 8);

altezzemediate=[a; b; c; d; e; f; g; h];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pendenze=totalepattern(1:dim*4, 2);

pendenzeN_=pendenze(1:dim);
pendenzeE_=pendenze(dim+1:dim*2);
pendenzeS_=pendenze(dim*2+1:dim*3);
pendenzeO_=pendenze(dim*3+1:dim*4);

%S OK
for i=1:dim %OK
    if i==1
        pendenzeS(i)=0;
    else
        pendenzeS(i)=(pendenzeS_(i)+pendenzeN_(i-1))/2;
    end
end

%O
for i=1:dim %OK
    if i-sizeTx<=0 
        pendenzeO(i)=0;
    else
        pendenzeO(i)=(pendenzeO_(i)+(pendenzeE_(i-sizeTx)))/2;
    end
end

%N
for i=1:dim
    if  i+1>dim 
        pendenzeN(i)=0;
    else
        pendenzeN(i)=(pendenzeN_(i)+pendenzeS_(i+1))/2;
    end
end 

%E
for i=1:dim
    if i+sizeTx>=dim 
        pendenzeE(i)=0;
    else
        pendenzeE(i)=(pendenzeE_(i)+pendenzeO_(i+sizeTx))/2;
    end
end

%SO OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=1;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i<=sizeTx || tmp2==1
        pendenzeSO(i)=0;
    else
        pendenzeSO(i)=(pendenzeS(i-sizeTx-1)+pendenzeO(i-sizeTx-1))/2;
    end
end

%SE OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=1;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i>=dim-sizeTx || tmp2==1
        pendenzeSE(i)=0;
    else
        pendenzeSE(i)=(pendenzeS(i+sizeTx-1)+pendenzeE(i+sizeTx-1))/2;
    end
end

%NO OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=sizeTx;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i<=sizeTx || tmp2==1
        pendenzeNO(i)=0;
    else
        pendenzeNO(i)=(pendenzeN(i-sizeTx+1)+pendenzeO(i-sizeTx+1))/2;
    end
end

%NE OK
tmp=1;
for i=1:sizeTy
    if i==1
        tmp(1)=sizeTx;
    else
    tmp(i)=tmp(i-1)+sizeTx;
    end
end

for i=1:dim %OK
    
    for j=1:sizeTy
        if i==tmp(j)
            tmp2=1;
            break
        else
            tmp2=0;
        end
    end

    if i>=dim-sizeTx || tmp2==1
        pendenzeNE(i)=0;
    else
        pendenzeNE(i)=(pendenzeN(i+sizeTx+1)+pendenzeE(i+sizeTx+1))/2;
    end
end

pendenzemediata=[pendenzeN'; pendenzeE'; pendenzeS'; pendenzeO'; pendenzeNE'; pendenzeNO'; pendenzeSE'; pendenzeSO'];

totalepatternmediati=[altezzemediate pendenzemediata hmaxmediata rugositamediata];

patterningresso_mediati_con_zscore=zscore(totalepatternmediati);

save('C:\Users\Salvo\Desktop\materiale\Create_Maps\patterningresso_mediati_con_zscore', 'patterningresso_mediati_con_zscore');
%in uscita ho "patterningresso_mediati_con_zscore.mat"




