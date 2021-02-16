function [stance_angles,flight_angles] = robotMotorTrajectorty(l0,l1,l2,stance_steps,flight_steps,debug_info)
    j=1;
    if debug_info==1
        figure
    end
    for i=1:length(stance_steps.x)
        [theta_a1, theta_a2] = robotIK(l0/2,l1,l2,stance_steps.x(i),stance_steps.y(i));
        stance_angles(i,1)=theta_a1;
        stance_angles(i,2)=theta_a2;
        total_angles(j,1)=theta_a1;
        total_angles(j,2)=theta_a2;
        j=j+1;
        [xc,yc ] = robotDK(l0,l1,l2,theta_a1,theta_a2);
        if debug_info==1
            hold on
            plot(xc,yc,'or');
        end
    end
    for i=1:length(flight_steps.x)
        [theta_a1, theta_a2] = robotIK(l0/2,l1,l2,flight_steps.x(i),flight_steps.y(i));
        flight_angles(i,1)=theta_a1;
        flight_angles(i,2)=theta_a2;
        total_angles(j,1)=theta_a1;
        total_angles(j,2)=theta_a2;
        j=j+1;
        [xc,yc ] = robotDK(l0,l1,l2,theta_a1,theta_a2);
        if debug_info==1
            hold on
            plot(xc,yc,'ob');
        end
    end
    if debug_info==1
        set(gca, 'YDir','reverse')
        set(gca, 'XDir','reverse')
        title("Reconstructed leg space trajectory");
        figure
        subplot(2,1,1),plot((total_angles(:,1)*180/pi)),title('M1 angles'),xlabel("time"),ylabel("degrees");
        subplot(2,1,2),plot((total_angles(:,2)*180/pi)),title('M2 angles'),xlabel("time"),ylabel("degrees");
    end
end
