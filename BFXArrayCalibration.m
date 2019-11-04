function [calibratedData] = BFXArrayCalibration(freqs, dbData, controlData)
%BFXArrayCalibration compensates for nominal frequency response of the ACAM 120 beamforming array
if controlData.calibrate == 1
    ArrayResponse = readtable(controlData.calibrationFilename);
    ArrayResponse = table2array(ArrayResponse);
    InterpResponse = interp1(ArrayResponse(:,1), ArrayResponse(:,2), freqs, 'linear', 'extrap');
    calibratedData = dbData-InterpResponse;
else
    calibratedData = dbData;
end
end

