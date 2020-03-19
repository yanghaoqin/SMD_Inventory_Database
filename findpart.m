% This checks a part status in inventory.
% Date: 20200319
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

defin = {''};
partfound = 0;
while(partfound == 0)
    
    prompt = {'Enter Part Number:'};
    dlgtitle = 'Find Parts';
    dims = [1 50];
    userin = inputdlg(prompt,dlgtitle,dims,defin);

    entry = userin';
    idx = strcmpi(T.PartNumber,entry{1,1});
    part = T(idx,:);
    if(isempty(part))
        disp('Part not found')
        defin = userin;
    else
        disp('Part found in database')
        display(part)        
        more = input('Find another part? (y/n) ','s');
        if(strcmpi(more,'y') || isempty(more))
            clear more
        else
            partfound = 1;
        end       
    end

end

clear partfound defin prompt dlgtitle dims userin entry idx part more exist