function [x, y] = robotDK(l0,l1,l2,theta1,theta4)
    l4=l1;
    l3=l2;
    l5=l0;

    A=2*l3*l4*sin(theta4)-2*l1*l3*sin(theta1);
    B=2*l3*l5-2*l1*l3*cos(theta1)+2*l3*l4*cos(theta4);
    C=l1^2-l2^2+l3^2+l4^2+l5^2-2*l1*l4*sin(theta1)*sin(theta4)-2*l1*l5*cos(theta1)+2*l4*l5*cos(theta4)-2*l1*l4*cos(theta1)*cos(theta4);

    theta3=2*atan2(A+sqrt(A^2+B^2-C^2),B-C);
    theta2=asin((l3*sin(theta3)+l4*sin(theta4)-l1*sin(theta1))/l2);

    x=(l1*cos(theta1)+l2*cos(theta2))-l0/2;
    y=l1*sin(theta1)+l2*sin(theta2);
end