% This removes the part from the inventory
% Date: 20190719
% Author: Raymond Yang
% -------------------------------------------------------------------------

disp('Checking database existence...')
exist = who('T');
if(isempty(exist))
    disp('Database not found')
    clear exist
    return
else
    disp('Database found')
    clear exist
end

partnum = input('Enter part number to remove: ','s');
idx = strcmpi(T.PartNumber,partnum);
part = T(idx,:);
if(isempty(part))
    disp('Part not found')
    clear partnum idx part
    return
end

disp(part)
quantity = input('Enter quantity to remove: ','s');
quantity = str2double(quantity);

confirmation = input('Confirm? (y/n) ','s');
if(strcmpi(confirmation,'y') || isempty(confirmation))
    T.Qty(idx,1) = T.Qty(idx,1) - quantity;
    disp([num2str(quantity),' of part ',partnum,' removed'])
    if(T.Qty(idx,1) <= 0)
        disp('Warning: Insufficient parts')
        disp(T(idx,:))
        deletepart = input('Delete part entry from database? (y/n) ','s');
        if(strcmpi(deletepart,'y') || isempty(deletepart))
            T(idx,:) = [];
            disp('Entry deleted from database')
        end
        clear deletepart
    end
else
    disp('Nothing removed')
end
    
clear partnum idx part quantity confirmation
