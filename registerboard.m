% This registers a new PCB board to be ready for manufacture
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
        

disp('Finding board BOM (Altium)...')
[file,path] = uigetfile('*.*');
board = readtable([path,file]);
clear file path

disp('Searching parts...')
boardparts = table;
notfound = table;
for i = 1:length(board.Comment)
    idx = find(strcmpi(T.PartNumber,board.Comment(i)),1);
    if(isempty(idx))
        idx = find(strcmpi(T.PartNumber,board.LibRef(i)),1);
        if(isempty(idx))
            notfound = [notfound;board(i,:)];
        else
            boardparts = [boardparts;board(i,:)];
        end
    else
        boardparts = [boardparts;board(i,:)];
    end
end
disp('Summary:')
disp([num2str(height(boardparts)),' part(s) found'])
disp(boardparts)
disp([num2str(height(notfound)),' part(s) not found'])
disp(notfound)
            
if(height(notfound) > 0)
    createpart = input('There are missing parts; would you like to create parts? (y/n) ','s');
    if(strcmpi(createpart,'y') || isempty(createpart))
        addparts;
        disp('Re-register board after all necessary parts are added')
    else
        disp('Register incomplete: inventory missing required parts')
    end
    clear createpart
else
    boardname = input('Enter name for board: ','s');
    writetable(boardparts,[boardname,'.xlsx'])
    disp('Board registered')
    clear boardname
end

clear board boardparts notfound idx i

