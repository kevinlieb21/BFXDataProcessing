function [blockArray] = BFXResizeBlocks(inputArray, newBlockSize)
%BFXResizeBlocks takes the array of blocks from BFXAnalyzeBIN and converts
%them to a resized array of blocks.
%   inputArray should have a shape of oldBlockSize rows by nMics columns by
%   nBlocks layers. newBlockSize must be a power of 2.



tempArray = zeros(size(inputArray,1)*size(inputArray,3), size(inputArray,2));
for i=0:1:size(inputArray,3)-1
    tempArray((i*size(inputArray,1)+1):((i+1)*size(inputArray,1)), :) = inputArray(:,:,i+1);   
end
if mod(size(tempArray, 1), newBlockSize) ~= 0
    tempArray = tempArray(1:end-mod(size(tempArray, 1), newBlockSize), :);
end
blockArray = zeros(newBlockSize, size(inputArray,2), size(tempArray, 1)/newBlockSize);
for i=0:1:(size(tempArray, 1)/newBlockSize)-1
    blockArray(:,:,i+1) = tempArray((i*newBlockSize)+1:((i+1)*newBlockSize), :);
end