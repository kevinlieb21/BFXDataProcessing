function [DataMatrix, controlData] = BFXDataImport(controlData)
%Imports data from n data files into a 2xn cell array.
%   File info is stored in row 1, raw data is stored in row 2. Data must be
%   processed using BFXDataPreProcess.m
filenames = uigetfile('*.bin','INPUT DATA FILE(s)', 'MultiSelect', 'on');
if ~iscell(filenames)
    filenames = {filenames};
end
controlData.numFiles = numel(filenames);
DataMatrix = cell(2, controlData.numFiles);

for i = 1:1:controlData.numFiles
        fileInfo = BFXReadXMLHeader(filenames{i});
        fileID = fopen(filenames{i});
        fseek(fileID, fileInfo.readLoc, 'bof');
        RawData = fread(fileID, inf, 'int32', 'ieee-be');
        RawData = int32(RawData./256);
        fclose(fileID);
        DataMatrix{1,i} = fileInfo;
        DataMatrix{2,i} = RawData;
end
    
end

