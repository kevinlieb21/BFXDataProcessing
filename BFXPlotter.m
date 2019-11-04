function [] = BFXPlotter(OutputMatrix, DataMatrix, controlData)
%BFXPlotter generates plots of the requested data for BFXAnalyzeBINv2
for i=1:1:size(OutputMatrix,2)
    if controlData.plotSingleMic
        if controlData.outputType == 'SPL'
            % SPL amplitude spectrum
            figure;
            plot(OutputMatrix{2,i}, OutputMatrix{3,i}(:,controlData.micNumber));
            axis(controlData.plotSize);
            ax = gca;
            ax.XAxis.TickLabelFormat = '%g';
            ax.XAxis.Exponent = 0;
            xlabel('Frequency (Hz)'); ylabel('dB Re. 20uPa');
            titlestring = [OutputMatrix{1,i}.fileName, ' Mic ', num2str(controlData.micNumber), ' RMS Amplitude Spectrum at TL=', num2str(controlData.transformLength)];
            title(titlestring);
            if controlData.savePlots
                filestring = [OutputMatrix{1,i}.fileName, '_SPL_M', num2str(controlData.micNumber), '_TL', num2str(controlData.transformLength), controlData.format];
                saveas(gcf, filestring);
            end

        elseif controlData.outputType == 'PSD'
            % PSD
             figure;
            plot(OutputMatrix{2,i}, OutputMatrix{4,i}(:,controlData.micNumber));
            axis(controlData.plotSize);
            ax = gca;
            ax.XAxis.TickLabelFormat = '%g';
            ax.XAxis.Exponent = 0;
            xlabel('Frequency (Hz)'); ylabel('dB Re. 20uPa^2/Hz');
            titlestring = [OutputMatrix{1,i}.fileName, ' Mic ', num2str(controlData.micNumber), ' PSD at TL=', num2str(controlData.transformLength)];
            title(titlestring);
            if controlData.savePlots
                filestring = [OutputMatrix{1,i}.fileName, '_PSD_M', num2str(controlData.micNumber), '_TL', num2str(controlData.transformLength), controlData.format];
                saveas(gcf, filestring);
            end

        end
    end
    if controlData.plotAllMics
       if controlData.outputType == 'SPL'
            % SPL amplitude spectrum
            figure;
            plot(OutputMatrix{2,i}, OutputMatrix{3,i});
            axis(controlData.plotSize);
            ax = gca;
            ax.XAxis.TickLabelFormat = '%g';
            ax.XAxis.Exponent = 0;
            xlabel('Frequency (Hz)'); ylabel('dB Re. 20uPa');
            titlestring = [OutputMatrix{1,i}.fileName, ' All Mics RMS Amplitude Spectrum at TL=', num2str(controlData.transformLength)];
            title(titlestring);
            if controlData.savePlots
                filestring = [OutputMatrix{1,i}.fileName, '_SPL_AllMics_TL', num2str(controlData.transformLength), controlData.format];
                saveas(gcf, filestring);
            end

            
        elseif controlData.outputType == 'PSD'
            % PSD
             figure;
            plot(OutputMatrix{2,i}, OutputMatrix{4,i});
            axis(controlData.plotSize);
            ax = gca;
            ax.XAxis.TickLabelFormat = '%g';
            ax.XAxis.Exponent = 0;
            xlabel('Frequency (Hz)'); ylabel('dB Re. 20uPa^2/Hz');
            titlestring = [OutputMatrix{1,i}.fileName, ' All Mics PSD at TL=', num2str(controlData.transformLength)];
            title(titlestring);
             if controlData.savePlots
                filestring = [OutputMatrix{1,i}.fileName, '_PSD_AllMics_TL', num2str(controlData.transformLength), controlData.format];
                saveas(gcf, filestring);
            end
        end   
    end
    
    
    if controlData.plotSpectrogram    
        % Spectrogram
        if controlData.outputType == 'SPL'
            figure;
            [X, Y] = meshgrid(linspace(0,size(OutputMatrix{6,i},2)/(DataMatrix{1,i}.sampleRate/controlData.transformLength), size(OutputMatrix{6,i},2)), OutputMatrix{2,i});
            surf(X, Y, OutputMatrix{6,i}, 'edgecolor', 'none');
            titlestring = [OutputMatrix{1,i}.fileName, ' Mic ', num2str(controlData.micNumber), ' Spectrogram at TL=', num2str(controlData.transformLength)];
            title(titlestring); xlabel('Time (s)'); ylabel('Frequency (Hz)');
            c = colorbar;
            c.Label.String = 'dB Re. 20uPa';
            caxis(controlData.plotSize(3:4));
            ylim(controlData.plotSize(1:2));
            colormap jet;
            view(2);
            ax = gca;
            ax.YRuler.Exponent = 0;
            if controlData.savePlots
                    filestring = [OutputMatrix{1,i}.fileName, '_SPGSPL_M', num2str(controlData.micNumber), '_TL', num2str(controlData.transformLength), controlData.format];
                    saveas(gcf, filestring);
            end 
        elseif controlData.outputType == 'PSD'
            figure;
            [X, Y] = meshgrid(linspace(0,size(OutputMatrix{7,i},2)/(DataMatrix{1,i}.sampleRate/controlData.transformLength), size(OutputMatrix{7,i},2)), OutputMatrix{2,i});
            surf(X, Y, OutputMatrix{7,i}, 'edgecolor', 'none');
            titlestring = [OutputMatrix{1,i}.fileName, ' Mic ', num2str(controlData.micNumber), ' Spectrogram at TL=', num2str(controlData.transformLength)];
            title(titlestring); xlabel('Time (s)'); ylabel('Frequency (Hz)');
            c = colorbar;
            c.Label.String = 'dB Re. 20uPa^2/Hz';
            caxis(controlData.plotSize(3:4));
            ylim(controlData.plotSize(1:2));
            colormap jet;
            view(2);
            ax = gca;
            ax.YRuler.Exponent = 0;
            if controlData.savePlots
                    filestring = [OutputMatrix{1,i}.fileName, '_SPGPSD_M', num2str(controlData.micNumber), '_TL', num2str(controlData.transformLength), controlData.format];
                    saveas(gcf, filestring);
            end  
        end
    end
end
end


