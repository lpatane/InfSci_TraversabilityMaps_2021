clear all
close all

%   KINEMATICS CHAIN PARAMETERS   %
l0=0.06;
l1=0.05;
l2=0.10;

steps=10;
delta_t=0.01;

%   STEP POINTS  %
aep=[0.03,0.11];
mid_stance=[0,0.12];
pep=[-0.03,0.11];
mid_flight=[0,0.10];

aep2=[0.015,0.11];
mid_stance2=[0,0.12];
pep2=[-0.015,0.11];
mid_flight2=[0,0.10];

%   DEBUG PLOTS    %
debug_info=0;
debug_info2=0;

[stance_steps,flight_steps] = robotStepTrajectory(aep,mid_stance,pep,mid_flight,steps,debug_info);
[stance_angles,flight_angles] = robotMotorTrajectorty(l0,l1,l2,stance_steps,flight_steps,debug_info2);






simulate(stance_angles,flight_angles);








function y = simulate(stance_angles,flight_angles)
	pause on;
	disp('Program started');
	vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
	vrep.simxFinish(-1); % just in case, close all opened connections
	clientID=vrep.simxStart('127.0.0.1',19997,true,true,5000,5);
% 	vrep.simxSynchronous(clientID,true);

	if (clientID>-1)
		disp('Connected to remote API server');
		vrep.simxSynchronous(clientID,true);	
        [res,motor1]=vrep.simxGetObjectHandle(clientID,'motor1',vrep.simx_opmode_oneshot_wait);
        [res,motor2]=vrep.simxGetObjectHandle(clientID,'motor2',vrep.simx_opmode_oneshot_wait);
        [res,motor3]=vrep.simxGetObjectHandle(clientID,'motor3',vrep.simx_opmode_oneshot_wait);
        [res,motor4]=vrep.simxGetObjectHandle(clientID,'motor4',vrep.simx_opmode_oneshot_wait);
        [res,motor1b]=vrep.simxGetObjectHandle(clientID,'motor1b',vrep.simx_opmode_oneshot_wait);
        [res,motor2b]=vrep.simxGetObjectHandle(clientID,'motor2b',vrep.simx_opmode_oneshot_wait);
        [res,motor3b]=vrep.simxGetObjectHandle(clientID,'motor3b',vrep.simx_opmode_oneshot_wait);
        [res,motor4b]=vrep.simxGetObjectHandle(clientID,'motor4b',vrep.simx_opmode_oneshot_wait);
        vrep.simxSetJointTargetPosition(clientID,motor1,stance_angles(1,1),vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor2,stance_angles(1,2),vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor3b,stance_angles(1,1),vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor4b,stance_angles(1,2),vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor3,flight_angles(1,1),vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor4,flight_angles(1,2),vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor1b,flight_angles(1,1),vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor2b,flight_angles(1,2),vrep.simx_opmode_oneshot);

        vrep.simxSynchronousTrigger(clientID);

%         pause();  

        %%%%%%%%%%%%%%%%%%%%%%%%
        for k=1:40
            for i=1:length(stance_angles)
                vrep.simxSetJointTargetPosition(clientID,motor1,stance_angles(i,1),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor2,stance_angles(i,2),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor3b,stance_angles(i,1),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor4b,stance_angles(i,2),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor3,flight_angles(i,1),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor4,flight_angles(i,2),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor1b,flight_angles(i,1),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor2b,flight_angles(i,2),vrep.simx_opmode_oneshot);
                vrep.simxSynchronousTrigger(clientID);

            end
            for i=1:length(flight_angles)
                vrep.simxSetJointTargetPosition(clientID,motor1,flight_angles(i,1),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor2,flight_angles(i,2),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor3b,flight_angles(i,1),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor4b,flight_angles(i,2),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor3,stance_angles(i,1),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor4,stance_angles(i,2),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor1b,stance_angles(i,1),vrep.simx_opmode_oneshot);
                vrep.simxSetJointTargetPosition(clientID,motor2b,stance_angles(i,2),vrep.simx_opmode_oneshot);
                vrep.simxSynchronousTrigger(clientID);
            end
        end   
        
        vrep.simxSetJointTargetPosition(clientID,motor2,pi/4,vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor1,3*pi/4,vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor4b,pi/4,vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor3b,3*pi/4,vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor4,pi/4,vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor3,3*pi/4,vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor2b,pi/4,vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetPosition(clientID,motor1b,3*pi/4,vrep.simx_opmode_oneshot);
        vrep.simxSynchronousTrigger(clientID);
        %%%%%%%%%%%%%%%
        vrep.simxGetPingTime(clientID);
        vrep.simxFinish(clientID);
	else
		disp('Failed connecting to remote API server');
    end
	vrep.delete();	
	disp('Program ended');
    y=clientID;      
end
