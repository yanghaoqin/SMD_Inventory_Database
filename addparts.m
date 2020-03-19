% This adds new parts into the inventory. If a part already exists, the
% quantity is increased
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

type = input('Would you like to import table or add manually? (i/m) ','s');
if(strcmpi(type,'i'))
    disp('Importing parts from table...')
    [file,path] = uigetfile('*.*');
    entry = readtable([path file]);
    clear type file path
    
    disp('Verifying table format...')
    if(length(entry.Properties.VariableNames) < 7)
        disp('Missing categories')
        return
    else
        found = find(strcmpi(entry.Properties.VariableNames,'Category'),1);
        if(isempty(found))
            disp('"Category" not found')
            clear found
            return
        end
        found = find(strcmpi(entry.Properties.VariableNames,'Value'),1);
        if(isempty(found))
            disp('"Value" not found')
            clear found
            return
        end
        found = find(strcmpi(entry.Properties.VariableNames,'PartNumber'),1);
        if(isempty(found))
            disp('"PartNumber" not found')
            clear found
            return
        end
        found = find(strcmpi(entry.Properties.VariableNames,'Manufacturer'),1);
        if(isempty(found))
            disp('"Manufacturer" not found')
            clear found
            return
        end
        found = find(strcmpi(entry.Properties.VariableNames,'Package'),1);
        if(isempty(found))
            disp('"Package" not found')
            clear found
            return
        end
        found = find(strcmpi(entry.Properties.VariableNames,'Qty'),1);
        if(isempty(found))
            disp('"Qty" not found')
            clear found
            return
        end
        found = find(strcmpi(entry.Properties.VariableNames,'Description'),1);
        if(isempty(found))
            disp('"Description" not found')
            clear found
            return
        end
    end
    
    disp('Verification complete')
    for i = 1:height(entry)
        partnum = entry.PartNumber{i,1};
        partqty = entry.Qty(i,1);
        idx = strcmpi(T.PartNumber,partnum);
        part = T(idx,:);
        if(isempty(part))
            newitem = {...
                entry(i,:).Category,...
                entry(i,:).Value,...
                entry(i,:).PartNumber,...
                entry(i,:).Manufacturer,...
                entry(i,:).Package,...
                entry(i,:).Qty,...
                entry(i,:).Description};
            T = [T;newitem];
            clear newitem;
        else
            T.Qty(idx,1) = T.Qty(idx,1) + partqty;
        end
    end
    
    disp('Part(s) added')
    clear i entry partnum partqty idx part
    return
else
    moreparts = 'y';
    defin = {'','','','','','',''};
    while(strcmpi(moreparts,'y'))
        prompt = {...
            'Enter Part Category:',...
            'Enter Part Value:',...
            'Enter Part Number:',...
            'Enter Part Manufacturer:',...
            'Enter Part Package:',...
            'Enter Part Qty:',...
            'Enter Part Description:'};
        dlgtitle = 'Manually Add Parts';
        dims = [1 50];
        userin = inputdlg(prompt,dlgtitle,dims,defin);
        
        entry = userin';
        entry{1,6} = str2double(entry{1,6});
        entry = cell2table(entry,'VariableNames',T.Properties.VariableNames);
        disp(entry)
        check = input('Is the information correctly entered? (y/n) ','s');
        if(strcmpi(check,'y') || isempty(check))
            idx = strcmpi(T.PartNumber,entry{1,3});
            part = T(idx,:);
            if(isempty(part))
                disp('New part created')
                T = [T;entry];
            else
                disp('Part found in database')
                T.Qty(idx,1) = T.Qty(idx,1) + entry{1,6};
            end
            
            disp('Part added')
            moreparts = input('Are there more parts? (y/n) ','s');
            if(isempty(moreparts))
                moreparts = 'y';
            end
            clear idx part
        else
            defin = userin;
        end
    end
    clear type defin userin moreparts check entry dims dlgtitle prompt
end
