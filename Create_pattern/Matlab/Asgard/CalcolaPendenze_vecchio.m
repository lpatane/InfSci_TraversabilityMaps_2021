function[pendenza] = CalcolaPendenze(diff_h, cellDimension) 
    slope = diff_h/(cellDimension*5);     %calcolo il dislivello
    pendenza = atan(slope);  %ne faccio l'arcotangente per ricavare l'angolo
  %     slopeDegree = pendenza*180/pi;  %porto tutto in gradi. 
end
