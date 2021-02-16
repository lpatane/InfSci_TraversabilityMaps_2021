%classe per convertire i segnali di controlli in segnali per le ruote 

classdef Converter
	properties(SetAccess = public, GetAccess = public)						% variabili da usare in caso si vogliano impostare i valori del di R  vr vl
		R	= [];
		L	= [];		
		vr	= [];
		vl	= [];
	end
	
	methods( Access = public )												%serve per convertire il segnale che ci viene dato, a segnale per le ruote 
		function [ this ] = Converter(R,L)
			this.R	= R;
			this.L	= L;
		end
		
		function [ this, control_signals ] = convertState(this,v,w)
% 			this.vr	= [ this.vr, ( 2*v + w*this.L )/( 2*this.R ) ];
% 			this.vl = [ this.vl, ( 2*v - w*this.L )/( 2*this.R ) ];
            this.vr = 70;
            this.vl = 70;
% 			control_signals = [ -this.vr(end); -this.vl(end)]/40			%divido per 20 perchè il segnale di controllo è dato dal contributo di 																		%entrambe le ruote che hanno un guadagno K=10, per cui K*2=20			
%             control_signals = [ this.vl(end); -this.vr(end); this.vl(end); -this.vr(end)]/40;			%divido per 20 perchè il segnale di controllo è dato dal contributo di 																		%entrambe le ruote che hanno un guadagno K=10, per cui K*2=20			
            control_signals = [ this.vl(end); -this.vl(end); this.vl(end); -this.vl(end);]/40;			%divido per 20 perchè il segnale di controllo è dato dal contributo di 																		%entrambe le ruote che hanno un guadagno K=10, per cui K*2=20			

        end
	end	
end
