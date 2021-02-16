classdef SimulationDriver
	properties(GetAccess = public, SetAccess = private)
		clientID		= [];																			% V-Rep connection identifier
		vrep			= [];																			% V-Rep object
		opMode			= [];																			% V-Rep operation mode
	end
	methods(Access = public)
        
		function this = SimulationDriver()
			this.vrep = remApi('remoteApi');
			this.vrep.simxFinish(-1);
			this.clientID	= this.vrep.simxStart('127.0.0.1',19997,true,true,5000,5);
			this.vrep.simxSynchronous(this.clientID,true);
			disp('Vrep initialized');
        end
        
       function [this]=OriRover(this)
            [erroreCode,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'Robotnik_Summit_XL',this.vrep.simx_opmode_oneshot_wait);
            this.vrep.simxPauseCommunication(this.clientID,1);
            this.vrep.simxSetObjectPosition(this.clientID,handle1,-1,[0 0 0],this.vrep.simx_opmode_oneshot);
            this.vrep.simxSetObjectOrientation(this.clientID,handle1,-1,[0 0 0],this.vrep.simx_opmode_oneshot);
            this.vrep.simxPauseCommunication(this.clientID,0);
       end 
       
       function [coppia_motore]=CoppiaMotore(this)
           
            [erroreCode,joint_back_left_wheel]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_left_wheel',this.vrep.simx_opmode_oneshot_wait);            
            [erroreCode,joint_back_right_wheel]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_right_wheel',this.vrep.simx_opmode_oneshot_wait);            
            [erroreCode,joint_front_left_wheel]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_left_wheel',this.vrep.simx_opmode_oneshot_wait);            
            [erroreCode,joint_front_right_wheel]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_right_wheel',this.vrep.simx_opmode_oneshot_wait);
           
            [erroreCode, coppia_back_left_wheel]=this.vrep.simxGetJointForce(this.clientID, joint_back_left_wheel, this.vrep.simx_opmode_oneshot_wait); 
            [erroreCode, coppia_back_right_wheel]=this.vrep.simxGetJointForce(this.clientID, joint_back_right_wheel, this.vrep.simx_opmode_oneshot_wait); 
            [erroreCode, coppia_front_left_wheel]=this.vrep.simxGetJointForce(this.clientID, joint_front_left_wheel, this.vrep.simx_opmode_oneshot_wait); 
            [erroreCode, coppia_front_right_wheel]=this.vrep.simxGetJointForce(this.clientID, joint_front_right_wheel, this.vrep.simx_opmode_oneshot_wait);
            
            coppia_motore=(coppia_back_left_wheel+coppia_back_right_wheel+coppia_front_left_wheel+coppia_front_right_wheel)/4;
       end

       function [indice_di_slip]=AngeLinVel_indice_di_slip(this)
            [erroreCode,corpo]=this.vrep.simxGetObjectHandle(this.clientID,'Robotnik_Summit_XL',this.vrep.simx_opmode_oneshot_wait);
            
            [erroreCode,back_left_wheel_visual]=this.vrep.simxGetObjectHandle(this.clientID,'back_left_wheel_visual',this.vrep.simx_opmode_oneshot_wait);            
            [erroreCode,back_right_wheel_visual]=this.vrep.simxGetObjectHandle(this.clientID,'back_right_wheel_visual',this.vrep.simx_opmode_oneshot_wait);            
            [erroreCode,front_left_wheel_visual]=this.vrep.simxGetObjectHandle(this.clientID,'front_left_wheel_visual',this.vrep.simx_opmode_oneshot_wait);            
            [erroreCode,front_right_wheel_visual]=this.vrep.simxGetObjectHandle(this.clientID,'front_right_wheel_visual',this.vrep.simx_opmode_oneshot_wait);            
            
            [erroreCode,linvel, angVelVector]=this.vrep.simxGetObjectVelocity(this.clientID, corpo, this.vrep.simx_opmode_oneshot_wait);
            
            [erroreCode,linvel_r1, angVelVector_r1]=this.vrep.simxGetObjectVelocity(this.clientID, back_left_wheel_visual, this.vrep.simx_opmode_oneshot_wait);
            [erroreCode,linvel_r2, angVelVector_r2]=this.vrep.simxGetObjectVelocity(this.clientID, back_right_wheel_visual, this.vrep.simx_opmode_oneshot_wait);
            [erroreCode,linvel_r3, angVelVector_r3]=this.vrep.simxGetObjectVelocity(this.clientID, front_left_wheel_visual, this.vrep.simx_opmode_oneshot_wait);
            [erroreCode,linvel_r4, angVelVector_r4]=this.vrep.simxGetObjectVelocity(this.clientID, front_right_wheel_visual, this.vrep.simx_opmode_oneshot_wait);

            velocitalineare_robot=sqrt(linvel(1).^2+linvel(2).^2+linvel(3).^2); %OK, formula verificata
                        
% %          velocitaangolare_r1=sqrt(angVelVector_r1(1).^2+angVelVector_r1(2).^2+angVelVector_r1(3).^2);  %OK, formula verificata

            velocitalineare_r1=sqrt(angVelVector_r1(1).^2+angVelVector_r1(2).^2+angVelVector_r1(3).^2)*0.10-0.04;  
            velocitalineare_r2=sqrt(angVelVector_r2(1).^2+angVelVector_r2(2).^2+angVelVector_r2(3).^2)*0.10-0.04; 
            velocitalineare_r3=sqrt(angVelVector_r3(1).^2+angVelVector_r3(2).^2+angVelVector_r3(3).^2)*0.10-0.04;
            velocitalineare_r4=sqrt(angVelVector_r4(1).^2+angVelVector_r4(2).^2+angVelVector_r4(3).^2)*0.10-0.04;

            media_velocitalineare_ruote=(velocitalineare_r1+velocitalineare_r2+velocitalineare_r3+velocitalineare_r4)/4;
            indice_di_slip=velocitalineare_robot/media_velocitalineare_ruote;
      
       end 
       
       function [velocitalineare_robot]=AngeLinVel_velocitalineare_robot(this)
            [erroreCode,corpo]=this.vrep.simxGetObjectHandle(this.clientID,'Robotnik_Summit_XL',this.vrep.simx_opmode_oneshot_wait);
            
            [erroreCode,back_left_wheel_visual]=this.vrep.simxGetObjectHandle(this.clientID,'back_left_wheel_visual',this.vrep.simx_opmode_oneshot_wait);            
            [erroreCode,back_right_wheel_visual]=this.vrep.simxGetObjectHandle(this.clientID,'back_right_wheel_visual',this.vrep.simx_opmode_oneshot_wait);            
            [erroreCode,front_left_wheel_visual]=this.vrep.simxGetObjectHandle(this.clientID,'front_left_wheel_visual',this.vrep.simx_opmode_oneshot_wait);            
            [erroreCode,front_right_wheel_visual]=this.vrep.simxGetObjectHandle(this.clientID,'front_right_wheel_visual',this.vrep.simx_opmode_oneshot_wait);            
            
            [erroreCode,linvel, angVelVector]=this.vrep.simxGetObjectVelocity(this.clientID, corpo, this.vrep.simx_opmode_oneshot_wait);
            
            [erroreCode,linvel_r1, angVelVector_r1]=this.vrep.simxGetObjectVelocity(this.clientID, back_left_wheel_visual, this.vrep.simx_opmode_oneshot_wait);
            [erroreCode,linvel_r2, angVelVector_r2]=this.vrep.simxGetObjectVelocity(this.clientID, back_right_wheel_visual, this.vrep.simx_opmode_oneshot_wait);
            [erroreCode,linvel_r3, angVelVector_r3]=this.vrep.simxGetObjectVelocity(this.clientID, front_left_wheel_visual, this.vrep.simx_opmode_oneshot_wait);
            [erroreCode,linvel_r4, angVelVector_r4]=this.vrep.simxGetObjectVelocity(this.clientID, front_right_wheel_visual, this.vrep.simx_opmode_oneshot_wait);

            velocitalineare_robot=sqrt(linvel(1).^2+linvel(2).^2+linvel(3).^2); %OK, formula verificata
                        
% %          velocitaangolare_r1=sqrt(angVelVector_r1(1).^2+angVelVector_r1(2).^2+angVelVector_r1(3).^2);  %OK, formula verificata

            velocitalineare_r1=sqrt(angVelVector_r1(1).^2+angVelVector_r1(2).^2+angVelVector_r1(3).^2)*0.10-0.04;  
            velocitalineare_r2=sqrt(angVelVector_r2(1).^2+angVelVector_r2(2).^2+angVelVector_r2(3).^2)*0.10-0.04; 
            velocitalineare_r3=sqrt(angVelVector_r3(1).^2+angVelVector_r3(2).^2+angVelVector_r3(3).^2)*0.10-0.04;
            velocitalineare_r4=sqrt(angVelVector_r4(1).^2+angVelVector_r4(2).^2+angVelVector_r4(3).^2)*0.10-0.04;

            media_velocitalineare_ruote=(velocitalineare_r1+velocitalineare_r2+velocitalineare_r3+velocitalineare_r4)/4;
            indice_di_slip=velocitalineare_robot/media_velocitalineare_ruote;
      
       end 

       
       function [this] = NoVel(this)

                [erroreCode,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle2]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_right_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle3]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle4]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_right_wheel',this.vrep.simx_opmode_oneshot_wait);          
                [errorCode1]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle1,0,this.vrep.simx_opmode_oneshot);
                [errorCode2]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle2,0,this.vrep.simx_opmode_oneshot);
                [errorCode3]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle3,0,this.vrep.simx_opmode_oneshot);
                [errorCode4]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle4,0,this.vrep.simx_opmode_oneshot);                
       end
       
       function [this] = RuotaDi90ADestra(this)

                [erroreCode,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle2]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_right_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle3]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle4]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_right_wheel',this.vrep.simx_opmode_oneshot_wait);          
                [errorCode1]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle1,8,this.vrep.simx_opmode_oneshot);
                [errorCode2]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle2,8,this.vrep.simx_opmode_oneshot);
                [errorCode3]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle3,8,this.vrep.simx_opmode_oneshot);
                [errorCode4]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle4,8,this.vrep.simx_opmode_oneshot);                
                  
                [erroreCode,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle2]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_right_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle3]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle4]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_right_wheel',this.vrep.simx_opmode_oneshot_wait);          
                [errorCode1]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle1,12,this.vrep.simx_opmode_oneshot);
                [errorCode2]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle2,-12,this.vrep.simx_opmode_oneshot);
                [errorCode3]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle3,12,this.vrep.simx_opmode_oneshot);
                [errorCode4]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle4,-12,this.vrep.simx_opmode_oneshot);                
                                  

       end
       
       function [this] = RuotaDi90ASinistra(this)
%                 [erroreCode,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'Robotnik_Summit_XL',this.vrep.simx_opmode_oneshot_wait);  
%                 [~,posei(4:6)]= this.vrep.simxGetObjectOrientation(this.clientID,handle1,-1,this.opMode);

%                 while diff~
                [erroreCode,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle2]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_right_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle3]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle4]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_right_wheel',this.vrep.simx_opmode_oneshot_wait);          
                [errorCode1]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle1,-12,this.vrep.simx_opmode_oneshot);
                [errorCode2]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle2,-12,this.vrep.simx_opmode_oneshot);
                [errorCode3]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle3,-12,this.vrep.simx_opmode_oneshot);
                [errorCode4]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle4,-12,this.vrep.simx_opmode_oneshot); 
                
%                 [~,posef(4:6)]= this.vrep.simxGetObjectOrientation(this.clientID,handle1,-1,this.opMode);
%                 
%                 diff=posei(1)-posef(1);

%                 pause(5)
                [erroreCode,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle2]=this.vrep.simxGetObjectHandle(this.clientID,'joint_back_right_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle3]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_left_wheel',this.vrep.simx_opmode_oneshot_wait);  
                [erroreCode,handle4]=this.vrep.simxGetObjectHandle(this.clientID,'joint_front_right_wheel',this.vrep.simx_opmode_oneshot_wait);          
                [errorCode1]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle1,0,this.vrep.simx_opmode_oneshot);
                [errorCode2]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle2,0,this.vrep.simx_opmode_oneshot);
                [errorCode3]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle3,0,this.vrep.simx_opmode_oneshot);
                [errorCode4]=this.vrep.simxSetJointTargetVelocity(this.clientID,handle4,0,this.vrep.simx_opmode_oneshot);                
                
       end
                
           function [accZ] = AccVar(this)
                      [erroreCode,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'Accelerometer_forceSensor',this.vrep.simx_opmode_oneshot_wait);  
                      [~,~,forceVector,~] = this.vrep.simxReadForceSensor(this.clientID,handle1,this.vrep.simx_opmode_streaming);
                      [e,rrr,forceVector,gg] = this.vrep.simxReadForceSensor(this.clientID,handle1,this.vrep.simx_opmode_buffer);  
                      accelVector = forceVector/1e-3;
                      accZ = accelVector(3);
           end
       
       function [this] = PosCuboid(this,posini, posfin, alfaAngle, betaAngle,gammaAngle)
            [~,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'Cuboid',this.vrep.simx_opmode_oneshot_wait); 
            this.vrep.simxSetObjectPosition(this.clientID,handle1,-1,[posfin(1) posfin(2) posfin(3)],this.vrep.simx_opmode_oneshot);

       end
       
       function [this] = PosRover(this, posini, alfaAngle, betaAngle,gammaAngle)
            [~,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'Robotnik_Summit_XL',this.vrep.simx_opmode_oneshot_wait);  
            this.vrep.simxSetObjectPosition(this.clientID,handle1,-1,[posini(1) posini(2) posini(3)],this.vrep.simx_opmode_oneshot);
            this.vrep.simxPauseCommunication(this.clientID,1);
            this.vrep.simxSetObjectOrientation(this.clientID,handle1,-1,[alfaAngle betaAngle gammaAngle],this.vrep.simx_opmode_oneshot);
            this.vrep.simxPauseCommunication(this.clientID,0);  
             

       end
       
       
		function [this] = startSimulation(this,robot)
			this.vrep.simxStartSimulation(this.clientID,this.vrep.simx_opmode_blocking);
			this.opMode = this.vrep.simx_opmode_streaming;
			this		= this.initTransmission(robot);
		end
		
		function [this] = initTransmission(this,robot)
			this.getCurrentPose(robot);
			this.opMode		= this.vrep.simx_opmode_buffer;
			this.vrep.simxSynchronousTrigger(this.clientID);
			disp('Transmission initialized');
		end
		
		function [propertyID] = getHandlers(this,property)
			r=0;
			propertyID = zeros(size(property,1),size(property,2));
			for i = 1:size(property,1)
				for j = 1:size(property,2)
					object = cell2mat(property(i,j));
					[ret,propertyID(i,j)]= ...
						this.vrep.simxGetObjectHandle(this.clientID,object,this.vrep.simx_opmode_blocking);
					r = r + ret;
				end
            end

			if(r > 0)
				error('ERROR ON GETTING PROPERTY HANDLERS');
			end
        end
		
		function [jointsPosition] = getJointPosition(this,handlers)
			r=0;
			jointsPosition = zeros(size(handlers));
			for i=1:size(handlers,1)
				for j=1:size(handlers,2)
					[ret,jointsPosition(i,j)] = this.vrep.simxGetJointPosition(this.clientID,handlers(i,j),this.opMode);
					r = r + ret;
				end
			end
		end
		
		function setJointForce(this,handler,force)
			for i = 1:size(handler,1)
				for j = 1:size(handler,2)
					this.vrep.simxSetJointForce(this.clientID,handler(i,j),force(i,j),this.vrep.simx_opmode_oneshot);
				end
			end
		end
		
		function [force] = getJointForce(this,handlers)
			force = zeros(size(handlers,2),3);
			for i=1:size(handlers,2)
					[~,~,force(i,:)] = this.vrep.simxReadForceSensor(this.clientID,handlers(i),this.opMode);
			end
		end
		
		function [pose] = getCurrentPose(this,body)
			pose = zeros(1,6);
			[~,pose(1:3)] = this.vrep.simxGetObjectPosition(this.clientID,body,-1,this.opMode);
            [~,pose(4:6)]= this.vrep.simxGetObjectOrientation(this.clientID,body,-1,this.opMode);
		end
		
		function setJointVelocity(this,legsID,speed)
			for i=1:size(speed,1)
				for j=1:size(speed,2)
					this.vrep.simxSetJointTargetVelocity(this.clientID,legsID(i,j),speed(i,j),this.vrep.simx_opmode_oneshot);
%                     if legsID(i,j)==27
%                         this.vrep.simxSetJointTargetVelocity(this.clientID,23,speed(i,j),this.vrep.simx_opmode_oneshot);			
%                     end                    
%                     if legsID(i,j)==26
%                         this.vrep.simxSetJointTargetVelocity(this.clientID,22,speed(i,j),this.vrep.simx_opmode_oneshot);			
%                     end
%                     if legsID(i,j)==29
%                         this.vrep.simxSetJointTargetVelocity(this.clientID,24,speed(i,j),this.vrep.simx_opmode_oneshot);			
%                     end
%                     if legsID(i,j)==28
%                         this.vrep.simxSetJointTargetVelocity(this.clientID,25,speed(i,j),this.vrep.simx_opmode_oneshot);			
%                     end
                    
                end
			end
        end
        
        function [detectionState]=ReadProximity(this)
                [erroreCode1,handle]=this.vrep.simxGetObjectHandle(this.clientID,'Proximity_sensor',this.vrep.simx_opmode_oneshot_wait);  
            	[returnCode2, ~,~, ~, ~]=this.vrep.simxReadProximitySensor(this.clientID,handle,this.vrep.simx_opmode_streaming);
                [returnCode3, detectionState,~, ~, ~]=this.vrep.simxReadProximitySensor(this.clientID,handle,this.vrep.simx_opmode_buffer); 
        end
		
		function triggerNextStep(this)
			this.vrep.simxSynchronousTrigger(this.clientID);
%             [erroreCode,handle1]=this.vrep.simxGetObjectHandle(this.clientID,'Robotnik_Summit_XL',this.vrep.simx_opmode_oneshot_wait);
%             this.vrep.simxSetObjectOrientation(this.clientID,handle1,-1,[0 0 -90],this.vrep.simx_opmode_oneshot);

            
		end
		
		function finishSimulation(this)
			this.vrep.simxStopSimulation(this.clientID,this.vrep.simx_opmode_blocking);
			this.vrep.simxFinish(this.clientID);
			%this.vrep.delete();
            disp('Goal Reached');
		end
	end
end