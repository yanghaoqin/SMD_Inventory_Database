% This saves the current inventory as an xlsx file
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
    name = input('Enter name for backup: ','s');
    if(isempty(name))
        name = 'database';
    end 
    writetable(T,[name,'.xlsx'])
    disp('Backup complete')
    clear exist name
end