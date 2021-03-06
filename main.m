% Allows access to functions
% Date: 20200318
% Author: Raymond Yang
% -------------------------------------------------------------------------

exit_ = 0;
while(exit_ == 0)
    option = menu('SMD Inventory',...
        'Initialize',...
        'Status',...
        'Find parts',...
        'Add parts',...
        'Backup',...
        'Remove parts',...
        'Manufacture',...
        'Register board',...
        'Clear',...
        'Exit');

    switch option
        case 1
            initialize;
            exit_ = 0;
            continue
        case 2
            status
            exit_ = 0;
            continue
        case 3
            findpart
            exit_ = 0;
            continue
        case 4
            addparts
            exit_ = 0;
            continue
        case 5
            backup
            exit_ = 0;
            continue
        case 6
            rmpart
            exit_ = 0;
            continue
        case 7
            manufacture
            exit_ = 0;
            continue
        case 8
            registerboard
            exit_ = 0;
            continue
        case 9
            clear
            exit_ = 0;
            continue
        case 10
            exit_ = 1;
    end
end

clear option exit_
