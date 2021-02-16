classdef Tracker
	properties(SetAccess = public, GetAccess = public)													%è possibile che questi valori vengano modificati.
		v			= [];
		w			= [];
		Kp			= [];
		converter	= [];
		dt			= [];
		err			= 0;
	end
	
	methods(Access = public)		
		function [ this ] = Tracker( dt, converter, Kp )
			if nargin == 3																				%se il numero di argomenti che passo alla funzione == 3 ->ho passato Kp ;imposta il valore Kp
				this.Kp			= Kp;
			else
				this.Kp			= 10; 																	%valore standard del guadagno proporzionale
			end
			this.converter	= converter;
			this.dt				= dt;
		end
		
		function [ v, w ] = getControlSignals( this )													% imposta il segnale di controllo.
			v	= this.v;
			w	= this.w;
		end
		
		function [ this, control_signals ] = evalSystem( this, phi, u)
			phi_d			= atan2( u(2), u(1) );														% arcotangente a 4 quadranti dei valori in input -> trovo l'angolo desiderato
			phi				= atan2(sin(phi),cos(phi));													% arcotangente a 4 quadranti dei valori sin e cos -> trovo l'angolo attuale
			e				= phi_d - phi;																% errore->di qunti si deve girare(informazione relativo all'angolo di cui si deve spostare)
			this.err(end)	= atan2(sin(e),cos(e)); 													% serve per evitare che l'errore vada oltre un certo angolo
			this 			= this.setGain();
			this.v			= [ this.v, norm( u )];														% aggiorno il valore di this.v
			this.w			= [ this.w, this.Kp * this.err(end)]; 										% aggiorno il valore di this.w
			
 			[ this.converter, control_signals ]	= this.converter.convertState(this.v(end),this.w(end));	% passa v e w come converter e signal_control
		end		
	end
	
																										%setto il valore di k in modo inversamente proporzionale alla vicinanza
																										%dal punto da raggiungere: più mi trovo vicino al prossimo punto da
																										%raggiungere più devo cercare di rallentare.
	methods(Access = private)
		function [ this ] = setGain(this)
			v_0		= 20;
			a		= 1;
			eps		= .001;
			abs_e	= norm(this.err(end));
			 
			this.Kp	= v_0 * ( 1 - exp( -a*abs_e ) ) ./ ( abs_e + eps );
		end
	end
end

