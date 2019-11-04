% BFXAnalyzeBIN.m is a MATLAB processing script to import time series data
% from all 40 microphones on the ACAM 120 beamforming array,  with a binary
% data file produced by OptiNav BeamFormX software.
%
% The script is a work in progress, and results are not guaranteed to be
% accurate. 
%
% To run properly, the script needs the following functions in the MATLAB path:
% BFXDataImport.m
% BFXDataProcessing.m
% BFXDataReshape.m
% BFXExcelExport.m
% BFXPlotter.m
% BFXReadXMLheader.m 
% BFXResizeBlocks.m
% RemoveSheet123.m (Written by Noam Greenboim)


% Written by Kevin Lieb at MAESTRO Laboratory, Texas A&M University.
% Revision Date: November 4, 2019

% To use the software, set control values in the Initial Setup Values
% section. This includes the desired output type (applies to both Excel and
% plotting outputs), mic number for single mic analysis, transform length
% for the FFT, and output controls. 

clear;
clc;
close all;
controlData = table();
%% Initial Setup Values

% CRM Acoustic Averaging
controlData.OASPL = 0;
controlData.minFreq = 1000;
controlData.maxFreq = 20000;

% Output Type - choose 'SPL' for amplitude spectrum, 'PSD' for power
% spectral density.
controlData.outputType = 'SPL';

% Microphone number for single mic analysis
controlData.micNumber = 18;

% Desired transform length for computation
controlData.transformLength = 2048;

% Excel Output Controls
controlData.excelSingleMic = 1;
controlData.excelAllMics = 0;

% Plotting Controls
controlData.plotSpectrogram = 0;
controlData.plotSingleMic = 0;
controlData.plotAllMics = 0;
controlData.savePlots = 1;
controlData.plotSize = [0 20000 0 70];
controlData.format = '.fig';

% Calibration Controls
controlData.calibrationFilename = 'ArrayResponse.csv';
controlData.calibrate = 0;

%% Load Data
DataMatrix = BFXDataImport();
DataMatrix = BFXDataReshape(DataMatrix);

%% DATA PROCESSING

OutputMatrix = BFXDataProcessing(DataMatrix, controlData);

%% Plotting

BFXPlotter(OutputMatrix, DataMatrix, controlData)

%% Excel Output

BFXExcelExport(OutputMatrix, controlData);



