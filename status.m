% This displays the status of the inventory. The parts that are out are
% displayed in particular
% Date: 20190719
% Author: Raymond Yang
% -------------------------------------------------------------------------

exist = who('T');
if(isempty(exist))
    disp('Database not found')
    clear exist
    return
else
    disp('Database found')
    clear exist
end

disp('Checking status...')
colnum = find(strcmpi(T.Properties.VariableNames,'Qty'));
T = sortrows(T,colnum);
disp(T)
disp('Done')

lowqty = T(T.Qty <= 0,:);
if(height(lowqty) > 0)
    disp('Warning: Out of parts')
    disp(lowqty)
else
    disp('Status: Good')
end

clear colnum lowqty