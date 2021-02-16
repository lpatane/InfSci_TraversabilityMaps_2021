function [theta1,theta2] = robotIK(l0,l1,l2,x,y)
    alpha1=(acos((l1^2+(((l0+x)^2)+y^2)-l2^2)/(2*l1*sqrt((((l0+x)^2)+(y^2))))));
    alpha2=(acos((l1^2+(((l0-x)^2)+y^2)-l2^2)/(2*l1*sqrt((((l0-x)^2)+(y^2))))));
    beta1=atan2(y,(l0+x));
    beta2=atan2(y,(l0-x));

    theta1=beta1+alpha1;
    theta2=pi-beta2-alpha2;

end
