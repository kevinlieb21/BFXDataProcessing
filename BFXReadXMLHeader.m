function [fileInfo] = BFXReadXMLHeader(filename)
% Parses data from XML header of BFX binary files. Retreives filename,
% start location of data, block size, FPS, video resolution, and sample
% rate.
fileInfo = table();
fid = fopen(filename);
a = fread(fid, 600, '*char');
fclose(fid);
a = a';
stopindex = strfind(a, '</entry>');

fileInfo.fileName = filename(1:end-4);
fileInfo.readLoc = str2double(a(1:3)) + 4;

index = strfind(a, '<entry key="data.theBlockSize">') + 31;
stop = stopindex(find(stopindex>index, 1))-1; 
fileInfo.blockSize = str2double(a(index:stop));

index = strfind(a, '<entry key="data.framesPerSecond">') + 34;
stop = stopindex(find(stopindex>index, 1))-1; 
fileInfo.fps = str2double(a(index:stop));

index = strfind(a, '<entry key="data.width">') + 24;
stop = stopindex(find(stopindex>index, 1))-1; 
width = str2double(a(index:stop));

index = strfind(a, '<entry key="data.height">') + 25;
stop = stopindex(find(stopindex>index, 1))-1; 
height = str2double(a(index:stop));

index = strfind(a, '<entry key="data.theSampleRate">') + 32;
stop = stopindex(find(stopindex>index, 1))-1; 
fileInfo.sampleRate = str2double(a(index:stop));

fileInfo.videoRes = width*height;
end


