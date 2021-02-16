clear;
clc;
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\nord_nonsogliata'])
assignin('base','nord_nonsogliata',nord)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\sud_nonsogliata'])
assignin('base','sud_nonsogliata',sud)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\est_nonsogliata'])
assignin('base','est_nonsogliata',est)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\ovest_nonsogliata'])
assignin('base','ovest_nonsogliata',ovest)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\nord_est_nonsogliata'])
assignin('base','nord_est_nonsogliata',nord_est)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\nord_ovest_nonsogliata'])
assignin('base','nord_ovest_nonsogliata',nord_ovest)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\sud_est_nonsogliata'])
assignin('base','sud_est_nonsogliata',sud_est)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\sud_ovest_nonsogliata'])
assignin('base','sud_ovest_nonsogliata',sud_ovest)
      
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\nord_sogliata'])
assignin('base','nord_sogliata',nord)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\sud_sogliata'])
assignin('base','sud_sogliata',sud)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\est_sogliata'])
assignin('base','est_sogliata',est)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\ovest_sogliata'])
assignin('base','ovest_sogliata',ovest)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\nord_est_sogliata'])
assignin('base','nord_est_sogliata',nord_est)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\nord_ovest_sogliata'])
assignin('base','nord_ovest_sogliata',nord_ovest)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\sud_est_sogliata'])
assignin('base','sud_est_sogliata',sud_est)
load (['C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\sud_ovest_sogliata'])
assignin('base','sud_ovest_sogliata',sud_ovest)

nord_finale=0;

for i=1:size(nord_sogliata, 1) %righe
    for j=1:size(nord_sogliata, 2)
        if(nord_sogliata(i, j)==1000)
            nord_finale(i, j)=1000;
        else
            nord_finale(i, j)=nord_nonsogliata(i, j);
        end
    end
end

sud_finale=0;

for i=1:size(sud_sogliata, 1) %righe
    for j=1:size(sud_sogliata, 2)
        if(sud_sogliata(i, j)==1000)
            sud_finale(i, j)=1000;
        else
            sud_finale(i, j)=sud_nonsogliata(i, j);
        end
    end
end

est_finale=0;

for i=1:size(est_sogliata, 1) %righe
    for j=1:size(est_sogliata, 2)
        if(est_sogliata(i, j)==1000)
            est_finale(i, j)=1000;
        else
            est_finale(i, j)=est_nonsogliata(i, j);
        end
    end
end

ovest_finale=0;

for i=1:size(ovest_sogliata, 1) %righe
    for j=1:size(ovest_sogliata, 2)
        if(ovest_sogliata(i, j)==1000)
            ovest_finale(i, j)=1000;
        else
            ovest_finale(i, j)=ovest_nonsogliata(i, j);
        end
    end
end

nord_est_finale=0;

for i=1:size(nord_est_sogliata, 1) %righe
    for j=1:size(nord_est_sogliata, 2)
        if(nord_est_sogliata(i, j)==1000)
            nord_est_finale(i, j)=1000;
        else
            nord_est_finale(i, j)=nord_est_nonsogliata(i, j);
        end
    end
end

nord_ovest_finale=0;

for i=1:size(nord_ovest_sogliata, 1) %righe
    for j=1:size(nord_ovest_sogliata, 2)
        if(nord_ovest_sogliata(i, j)==1000)
            nord_ovest_finale(i, j)=1000;
        else
            nord_ovest_finale(i, j)=nord_ovest_nonsogliata(i, j);
        end
    end
end

sud_est_finale=0;

for i=1:size(sud_est_sogliata, 1) %righe
    for j=1:size(sud_est_sogliata, 2)
        if(sud_est_sogliata(i, j)==1000)
            sud_est_finale(i, j)=1000;
        else
            sud_est_finale(i, j)=sud_est_nonsogliata(i, j);
        end
    end
end

sud_ovest_finale=0;

for i=1:size(sud_ovest_sogliata, 1) %righe
    for j=1:size(sud_ovest_sogliata, 2)
        if(sud_ovest_sogliata(i, j)==1000)
            sud_ovest_finale(i, j)=1000;
        else
            sud_ovest_finale(i, j)=sud_ovest_nonsogliata(i, j);
        end
    end
end

save('C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\nord_finale', 'nord_finale');
save('C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\sud_finale', 'sud_finale');
save('C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\est_finale', 'est_finale');
save('C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\ovest_finale', 'ovest_finale');
save('C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\nord_est_finale', 'nord_est_finale');
save('C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\nord_ovest_finale', 'nord_ovest_finale');
save('C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\sud_est_finale', 'sud_est_finale');
save('C:\Users\Salvo\Desktop\Proseguimento_Articolo\CreaMappe\mappe_sogliate_terreno3\nuovo_metodo_CoopAsg_lungo\sud_ovest_finale', 'sud_ovest_finale');

