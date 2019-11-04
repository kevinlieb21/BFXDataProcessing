# BFXDataProcessing
Code for batch processing OptiNav BeamFormX data files

 BFXAnalyzeBINv2.m is a MATLAB processing script to import time series data
 from all 40 microphones on the ACAM 120 beamforming array,  with a binary
 data file produced by OptiNav BeamFormX software.

 The script is a work in progress, and results are not guaranteed to be
 accurate. 

 To run properly, the script needs the following functions in the MATLAB path:
 BFXArrayCalibration.m
 BFXDataImport.m
 BFXDataProcessing.m
 BFXDataReshape.m
 BFXExcelExport.m
 BFXPlotter.m
 BFXReadXMLheader.m 
 BFXResizeBlocks.m
 RemoveSheet123.m (Written by Noam Greenboim)

To use array calibration, ArrayResponse.csv must also be present in the MATLAB path.


 Written by Kevin Lieb at MAESTRO Laboratory, Texas A&M University.
 Revision Date: November 4, 2019

 All controls are present in BFXAnalyzeBINv2.m. It should not be necessary to modify any other files during operation.
