% This initializes the inventory into Matlab
% Date: 20190719
% Author: Raymond Yang
% -------------------------------------------------------------------------

clear

% suppress warning
warning('off','MATLAB:table:ModifiedAndSavedVarnames')

disp('Initializing database...')

[file,path] = uigetfile('*.*');
T = readtable([path file]);

disp('Done')
clear file path
