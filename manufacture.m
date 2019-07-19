% This is the manufacture step which removes the used componenets
% Note that a board must be registered first before manufacturing
% Date: 20190719
% Author: Raymond Yang
% -------------------------------------------------------------------------

% suppress warning
warning('off','MATLAB:table:ModifiedAndSavedVarnames')

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

disp('Select board parts: ')
[file,path] = uigetfile('*.*');
boardparts = readtable([path file]);
clear file path

disp('Verifying table format...')
for i = 1:7
    if(strcmpi(boardparts.Properties.VariableNames{1:i},T.Properties.VariableNames{1:i}))
        continue
    else
        disp(['Incorrect order of category: ',T.Properties.VariableNames{1:i}])
        return
    end
end

disp('The manufacture will require: ')
disp(boardparts)
confirmation = input('Confirm the manufacture? (y/n) ','s');

if(strcmpi(confirmation,'y') || isempty(confirmation))    
    disp('Removing parts used...')
    for i = 1:height(boardparts)
        partnum = boardparts.PartNumber{i,1};
        partqty = boardparts.Qty(i,1);
        T.Qty(strcmpi(T.PartNumber,partnum),:) = T.Qty(strcmpi(T.PartNumber,partnum),:) - partqty;
    end
    disp('Completed')
    clear partnum partqty
else
    disp('Manufacture terminated')
end

clear boardparts i confirmation