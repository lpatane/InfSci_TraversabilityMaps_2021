classdef LowLevelPlanner
    
	properties(Constant)
		GTG		= 1;	%go to goal
		d		= 0.75;		% considera 30 cm dal robot
		eps		= 0.05;		%epsilon che ci permette di non fare on-off tra gli stati
    end
    
	properties(SetAccess = private,GetAccess = public)	
		dt		= [];
		u		= [];
		% posizione del goal
		x_goal	= [];
        % guadagno go to goal
		K_gtg	= [];
		tracker	= [];
		% stato corrente
		curr_state	= 1;   
		end
	
	methods(Access = public)
		function [ this ] = LowLevelPlanner(tracker,dt)
			this.tracker	= tracker;
			this.dt			= dt;
		end
		
		
		function [ this ] = setGoalPosition(this,goal)
			this.x_goal	= [ this.x_goal, goal ];
		end
		
		
		function [this, control_signals] = nextStep(this,x,phi)
			[ this, u_gtg ]		= this.evalGoToGoalController(x);
            
            %switcho per adattarmi 
switch (this.curr_state)
		%esegue il go to goal	
				case this.GTG
						u		= u_gtg;
						state	= this.GTG;
				end
				
			[ this.tracker, control_signals ]	=  this.tracker.evalSystem(phi,u);
			this.u			= [ this.u, u ];
			this.curr_state	= state; %imposta il prossimo stato
		end
	end
	
	methods(Access = private )
		
        %controllore per il behavior gotoGoal
		function [this, output ] = evalGoToGoalController(this,x)
			error				= this.x_goal(:,end) - x;
			this.K_gtg(end+1)	= this.setGTGGain(error);
			output				= this.K_gtg(end).*error;
        end			
	end
	
	methods(Static)
		
		function [ K ] = setGTGGain(error)
			v_0		= 10;
			a		= 5;
			eps		= .001;
			abs_e	= norm(error);
			
			K	= v_0 * ( 1 - exp( -a*abs_e ) ) ./ ( abs_e + eps );
		end
	end	
end