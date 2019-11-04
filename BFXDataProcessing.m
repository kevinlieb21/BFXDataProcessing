function [OutputMatrix] = BFXDataProcessing(DataMatrix, controlData)
% BFXDataProcessing - Converts raw time series data into PSD or amplitude
% spectrum data. 
OutputMatrix = cell(4,size(DataMatrix, 2));

for i = 1:1:size(DataMatrix, 2)
    fileInfo = DataMatrix{1,i};
    % Resize blocks to requested transform length
    if fileInfo.blockSize ~= controlData.transformLength
        DataMatrix{3,i} = BFXResizeBlocks(DataMatrix{3,i}, controlData.transformLength);
    end

    % Compute FFT of sound pressure data to convert to frequency domain
    Y = abs(fft(DataMatrix{3,i}, controlData.transformLength, 1))./controlData.transformLength;
    Y = Y(1:controlData.transformLength/2+1, :, :);
    % Convert to single-sided FFT in dB, generate frequencies of analysis 
    SPL = rms(Y, 3);
    SPL = 20.*log10(SPL./2e-5);

    % Compute frequencies
    frequencies = fileInfo.sampleRate*((0:controlData.transformLength/2)/controlData.transformLength)';
    
    % Calibrate array and generate calibrated pressures for OASPL
    SPL = BFXArrayCalibration(frequencies, SPL, controlData);
    SPLPressure = 2e-5*10.^(SPL./20);
    
    % Computation of SPG data
    SPG = 20.*log10(Y(:,controlData.micNumber, :)./2e-5);
    SPG = reshape(SPG, size(SPG,1), size(SPG, 3));
    SPG = BFXArrayCalibration(frequencies, SPG, controlData);
    
    % Compute PSD
    binWidth = fileInfo.sampleRate/controlData.transformLength;
    PSD = (Y.^2)./(binWidth);
    PSD = rms(PSD, 3);
    PSD = 10.*log10(PSD./((2e-5.^2)));
    
    % Calibrate PSD
    PSD = BFXArrayCalibration(frequencies, PSD, controlData);
    
    
    % Computation of overall SPL on specified range
    minindex = find(frequencies == controlData.minFreq);
    maxindex = find(frequencies == controlData.maxFreq);
    OASPL = 0; 
    for j = minindex+1:1:maxindex-1
        OASPL = OASPL + (SPLPressure(j, controlData.micNumber))^2;
    end 
    OASPL = OASPL + (SPLPressure(minindex,controlData.micNumber)^2)/2; 
    OASPL = OASPL + (SPLPressure(maxindex,controlData.micNumber)^2)/2;

    OASPL = 20*log10((sqrt(OASPL))/(2e-5));
    
    %Data output
    OutputMatrix{1,i} = fileInfo;
    OutputMatrix{2,i} = frequencies;
    OutputMatrix{3,i} = SPL;
    OutputMatrix{4,i} = PSD;
    OutputMatrix{5,i} = OASPL;
    OutputMatrix{6,i} = SPG;
    
end

