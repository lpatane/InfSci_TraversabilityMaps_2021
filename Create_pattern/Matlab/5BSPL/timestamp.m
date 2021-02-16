function  [millisecondi]=timestamp

    a = datetime;
    millisecondi = second(a);

end

% function  [millisecondi]=timestamp
% 
%     a = datetime('now','convertfrom','posixtime', 'Format', 'yyyy-MM-dd HH:mm:ss.SSS');
%     millisecondi = second(a);
% 
% end