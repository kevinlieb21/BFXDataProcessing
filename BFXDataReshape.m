function [DataMatrix] = BFXDataReshape(DataMatrix)
% Takes raw input data and organizes it by microphone and block for future processing 
for o = 1:1:size(DataMatrix, 2)
    blocksPerFrame = int32(DataMatrix{1,o}.sampleRate/(DataMatrix{1,o}.fps*DataMatrix{1,o}.blockSize));
    numFrames = int32(length(DataMatrix{2,o})/(DataMatrix{1,o}.blockSize*40*blocksPerFrame+2+DataMatrix{1,o}.videoRes));
    numBlocks = numFrames*blocksPerFrame;
    wholeBlockSize = 40*DataMatrix{1,o}.blockSize;
    acousticSize = blocksPerFrame*40*DataMatrix{1,o}.blockSize;
    otherSize = DataMatrix{1,o}.videoRes + 2 + acousticSize;
    
    RawMicData = zeros(DataMatrix{1,o}.blockSize*40*numFrames*blocksPerFrame,1);
   
    for i=0:1:numFrames-1
       RawMicData(i*acousticSize+1:(i+1)*acousticSize) = int32(DataMatrix{2,o}(i*otherSize+1:i*otherSize+acousticSize));        
    end
    tableData = zeros(DataMatrix{1,o}.blockSize, 40, numBlocks);
    for i = 0:1:numBlocks-1
        tableData(:,:,i+1) = reshape(RawMicData(i*wholeBlockSize+1:(i+1)*wholeBlockSize), DataMatrix{1,o}.blockSize, 40);
    end
    DataMatrix{3,o} = double(tableData.*(20/((2^23)-1)));
end



end

