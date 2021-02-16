function [NotReached, TooFast, Reached]=Statistica(matriceTempi)
    SimulationParameters
    [s1,s2] = size(matriceTempi);
    Time = reshape(matriceTempi,s1*s2,1);
    matriceTempi = size(Time);

    NotReached  = 0;
    TooFast     = 0;
    Reached     = 0;
    total       = 0;

    for i =1:1:matriceTempi
       if Time(i)==999
           NotReached = NotReached +1;
       elseif Time(i)==-1
           TooFast = TooFast +1;
       elseif (Time(i)<=maximumTime && Time(i)>=minimumTime)
           Reached = Reached +1;
       end
         total = total+1;
    end
    if TooFast == 0
        figure;
        title('Result Stats');
        pGraph = [Reached, NotReached];
        pie(pGraph);
        legend('Reached','Not Reached');
    else
        figure;
        title('Result Stats');
        pGraph = [Reached, NotReached, TooFast];
        pie(pGraph);
        legend('Reached','Not Reached','Too Fast/Fallen');
    end
end