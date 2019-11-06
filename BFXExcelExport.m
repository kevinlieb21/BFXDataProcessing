function [] = BFXExcelExport(OutputMatrix, controlData)
%BFXExcelExport outputs data from BFXAnalyzeBINv2 to Excel files.

warning('off','MATLAB:xlswrite:AddSheet');
% Create string for output file
filestring = [controlData.outputType, '_TL', num2str(controlData.transformLength)];

if controlData.excelAllMics
    varstring = cell(1,41);
    varstring{1} = char('Frequency');
    for i=1:1:40
        varstring{i+1} = char(['M', num2str(i)]);
    end
    if size(OutputMatrix, 2) == 1
       fullfilename = [OutputMatrix{1,1}.fileName, '_', filestring, '_All.xlsx'];
    else
       fullfilename = ['Multi_', filestring, '_All.xlsx'];
    end
    for i = 1:1:size(OutputMatrix,2)
        if controlData.outputType == 'SPL'
            outputTable = array2table([OutputMatrix{2,i}, OutputMatrix{3,i}]);
        elseif controlData.outputType == 'PSD'
            outputTable = array2table([OutputMatrix{2,i}, OutputMatrix{4,i}]);
        end
        outputTable.Properties.VariableNames = varstring;
        
        writetable(outputTable, fullfilename, 'Sheet', OutputMatrix{1,i}.fileName);
    end
    RemoveSheet123(fullfilename);
end

if controlData.excelSingleMic
    clear outputTable varstring
    varstring = cell(1,size(OutputMatrix,2)+1);
    varstring{1} = char('Frequency');
    if size(OutputMatrix, 2) == 1
       fullfilename = [OutputMatrix{1,1}.fileName, '_', filestring, '_M', num2str(controlData.micNumber), '.xlsx'];
    else
       fullfilename = ['Multi_', filestring, '_M', num2str(controlData.micNumber), '.xlsx'];
    end
    outputTable(:,1) = array2table(OutputMatrix{2,1});
    for i = 1:1:size(OutputMatrix,2)
        varstring{i+1} = regexprep(OutputMatrix{1,i}.fileName, '( |\.)', '_');
        if ~isnan(str2double(varstring{i+1}(1)))
            varstring{i+1} = ['x', varstring{i+1}];
        end
        if controlData.outputType == 'SPL'
           outputTable(:,i+1) = array2table(OutputMatrix{3,i}(:,controlData.micNumber));
        elseif controlData.outputType == 'PSD'
           outputTable(:,i+1) = array2table(OutputMatrix{4,i}(:,controlData.micNumber));
        end
        
        
    end
    outputTable.Properties.VariableNames = varstring;
    writetable(outputTable, fullfilename)
end

if controlData.OASPL
    OAFileString = ['OASPL_', num2str(controlData.minFreq), '_', num2str(controlData.maxFreq), '_M', num2str(controlData.micNumber)];
    if size(OutputMatrix, 2) == 1
       fullfilename = [OutputMatrix{1,1}.fileName, '_', OAFileString '.xlsx'];
    else
       fullfilename = ['Multi_', OAFileString, '.xlsx'];
    end
    clear outputTable varstring
    
    for i = 1:1:size(OutputMatrix,2)
         varstring{i} = regexprep(OutputMatrix{1,i}.fileName, '( |\.)', '_');
        if ~isnan(str2double(varstring{i}(1)))
            varstring{i} = ['x', varstring{i}];
        end
        outputTable(1,i) = array2table(OutputMatrix{5,i});
    end
    
    outputTable.Properties.VariableNames = varstring;
    writetable(outputTable, fullfilename)

end

