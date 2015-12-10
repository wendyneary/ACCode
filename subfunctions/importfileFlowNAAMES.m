function [Date1,Time1,ValveState,Flow1] = importfileFlowNAAMES(filename, startRow, endRow)
%IMPORTFILE1 Import numeric data from a text file as column vectors.
%   [DATE1,TIME1,VALVESTATE,FLOW1] = IMPORTFILE1(FILENAME) Reads data from
%   text file FILENAME for the default selection.
%
%   [DATE1,TIME1,VALVESTATE,FLOW1] = IMPORTFILE1(FILENAME, STARTROW,
%   ENDROW) Reads data from rows STARTROW through ENDROW of text file
%   FILENAME.
%
% Example:
%   [Date1,Time1,ValveState,Flow1] = importfile1('Flow_201531016.log',1,
%   3514);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2015/11/19 04:41:51

%% Initialize variables.
delimiter = {'\t',' '};
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% Format string for each line of text:
%   column1: text (%s)
%	column2: text (%s)
%   column4: double (%f)
%	column7: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%*s%f%*s%*s%f%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
Date1 = dataArray{:, 1};
Time1 = dataArray{:, 2};
ValveState = dataArray{:, 3};
Flow1 = dataArray{:, 4};

%debug:
Date1
Time1
size(Date1)
size(Time1)
size(ValveState)
size(Flow1)

