function [stance_steps,flight_steps] = robotTrajectory(x1,x2,x3,x4,steps,debug_info)
Y=[x1(2);x2(2);x3(2)];
A=[x1(1)^2 x1(1) 1;x2(1)^2 x2(1) 1;x3(1)^2 x3(1) 1];
X=inv(A)*Y;
x=x1(1):(x3(1)-x1(1))/steps:x3(1);
Y=X(1)*x.^2+X(2)*x+X(3);

x_stance=x;
y_stance=Y;

Y=[x3(2);x4(2);x1(2)];
A=[x3(1)^2 x3(1) 1;x4(1)^2 x4(1) 1;x1(1)^2 x1(1) 1];
X=inv(A)*Y;
x=x3(1):(x1(1)-x3(1))/steps:x1(1);
Y=X(1)*x.^2+X(2)*x+X(3);

x_flight=x;
y_flight=Y;

if debug_info==1
    figure
    plot(x_stance,y_stance,'-r')
    hold on
    plot(x_flight,y_flight,'-b')
    xlabel("foot x position");
    ylabel("foot y position");
    title("Leg space trajectory");
    text(x1(1),x1(2), 'AEP')
    text(x2(1),x2(2), 'MID STANCE')
    text(x3(1),x3(2), 'PEP')
    text(x4(1),x4(2), 'MID FLIGHT')

    set(gca, 'YDir','reverse')
    set(gca, 'XDir','reverse')

     X = [0.5 0.4];
     Y = [0.5  0.5];
     annotation('arrow',X,Y);
     text(0.01,0.205, 'x')
     X = [0.5 0.5];
     Y = [0.5  0.4];
     annotation('arrow',X,Y);
     text(0.008,0.207, 'y')
end


stance_steps.x=x_stance;
stance_steps.y=y_stance;

flight_steps.x=x_flight;
flight_steps.y=y_flight;


end