# InfSci_TraversabilityMaps_2021
Additional material related to the paper: Learning risk-mediated traversability maps in unstructured terrains navigation through robot-oriented models

The software requirements are: Matlab 2020b and CoppeliaSim dynamic simulator from CoppeliaRobotics (https://www.coppeliarobotics.com/)

Guidelines to properly use the scripts:

-How to create the datasets used for the traversability maps
1) Go to ".\Create_pattern\CoppeliaSim" and open a CoppeliaSim simulation related to the robot and terrain you are interested.
2) Go to ".\Create_pattern\Matlab" and choose the robot directory.
3) Once selected the directory, you have to start Avvio.m
4) The output pattern is called "output.mat"

-How to create the traversability maps
1) Go to ".\Create_Maps" and open Genera_pattern.m. Here uncomment the terrain that you want to use and select the downsampling value.
2) Set the correct input pattern for the network in ".\Create_Maps\CreaOutputRete.m" on the first line.
3) Set the desired threshold value for the network in ".\Create_Maps\CreaMappe.m".
4) Go to ".\Create_Maps" and start Avvio.m.
5) The already available maps are stored in ".\Create_Maps\maps".

-How to find an optimal path
***For terrain 1 (simulations in Fig. 13).***
1) Go to ".\Optimal_path\terrain1" and choose a robot. Open the CoppeliaSim related to the specific robot architecture.
3) Start Avvio.m in the same directory. 
4) The robot in CoppeliaSim will follow the imposed path.
***For terrain 2 (simulations in Fig. 17).***
1) Go to ".\Optimal_path\terrain 2\ML method" and choose a robot. Open the CoppeliaSim related to the specific robot architecture.
3) Start Avvio.m in the same directory. 
4) The robot in CoppeliaSim will follow the imposed path.
***For terrain 2 (simulations in Fig. 18).***
1) Go to ".\Optimal_path\terrain 2\MR method" and choose a robot. Open the CoppeliaSim related to the specific robot architecture.
3) Start Avvio.m in the same directory. 
4) The robot in CoppeliaSim will follow the imposed path.

Videos associated to simulations described on the above mentioned manuscript

1)The videos related to terrain 1 (simulations in Fig. 13) are in .\Videos\terrain1

2)The videos related to terrain 2 (simulations in Fig. 17)) are in .\Videos\terrain2\ML

3)The videos related to terrain 2 (simulations in Fig. 18)) are in .\Videos\terrain2\MR
