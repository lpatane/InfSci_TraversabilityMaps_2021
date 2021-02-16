%definsco la classe rover
classdef Rover
	properties(GetAccess = public, SetAccess = private)
		x			= [];  									%indica la posizione del robot, ovvero coordinate x e y
        x1			= [];  									%indica la posizione del robot, ovvero coordinate x e y
		phi			= [];  									%angolo che il robot forma con l'asse x
		phi1        = [];
        v			= [];  									%velocità lineare del robot
		w			= [];  									%velocità angolare del robot
		dt			= [];  									%istante di tempo
		fig			= [];  									%figura rappresentante il robot(?)
		sensorsPos	= [];  									%classe per i sensori di prossimità 	
		planner		= [];  									%elemento che pianifica il percorso ottimale che il robot deve seguire
		driver		= [];  									%elemnto che si occupa di far muovere il robot,comanda le ruote
		bodyID		= [];  									%classe che contiene l'id del robot
		wheelID		= [];  									%classe che continene gli ID delle ruote del robot
    end
    
	%inizializzo il rover 
    
	methods(Access = public)
		function [this] = Rover(planner, driver, robot,dt)
			this.v			= 0;   
			this.w			= 0;   
			this.dt			= dt;  
			this.planner	= planner; 
 			this.driver		= driver;  
			this.sensorsPos	= [0 -.14 .14; .2 0 0];
			this.wheelID	= this.driver.getHandlers(robot.wheels);
			this.bodyID		= this.driver.getHandlers(robot.body);
			this.driver.setJointVelocity(this.wheelID,[0 0]);
			this.driver		= this.driver.startSimulation(this.bodyID);
			this			= this.getCurrentPose();
        end
		
        %funzione calcolo prossimo passo 
		function [ this ] = nextStep(this)
			[this.planner, control_signals ] = ...
				this.planner.nextStep(this.x(:,end),this.phi(end));
			this	= this.evalDynamics(control_signals);
		    this.driver.triggerNextStep();
			this    = this.getCurrentPose();
			this	= this.getVelocity();
			set(0,'CurrentFigure',this.fig);
		end
		
		function [ this ] = evalDynamics(this, control_signals)
			for i = 1:size(control_signals,1)
				this.driver.setJointVelocity( this.wheelID(i),control_signals(i));
			end
		end
		
		function [ this ] = getVelocity(this)
				this.v(end+1) = norm( this.x(:,end) - this.x(:,end-1) )/this.dt;
				this.w(end+1) = norm( this.phi(:,end) - this.phi(:,end-1) )/this.dt;
        end
		
        %funzione posizione corrente
		function [ this ] = getCurrentPose(this)
			pose		= this.driver.getCurrentPose(this.bodyID);
			this.x		= [ this.x, pose(1:2)'];
            this.x1        = [pose(3)];
			this.phi	= [ this.phi, pose(6)];
            this.phi1   = [pose(4), pose(5), pose(6)];
        end
        
        function [condition] = isGoalReached(this)
			dist	= norm( this.x(:,end) - this.planner.x_goal);
		if dist < 0.3                  %considera l'obiettivo raggiunto se è ad una distanza massima di 50 cm
				condition	= true;
            else
				condition	= false;
        end
            
        end
    end
end
		%condizione goalreached
% 		function [condition] = isGoalReached(this)
% % 			dist	= norm( this.x(:,end) - this.planner.x_goal);
%             arrived = this.driver.ReadProximity();
% %             if dist < distogoal                  %considera l'obiettivo raggiunto se è ad una distanza massima di 50 cm
%               if arrived == true;
% 				condition	= true;
%             else
% 				condition	= false;
%             end    
%         end
%     end
% end