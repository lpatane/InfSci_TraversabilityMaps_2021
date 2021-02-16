dt 				= 0.05;                   									% tempo di simulazione 											
% maximumTime		= 40; %tempi
maximumTime		= 120; %iterazioni

minimumTime		= 1.5;
n_downsaple		= 5;
percent 		= 0.4;
dimXVrep 		= 30.723;
dimYVrep 		= 42.685;
dimZVrep 		= 5.3;
clearence       = 1;
[T_intera, P]	= geotiffread('polo_pad.tif');
stats           = 1;
graph           = 0;
song            = 1;