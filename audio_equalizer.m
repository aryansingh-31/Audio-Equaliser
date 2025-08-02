classdef equlizer_exported8 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure           matlab.ui.Figure
        AxesPanel          matlab.ui.container.Panel
        FilterLabel        matlab.ui.control.Label
        OriginalLabel      matlab.ui.control.Label
        UIAxes_2           matlab.ui.control.UIAxes
        UIAxes             matlab.ui.control.UIAxes
        SettingsPanel      matlab.ui.container.Panel
        VolumeSlider       matlab.ui.control.Slider
        VolumeSliderLabel  matlab.ui.control.Label
        RecordButton       matlab.ui.control.Button
        StopButton         matlab.ui.control.Button
        ResumeButton       matlab.ui.control.Button
        PauseButton        matlab.ui.control.Button
        PlayButton         matlab.ui.control.Button
        PresetsPanel       matlab.ui.container.Panel
        Button_4           matlab.ui.control.Button
        NoisyButton        matlab.ui.control.Button
        InstrumentsButton  matlab.ui.control.Button
        VocalsButton       matlab.ui.control.Button
        ClassicalButton    matlab.ui.control.Button
        PartyButton        matlab.ui.control.Button
        TechnoButton       matlab.ui.control.Button
        RockButton         matlab.ui.control.Button
        ReggaeButton       matlab.ui.control.Button
        PopButton          matlab.ui.control.Button
        EqualizerPanel     matlab.ui.container.Panel
        Label_12           matlab.ui.control.Label
        Label_11           matlab.ui.control.Label
        Label_10           matlab.ui.control.Label
        Label_9            matlab.ui.control.Label
        Label_8            matlab.ui.control.Label
        Label_7            matlab.ui.control.Label
        Label_6            matlab.ui.control.Label
        Label_5            matlab.ui.control.Label
        Label_4            matlab.ui.control.Label
        Label_3            matlab.ui.control.Label
        KHzSlider_6        matlab.ui.control.Slider
        KHzSlider_6Label   matlab.ui.control.Label
        KHzSlider_5        matlab.ui.control.Slider
        KHzSlider_5Label   matlab.ui.control.Label
        KHzSlider_4        matlab.ui.control.Slider
        KHzSlider_4Label   matlab.ui.control.Label
        KHzSlider_3        matlab.ui.control.Slider
        KHzSlider_3Label   matlab.ui.control.Label
        KHzSlider_2        matlab.ui.control.Slider
        KHzSlider_2Label   matlab.ui.control.Label
        KHzSlider          matlab.ui.control.Slider
        KHzSliderLabel     matlab.ui.control.Label
        HzSlider_4         matlab.ui.control.Slider
        HzLabel            matlab.ui.control.Label
        HzSlider           matlab.ui.control.Slider
        Label_2            matlab.ui.control.Label
        HzSlider_3         matlab.ui.control.Slider
        HzSlider_3Label    matlab.ui.control.Label
        HzSlider_2         matlab.ui.control.Slider
        HzSlider_2Label    matlab.ui.control.Label
        Panel              matlab.ui.container.Panel
        BrowseButton       matlab.ui.control.Button
        Label              matlab.ui.control.Label
        FileAddressLabel   matlab.ui.control.Label
        Player             audioplayer
        EqualizerParameters struct
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: BrowseButton
        function BrowseButtonPushed(app, event)
             % Prompt the user to select a .wav file
            [fileName, filePath] = uigetfile('*.wav', 'Select a WAV file');

            % Update the FileAddressLabel with the selected file path
            if ~isequal(fileName, 0) % Check if the user selected a file
                app.Label.Text = fullfile(filePath, fileName);
                % Store the selected audio file path in the UserData of PlayButton
                app.PlayButton.UserData = fullfile(filePath, fileName);
            else
                app.Label.Text = ''; % Clear the label if no file is selected
                % Clear the UserData of PlayButton
                app.PlayButton.UserData = [];

            end
        end

         % Value changed function: HzSlider
        function HzSliderValueChanged(app, event)
              updateFilteredAudio(app,event);                    
        end

        % Value changed function: HzSlider_2
        function HzSlider_2ValueChanged(app, event)
             updateFilteredAudio(app,event);
        end

        % Value changed function: HzSlider_3
        function HzSlider_3ValueChanged(app, event)
            updateFilteredAudio(app,event);
        end

        % Value changed function: HzSlider_4
        function HzSlider_4ValueChanged(app, event)
           updateFilteredAudio(app,event);
        end

        % Value changed function: KHzSlider
        function KHzSliderValueChanged(app, event)
            updateFilteredAudio(app,event);
            
        end

        % Value changed function: KHzSlider_2
        function KHzSlider_2ValueChanged(app, event)
          updateFilteredAudio(app,event);
            
        end

        % Value changed function: KHzSlider_3
        function KHzSlider_3ValueChanged(app, event)
           updateFilteredAudio(app,event);
        end

        % Value changed function: KHzSlider_4
        function KHzSlider_4ValueChanged(app, event)
           updateFilteredAudio(app,event);
            
        end

        % Value changed function: KHzSlider_5
        function KHzSlider_5ValueChanged(app, event)
           updateFilteredAudio(app,event);
            
        end

        % Value changed function: KHzSlider_6
        function KHzSlider_6ValueChanged(app, event)
           updateFilteredAudio(app,event);
            
        end


        function updateFilteredAudio(app,event)
            % Get the slider value in dB
                            audioFilePath = 'C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav';                                                   
                            [audioData, sampleRate] = audioread(audioFilePath);

                            gaindB1 = (30*app.HzSlider.Value)-15;                           
                            gainLinear1 = 10^(gaindB1 / 20);                                                   
                            cut_off = 200; 
                            order = 16;
                            a = fir1(order, cut_off / (app.Player.SampleRate / 2), 'low');                                                                                                       
                            filteredAudio1 = gainLinear1 * filter(a, 1, audioData); 


                            gaindB2 = (30*app.HzSlider_2.Value)-15; 
                            gainLinear2 = 10^(gaindB2 / 20);
                            lowFreq2 = 201; 
                            highFreq2 = 400;  
                            order = 16;
                            b2 = fir1(order, [lowFreq2/(app.Player.SampleRate / 2) highFreq2/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio2 = gainLinear2 * filter(b2, 1, audioData);

                            gaindB3 =(30*app.HzSlider_3.Value)-15; 
                            gainLinear3 = 10^(gaindB3 / 20);
                            lowFreq3 = 401; 
                            highFreq3 = 800;  
                            order = 16;
                            b3 = fir1(order, [lowFreq3/(app.Player.SampleRate / 2) highFreq3/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio3 = gainLinear3 * filter(b3, 1, audioData);

                            gaindB4 = (30*app.HzSlider_4.Value)-15;  
                            gainLinear4 = 10^(gaindB4 / 20);
                            lowFreq4 = 801; 
                            highFreq4 = 1500;  
                            order = 16;
                            b4 = fir1(order, [lowFreq4/(app.Player.SampleRate / 2) highFreq4/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio4 = gainLinear4 * filter(b4, 1, audioData);

                            gaindB5 = (30*app.KHzSlider.Value)-15; 
                            gainLinear5 = 10^(gaindB5 / 20);
                            lowFreq5 = 1501; 
                            highFreq5 = 3000;  
                            order = 16;
                            b5 = fir1(order, [lowFreq5/(app.Player.SampleRate / 2) highFreq5/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio5 = gainLinear5 * filter(b5, 1, audioData);

                            gaindB6 = (30*app.KHzSlider_2.Value)-15; 
                            gainLinear6 = 10^(gaindB6 / 20);
                            lowFreq6 = 3001; 
                            highFreq6 = 5000;  
                            order = 16;
                            b6 = fir1(order, [lowFreq6/(app.Player.SampleRate / 2) highFreq6/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio6 = gainLinear6 * filter(b6, 1, audioData);

                            gaindB7 =(30*app.KHzSlider_3.Value)-15; 
                            gainLinear7 = 10^(gaindB7 / 20);
                            lowFreq7 = 5001; 
                            highFreq7 = 7000;  
                            order = 16;
                            b7 = fir1(order, [lowFreq7/(app.Player.SampleRate / 2) highFreq7/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio7 = gainLinear7 * filter(b7, 1, audioData);

                            gaindB8 =(30*app.KHzSlider_4.Value)-15; 
                            gainLinear8 = 10^(gaindB8 / 20);
                            lowFreq8 = 7001; 
                            highFreq8 = 10000;  
                            order = 16;
                            b8 = fir1(order, [lowFreq8/(app.Player.SampleRate / 2) highFreq8/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio8 = gainLinear8 * filter(b8, 1, audioData);

                            gaindB9 = (30*app.KHzSlider_5.Value)-15; 
                            gainLinear9 = 10^(gaindB9 / 20);
                            lowFreq9 = 10001; 
                            highFreq9 = 15000;  
                            order = 16;
                            b9 = fir1(order, [lowFreq9/(app.Player.SampleRate / 2) highFreq9/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio9 = gainLinear9 * filter(b9, 1, audioData);

                            gaindB10 = (30*app.KHzSlider_6.Value)-15; 
                            gainLinear10 = 10^(gaindB10 / 20);
                            highFreq10 = 15000;  
                            order = 16;
                            b10 = fir1(order, highFreq10/(app.Player.SampleRate / 2), 'high');
                            filteredAudio10 = gainLinear10 * filter(b10, 1, audioData);


                            filteredAudio=filteredAudio10+filteredAudio9+filteredAudio8+filteredAudio7+filteredAudio6+filteredAudio5+filteredAudio4+filteredAudio3+filteredAudio2+filteredAudio1;

                            newVolume = app.VolumeSlider.Value;
                            
                            stop(app.Player);
                            
                            if isempty(app.Player) || ~isplaying(app.Player)
                                app.Player = audioplayer(newVolume*filteredAudio, sampleRate);
                                play(app.Player);
                            else
                                % If audioplayer is already playing, update the data
                                app.Player.UserData = filteredAudio;
                            end   
                            plotFFTInUIAxes_2(app,app.UIAxes_2, newVolume*filteredAudio, sampleRate);
end


        % Value changed function: VolumeSlider
        function VolumeSliderValueChanged(app, event)
                updateFilteredAudio(app,event);
            
        end


       
        % Button pushed function: PopButton
        function PopButtonPushed(app, event)
                            audioFilePath = 'C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav';                                                   
                            [audioData, sampleRate] = audioread(audioFilePath);

                            gaindB1 = -2;                           
                            gainLinear1 = 10^(gaindB1 / 20);                                                   
                            cut_off = 200; 
                            order = 16;
                            a = fir1(order, cut_off / (app.Player.SampleRate / 2), 'low');                                                                                                       
                            filteredAudio1 = gainLinear1 * filter(a, 1, audioData); 


                            gaindB2 = -1; 
                            gainLinear2 = 10^(gaindB2 / 20);
                            lowFreq2 = 201; 
                            highFreq2 = 400;  
                            order = 16;
                            b2 = fir1(order, [lowFreq2/(app.Player.SampleRate / 2) highFreq2/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio2 = gainLinear2 * filter(b2, 1, audioData);

                            gaindB3 =2; 
                            gainLinear3 = 10^(gaindB3 / 20);
                            lowFreq3 = 401; 
                            highFreq3 = 800;  
                            order = 16;
                            b3 = fir1(order, [lowFreq3/(app.Player.SampleRate / 2) highFreq3/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio3 = gainLinear3 * filter(b3, 1, audioData);

                            gaindB4 = 2;  
                            gainLinear4 = 10^(gaindB4 / 20);
                            lowFreq4 = 801; 
                            highFreq4 = 1500;  
                            order = 16;
                            b4 = fir1(order, [lowFreq4/(app.Player.SampleRate / 2) highFreq4/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio4 = gainLinear4 * filter(b4, 1, audioData);

                            gaindB5 = 0; 
                            gainLinear5 = 10^(gaindB5 / 20);
                            lowFreq5 = 1501; 
                            highFreq5 = 3000;  
                            order = 16;
                            b5 = fir1(order, [lowFreq5/(app.Player.SampleRate / 2) highFreq5/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio5 = gainLinear5 * filter(b5, 1, audioData);

                            gaindB6 = 0; 
                            gainLinear6 = 10^(gaindB6 / 20);
                            lowFreq6 = 3001; 
                            highFreq6 = 5000;  
                            order = 16;
                            b6 = fir1(order, [lowFreq6/(app.Player.SampleRate / 2) highFreq6/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio6 = gainLinear6 * filter(b6, 1, audioData);

                            gaindB7 =0; 
                            gainLinear7 = 10^(gaindB7 / 20);
                            lowFreq7 = 5001; 
                            highFreq7 = 7000;  
                            order = 16;
                            b7 = fir1(order, [lowFreq7/(app.Player.SampleRate / 2) highFreq7/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio7 = gainLinear7 * filter(b7, 1, audioData);

                            gaindB8 =0; 
                            gainLinear8 = 10^(gaindB8 / 20);
                            lowFreq8 = 7001; 
                            highFreq8 = 10000;  
                            order = 16;
                            b8 = fir1(order, [lowFreq8/(app.Player.SampleRate / 2) highFreq8/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio8 = gainLinear8 * filter(b8, 1, audioData);

                            gaindB9 = 0; 
                            gainLinear9 = 10^(gaindB9 / 20);
                            lowFreq9 = 10001; 
                            highFreq9 = 15000;  
                            order = 16;
                            b9 = fir1(order, [lowFreq9/(app.Player.SampleRate / 2) highFreq9/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio9 = gainLinear9 * filter(b9, 1, audioData);

                            gaindB10 = 0; 
                            gainLinear10 = 10^(gaindB10 / 20);
                            highFreq10 = 15000;  
                            order = 16;
                            b10 = fir1(order, highFreq10/(app.Player.SampleRate / 2), 'high');
                            filteredAudio10 = gainLinear10 * filter(b10, 1, audioData);


                            filteredAudio=filteredAudio10+filteredAudio9+filteredAudio8+filteredAudio7+filteredAudio6+filteredAudio5+filteredAudio4+filteredAudio3+filteredAudio2+filteredAudio1;

                            newVolume = 0.2;
                            
                            stop(app.Player);
                            
                            if isempty(app.Player) || ~isplaying(app.Player)
                                app.Player = audioplayer(newVolume*filteredAudio, sampleRate);
                                play(app.Player);
                            else
                                % If audioplayer is already playing, update the data
                                app.Player.UserData = filteredAudio;
                            end

                            % Move sliders to their positions
                            app.HzSlider.Value=-2;
                            app.HzSlider_2.Value=-1;
                            app.HzSlider_3.Value=2;
                            app.HzSlider_4.Value=2;
                            app.KHzSlider.Value=0;
                            app.KHzSlider_2.Value=0;
                            app.KHzSlider_3.Value=0;
                            app.KHzSlider_4.Value=0;
                            app.KHzSlider_5.Value=0;
                            app.KHzSlider_6.Value=0;
                            plotFFTInUIAxes_2(app,app.UIAxes_2, newVolume*filteredAudio, sampleRate);
        end

        % Button pushed function: ReggaeButton
        function ReggaeButtonPushed(app, event)
                            audioFilePath = 'C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav';                                                   
                            [audioData, sampleRate] = audioread(audioFilePath);

                            gaindB1 = -5;                           
                            gainLinear1 = 10^(gaindB1 / 20);                                                   
                            cut_off = 200; 
                            order = 16;
                            a = fir1(order, cut_off / (app.Player.SampleRate / 2), 'low');                                                                                                       
                            filteredAudio1 = gainLinear1 * filter(a, 1, audioData); 


                            gaindB2 = 0; 
                            gainLinear2 = 10^(gaindB2 / 20);
                            lowFreq2 = 201; 
                            highFreq2 = 400;  
                            order = 16;
                            b2 = fir1(order, [lowFreq2/(app.Player.SampleRate / 2) highFreq2/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio2 = gainLinear2 * filter(b2, 1, audioData);

                            gaindB3 =-3; 
                            gainLinear3 = 10^(gaindB3 / 20);
                            lowFreq3 = 401; 
                            highFreq3 = 800;  
                            order = 16;
                            b3 = fir1(order, [lowFreq3/(app.Player.SampleRate / 2) highFreq3/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio3 = gainLinear3 * filter(b3, 1, audioData);

                            gaindB4 = 5;  
                            gainLinear4 = 10^(gaindB4 / 20);
                            lowFreq4 = 801; 
                            highFreq4 = 1500;  
                            order = 16;
                            b4 = fir1(order, [lowFreq4/(app.Player.SampleRate / 2) highFreq4/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio4 = gainLinear4 * filter(b4, 1, audioData);

                            gaindB5 = 0; 
                            gainLinear5 = 10^(gaindB5 / 20);
                            lowFreq5 = 1501; 
                            highFreq5 = 3000;  
                            order = 16;
                            b5 = fir1(order, [lowFreq5/(app.Player.SampleRate / 2) highFreq5/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio5 = gainLinear5 * filter(b5, 1, audioData);

                            gaindB6 = 3; 
                            gainLinear6 = 10^(gaindB6 / 20);
                            lowFreq6 = 3001; 
                            highFreq6 = 5000;  
                            order = 16;
                            b6 = fir1(order, [lowFreq6/(app.Player.SampleRate / 2) highFreq6/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio6 = gainLinear6 * filter(b6, 1, audioData);

                            gaindB7 = 4; 
                            gainLinear7 = 10^(gaindB7 / 20);
                            lowFreq7 = 5001; 
                            highFreq7 = 7000;  
                            order = 16;
                            b7 = fir1(order, [lowFreq7/(app.Player.SampleRate / 2) highFreq7/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio7 = gainLinear7 * filter(b7, 1, audioData);

                            gaindB8 =0; 
                            gainLinear8 = 10^(gaindB8 / 20);
                            lowFreq8 = 7001; 
                            highFreq8 = 10000;  
                            order = 16;
                            b8 = fir1(order, [lowFreq8/(app.Player.SampleRate / 2) highFreq8/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio8 = gainLinear8 * filter(b8, 1, audioData);

                            gaindB9 = 0; 
                            gainLinear9 = 10^(gaindB9 / 20);
                            lowFreq9 = 10001; 
                            highFreq9 = 15000;  
                            order = 16;
                            b9 = fir1(order, [lowFreq9/(app.Player.SampleRate / 2) highFreq9/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio9 = gainLinear9 * filter(b9, 1, audioData);

                            gaindB10 = 0; 
                            gainLinear10 = 10^(gaindB10 / 20);
                            highFreq10 = 15000;  
                            order = 16;
                            b10 = fir1(order, highFreq10/(app.Player.SampleRate / 2), 'high');
                            filteredAudio10 = gainLinear10 * filter(b10, 1, audioData);


                            filteredAudio=filteredAudio10+filteredAudio9+filteredAudio8+filteredAudio7+filteredAudio6+filteredAudio5+filteredAudio4+filteredAudio3+filteredAudio2+filteredAudio1;

                            newVolume = 0.7;
                            
                            stop(app.Player);
                            
                            if isempty(app.Player) || ~isplaying(app.Player)
                                app.Player = audioplayer(newVolume*filteredAudio, sampleRate);
                                play(app.Player);
                            else
                                % If audioplayer is already playing, update the data
                                app.Player.UserData = filteredAudio;
                            end

                            app.HzSlider.Value=-5;
                            app.HzSlider_2.Value=0;
                            app.HzSlider_3.Value=-3;
                            app.HzSlider_4.Value=5;
                            app.KHzSlider.Value=0;
                            app.KHzSlider_2.Value=3;
                            app.KHzSlider_3.Value=4;
                            app.KHzSlider_4.Value=0;
                            app.KHzSlider_5.Value=0;
                            app.KHzSlider_6.Value=0;
                            plotFFTInUIAxes_2(app,app.UIAxes_2, newVolume*filteredAudio, sampleRate);
        end

        % Button pushed function: RockButton
        function RockButtonPushed(app, event)
                            audioFilePath = 'C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav';                                                   
                            [audioData, sampleRate] = audioread(audioFilePath);

                            gaindB1 = -6;                           
                            gainLinear1 = 10^(gaindB1 / 20);                                                   
                            cut_off = 200; 
                            order = 16;
                            a = fir1(order, cut_off / (app.Player.SampleRate / 2), 'low');                                                                                                       
                            filteredAudio1 = gainLinear1 * filter(a, 1, audioData); 


                            gaindB2 = -1; 
                            gainLinear2 = 10^(gaindB2 / 20);
                            lowFreq2 = 201; 
                            highFreq2 = 400;  
                            order = 16;
                            b2 = fir1(order, [lowFreq2/(app.Player.SampleRate / 2) highFreq2/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio2 = gainLinear2 * filter(b2, 1, audioData);

                            gaindB3 =-2; 
                            gainLinear3 = 10^(gaindB3 / 20);
                            lowFreq3 = 401; 
                            highFreq3 = 800;  
                            order = 16;
                            b3 = fir1(order, [lowFreq3/(app.Player.SampleRate / 2) highFreq3/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio3 = gainLinear3 * filter(b3, 1, audioData);

                            gaindB4 = 0;  
                            gainLinear4 = 10^(gaindB4 / 20);
                            lowFreq4 = 801; 
                            highFreq4 = 1500;  
                            order = 16;
                            b4 = fir1(order, [lowFreq4/(app.Player.SampleRate / 2) highFreq4/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio4 = gainLinear4 * filter(b4, 1, audioData);

                            gaindB5 = 2; 
                            gainLinear5 = 10^(gaindB5 / 20);
                            lowFreq5 = 1501; 
                            highFreq5 = 3000;  
                            order = 16;
                            b5 = fir1(order, [lowFreq5/(app.Player.SampleRate / 2) highFreq5/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio5 = gainLinear5 * filter(b5, 1, audioData);

                            gaindB6 = 0; 
                            gainLinear6 = 10^(gaindB6 / 20);
                            lowFreq6 = 3001; 
                            highFreq6 = 5000;  
                            order = 16;
                            b6 = fir1(order, [lowFreq6/(app.Player.SampleRate / 2) highFreq6/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio6 = gainLinear6 * filter(b6, 1, audioData);

                            gaindB7 =3; 
                            gainLinear7 = 10^(gaindB7 / 20);
                            lowFreq7 = 5001; 
                            highFreq7 = 7000;  
                            order = 16;
                            b7 = fir1(order, [lowFreq7/(app.Player.SampleRate / 2) highFreq7/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio7 = gainLinear7 * filter(b7, 1, audioData);

                            gaindB8 =5; 
                            gainLinear8 = 10^(gaindB8 / 20);
                            lowFreq8 = 7001; 
                            highFreq8 = 10000;  
                            order = 16;
                            b8 = fir1(order, [lowFreq8/(app.Player.SampleRate / 2) highFreq8/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio8 = gainLinear8 * filter(b8, 1, audioData);

                            gaindB9 = 5; 
                            gainLinear9 = 10^(gaindB9 / 20);
                            lowFreq9 = 10001; 
                            highFreq9 = 15000;  
                            order = 16;
                            b9 = fir1(order, [lowFreq9/(app.Player.SampleRate / 2) highFreq9/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio9 = gainLinear9 * filter(b9, 1, audioData);

                            gaindB10 = 5; 
                            gainLinear10 = 10^(gaindB10 / 20);
                            highFreq10 = 15000;  
                            order = 16;
                            b10 = fir1(order, highFreq10/(app.Player.SampleRate / 2), 'high');
                            filteredAudio10 = gainLinear10 * filter(b10, 1, audioData);


                            filteredAudio=filteredAudio10+filteredAudio9+filteredAudio8+filteredAudio7+filteredAudio6+filteredAudio5+filteredAudio4+filteredAudio3+filteredAudio2+filteredAudio1;

                            newVolume = 0.2;
                            
                            stop(app.Player);
                            
                            if isempty(app.Player) || ~isplaying(app.Player)
                                app.Player = audioplayer(newVolume*filteredAudio, sampleRate);
                                play(app.Player);
                            else
                                % If audioplayer is already playing, update the data
                                app.Player.UserData = filteredAudio;
                            end

                            app.HzSlider.Value=-2;
                            app.HzSlider_2.Value=-1;
                            app.HzSlider_3.Value=2;
                            app.HzSlider_4.Value=2;
                            app.KHzSlider.Value=0;
                            app.KHzSlider_2.Value=0;
                            app.KHzSlider_3.Value=0;
                            app.KHzSlider_4.Value=0;
                            app.KHzSlider_5.Value=0;
                            app.KHzSlider_6.Value=0;
                            plotFFTInUIAxes_2(app,app.UIAxes_2, newVolume*filteredAudio, sampleRate);
        end

        % Button pushed function: TechnoButton
        function TechnoButtonPushed(app, event)
                            audioFilePath = 'C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav';                                                   
                            [audioData, sampleRate] = audioread(audioFilePath);

                            gaindB1 = 2;                           
                            gainLinear1 = 10^(gaindB1 / 20);                                                   
                            cut_off = 200; 
                            order = 16;
                            a = fir1(order, cut_off / (app.Player.SampleRate / 2), 'low');                                                                                                       
                            filteredAudio1 = gainLinear1 * filter(a, 1, audioData); 


                            gaindB2 = 0; 
                            gainLinear2 = 10^(gaindB2 / 20);
                            lowFreq2 = 201; 
                            highFreq2 = 400;  
                            order = 16;
                            b2 = fir1(order, [lowFreq2/(app.Player.SampleRate / 2) highFreq2/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio2 = gainLinear2 * filter(b2, 1, audioData);

                            gaindB3 = -2; 
                            gainLinear3 = 10^(gaindB3 / 20);
                            lowFreq3 = 401; 
                            highFreq3 = 800;  
                            order = 16;
                            b3 = fir1(order, [lowFreq3/(app.Player.SampleRate / 2) highFreq3/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio3 = gainLinear3 * filter(b3, 1, audioData);

                            gaindB4 = -2;  
                            gainLinear4 = 10^(gaindB4 / 20);
                            lowFreq4 = 801; 
                            highFreq4 = 1500;  
                            order = 16;
                            b4 = fir1(order, [lowFreq4/(app.Player.SampleRate / 2) highFreq4/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio4 = gainLinear4 * filter(b4, 1, audioData);

                            gaindB5 = 0; 
                            gainLinear5 = 10^(gaindB5 / 20);
                            lowFreq5 = 1501; 
                            highFreq5 = 3000;  
                            order = 16;
                            b5 = fir1(order, [lowFreq5/(app.Player.SampleRate / 2) highFreq5/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio5 = gainLinear5 * filter(b5, 1, audioData);

                            gaindB6 = 0; 
                            gainLinear6 = 10^(gaindB6 / 20);
                            lowFreq6 = 3001; 
                            highFreq6 = 5000;  
                            order = 16;
                            b6 = fir1(order, [lowFreq6/(app.Player.SampleRate / 2) highFreq6/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio6 = gainLinear6 * filter(b6, 1, audioData);

                            gaindB7 =4; 
                            gainLinear7 = 10^(gaindB7 / 20);
                            lowFreq7 = 5001; 
                            highFreq7 = 7000;  
                            order = 16;
                            b7 = fir1(order, [lowFreq7/(app.Player.SampleRate / 2) highFreq7/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio7 = gainLinear7 * filter(b7, 1, audioData);

                            gaindB8 =4; 
                            gainLinear8 = 10^(gaindB8 / 20);
                            lowFreq8 = 7001; 
                            highFreq8 = 10000;  
                            order = 16;
                            b8 = fir1(order, [lowFreq8/(app.Player.SampleRate / 2) highFreq8/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio8 = gainLinear8 * filter(b8, 1, audioData);

                            gaindB9 = 4; 
                            gainLinear9 = 10^(gaindB9 / 20);
                            lowFreq9 = 10001; 
                            highFreq9 = 15000;  
                            order = 16;
                            b9 = fir1(order, [lowFreq9/(app.Player.SampleRate / 2) highFreq9/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio9 = gainLinear9 * filter(b9, 1, audioData);

                            gaindB10 = 5; 
                            gainLinear10 = 10^(gaindB10 / 20);
                            highFreq10 = 15000;  
                            order = 16;
                            b10 = fir1(order, highFreq10/(app.Player.SampleRate / 2), 'high');
                            filteredAudio10 = gainLinear10 * filter(b10, 1, audioData);


                            filteredAudio=filteredAudio10+filteredAudio9+filteredAudio8+filteredAudio7+filteredAudio6+filteredAudio5+filteredAudio4+filteredAudio3+filteredAudio2+filteredAudio1;

                            newVolume = 0.2;
                            
                            stop(app.Player);
                            
                            if isempty(app.Player) || ~isplaying(app.Player)
                                app.Player = audioplayer(newVolume*filteredAudio, sampleRate);
                                play(app.Player);
                            else
                                % If audioplayer is already playing, update the data
                                app.Player.UserData = filteredAudio;
                            end

                            app.HzSlider.Value=2;
                            app.HzSlider_2.Value=0;
                            app.HzSlider_3.Value=-2;
                            app.HzSlider_4.Value=-2;
                            app.KHzSlider.Value=0;
                            app.KHzSlider_2.Value=0;
                            app.KHzSlider_3.Value=4;
                            app.KHzSlider_4.Value=4;
                            app.KHzSlider_5.Value=4;
                            app.KHzSlider_6.Value=5;
                            plotFFTInUIAxes_2(app,app.UIAxes_2, newVolume*filteredAudio, sampleRate);
        end

        % Button pushed function: PartyButton
        function PartyButtonPushed(app, event)
                            audioFilePath = 'C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav';                                                   
                            [audioData, sampleRate] = audioread(audioFilePath);

                            gaindB1 = 3;                           
                            gainLinear1 = 10^(gaindB1 / 20);                                                   
                            cut_off = 200; 
                            order = 16;
                            a = fir1(order, cut_off / (app.Player.SampleRate / 2), 'low');                                                                                                       
                            filteredAudio1 = gainLinear1 * filter(a, 1, audioData); 


                            gaindB2 = 0; 
                            gainLinear2 = 10^(gaindB2 / 20);
                            lowFreq2 = 201; 
                            highFreq2 = 400;  
                            order = 16;
                            b2 = fir1(order, [lowFreq2/(app.Player.SampleRate / 2) highFreq2/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio2 = gainLinear2 * filter(b2, 1, audioData);

                            gaindB3 =0; 
                            gainLinear3 = 10^(gaindB3 / 20);
                            lowFreq3 = 401; 
                            highFreq3 = 800;  
                            order = 16;
                            b3 = fir1(order, [lowFreq3/(app.Player.SampleRate / 2) highFreq3/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio3 = gainLinear3 * filter(b3, 1, audioData);

                            gaindB4 = 0;  
                            gainLinear4 = 10^(gaindB4 / 20);
                            lowFreq4 = 801; 
                            highFreq4 = 1500;  
                            order = 16;
                            b4 = fir1(order, [lowFreq4/(app.Player.SampleRate / 2) highFreq4/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio4 = gainLinear4 * filter(b4, 1, audioData);

                            gaindB5 = 0; 
                            gainLinear5 = 10^(gaindB5 / 20);
                            lowFreq5 = 1501; 
                            highFreq5 = 3000;  
                            order = 16;
                            b5 = fir1(order, [lowFreq5/(app.Player.SampleRate / 2) highFreq5/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio5 = gainLinear5 * filter(b5, 1, audioData);

                            gaindB6 = 0; 
                            gainLinear6 = 10^(gaindB6 / 20);
                            lowFreq6 = 3001; 
                            highFreq6 = 5000;  
                            order = 16;
                            b6 = fir1(order, [lowFreq6/(app.Player.SampleRate / 2) highFreq6/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio6 = gainLinear6 * filter(b6, 1, audioData);

                            gaindB7 =0; 
                            gainLinear7 = 10^(gaindB7 / 20);
                            lowFreq7 = 5001; 
                            highFreq7 = 7000;  
                            order = 16;
                            b7 = fir1(order, [lowFreq7/(app.Player.SampleRate / 2) highFreq7/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio7 = gainLinear7 * filter(b7, 1, audioData);

                            gaindB8 =0; 
                            gainLinear8 = 10^(gaindB8 / 20);
                            lowFreq8 = 7001; 
                            highFreq8 = 10000;  
                            order = 16;
                            b8 = fir1(order, [lowFreq8/(app.Player.SampleRate / 2) highFreq8/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio8 = gainLinear8 * filter(b8, 1, audioData);

                            gaindB9 = 5; 
                            gainLinear9 = 10^(gaindB9 / 20);
                            lowFreq9 = 10001; 
                            highFreq9 = 15000;  
                            order = 16;
                            b9 = fir1(order, [lowFreq9/(app.Player.SampleRate / 2) highFreq9/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio9 = gainLinear9 * filter(b9, 1, audioData);

                            gaindB10 = 5; 
                            gainLinear10 = 10^(gaindB10 / 20);
                            highFreq10 = 15000;  
                            order = 16;
                            b10 = fir1(order, highFreq10/(app.Player.SampleRate / 2), 'high');
                            filteredAudio10 = gainLinear10 * filter(b10, 1, audioData);


                            filteredAudio=filteredAudio10+filteredAudio9+filteredAudio8+filteredAudio7+filteredAudio6+filteredAudio5+filteredAudio4+filteredAudio3+filteredAudio2+filteredAudio1;

                            newVolume = 0.2;
                            
                            stop(app.Player);
                            
                            if isempty(app.Player) || ~isplaying(app.Player)
                                app.Player = audioplayer(newVolume*filteredAudio, sampleRate);
                                play(app.Player);
                            else
                                % If audioplayer is already playing, update the data
                                app.Player.UserData = filteredAudio;
                            end


                            app.HzSlider.Value=3;
                            app.HzSlider_2.Value=0;
                            app.HzSlider_3.Value=0;
                            app.HzSlider_4.Value=0;
                            app.KHzSlider.Value=0;
                            app.KHzSlider_2.Value=0;
                            app.KHzSlider_3.Value=0;
                            app.KHzSlider_4.Value=0;
                            app.KHzSlider_5.Value=5;
                            app.KHzSlider_6.Value=5;
                            plotFFTInUIAxes_2(app,app.UIAxes_2, newVolume*filteredAudio, sampleRate);
        end

        % Button pushed function: ClassicalButton
        function ClassicalButtonPushed(app, event)
                            audioFilePath = 'C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav';                                                   
                            [audioData, sampleRate] = audioread(audioFilePath);

                            gaindB1 = 0;                           
                            gainLinear1 = 10^(gaindB1 / 20);                                                   
                            cut_off = 200; 
                            order = 16;
                            a = fir1(order, cut_off / (app.Player.SampleRate / 2), 'low');                                                                                                       
                            filteredAudio1 = gainLinear1 * filter(a, 1, audioData); 

                            gaindB2 = 0; 
                            gainLinear2 = 10^(gaindB2 / 20);
                            lowFreq2 = 201; 
                            highFreq2 = 400;  
                            order = 16;
                            b2 = fir1(order, [lowFreq2/(app.Player.SampleRate / 2) highFreq2/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio2 = gainLinear2 * filter(b2, 1, audioData);

                            gaindB3 =0; 
                            gainLinear3 = 10^(gaindB3 / 20);
                            lowFreq3 = 401; 
                            highFreq3 = 800;  
                            order = 16;
                            b3 = fir1(order, [lowFreq3/(app.Player.SampleRate / 2) highFreq3/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio3 = gainLinear3 * filter(b3, 1, audioData);

                            gaindB4 = 0;  
                            gainLinear4 = 10^(gaindB4 / 20);
                            lowFreq4 = 801; 
                            highFreq4 = 1500;  
                            order = 16;
                            b4 = fir1(order, [lowFreq4/(app.Player.SampleRate / 2) highFreq4/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio4 = gainLinear4 * filter(b4, 1, audioData);

                            gaindB5 = 0; 
                            gainLinear5 = 10^(gaindB5 / 20);
                            lowFreq5 = 1501; 
                            highFreq5 = 3000;  
                            order = 16;
                            b5 = fir1(order, [lowFreq5/(app.Player.SampleRate / 2) highFreq5/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio5 = gainLinear5 * filter(b5, 1, audioData);

                            gaindB6 = 0; 
                            gainLinear6 = 10^(gaindB6 / 20);
                            lowFreq6 = 3001; 
                            highFreq6 = 5000;  
                            order = 16;
                            b6 = fir1(order, [lowFreq6/(app.Player.SampleRate / 2) highFreq6/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio6 = gainLinear6 * filter(b6, 1, audioData);

                            gaindB7 = -3; 
                            gainLinear7 = 10^(gaindB7 / 20);
                            lowFreq7 = 5001; 
                            highFreq7 = 7000;  
                            order = 16;
                            b7 = fir1(order, [lowFreq7/(app.Player.SampleRate / 2) highFreq7/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio7 = gainLinear7 * filter(b7, 1, audioData);

                            gaindB8 = -3; 
                            gainLinear8 = 10^(gaindB8 / 20);
                            lowFreq8 = 7001; 
                            highFreq8 = 10000;  
                            order = 16;
                            b8 = fir1(order, [lowFreq8/(app.Player.SampleRate / 2) highFreq8/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio8 = gainLinear8 * filter(b8, 1, audioData);

                            gaindB9 = -3; 
                            gainLinear9 = 10^(gaindB9 / 20);
                            lowFreq9 = 10001; 
                            highFreq9 = 15000;  
                            order = 16;
                            b9 = fir1(order, [lowFreq9/(app.Player.SampleRate / 2) highFreq9/(app.Player.SampleRate / 2)], 'bandpass');
                            filteredAudio9 = gainLinear9 * filter(b9, 1, audioData);

                            gaindB10 = -5; 
                            gainLinear10 = 10^(gaindB10 / 20);
                            highFreq10 = 15000;  
                            order = 16;
                            b10 = fir1(order, highFreq10/(app.Player.SampleRate / 2), 'high');
                            filteredAudio10 = gainLinear10 * filter(b10, 1, audioData);


                            filteredAudio=filteredAudio10+filteredAudio9+filteredAudio8+filteredAudio7+filteredAudio6+filteredAudio5+filteredAudio4+filteredAudio3+filteredAudio2+filteredAudio1;

                            newVolume = 0.2;
                            
                            stop(app.Player);
                            
                            if isempty(app.Player) || ~isplaying(app.Player)
                                app.Player = audioplayer(newVolume*filteredAudio, sampleRate);
                                play(app.Player);
                            else
                                % If audioplayer is already playing, update the data
                                app.Player.UserData = filteredAudio;
                            end

                            app.HzSlider.Value=-2;
                            app.HzSlider_2.Value=-1;
                            app.HzSlider_3.Value=2;
                            app.HzSlider_4.Value=2;
                            app.KHzSlider.Value=0;
                            app.KHzSlider_2.Value=0;
                            app.KHzSlider_3.Value=-3;
                            app.KHzSlider_4.Value=-3;
                            app.KHzSlider_5.Value=-3;
                            app.KHzSlider_6.Value=-5;
                            plotFFTInUIAxes_2(app,app.UIAxes_2, newVolume*filteredAudio, sampleRate);
        end


        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            % Get the selected audio file path from the UserData of PlayButton
            audioFilePath = app.PlayButton.UserData;

            % Debugging: Display the selected file path
            disp(['Selected File: ' audioFilePath]);

            % Play the audio if a file is selected
            if ~isempty(audioFilePath)
                % Load the selected audio file into the audioplayer
                [audioData, fs] = audioread(audioFilePath);
                app.Player = audioplayer(audioData, fs);

                % Debugging: Display audioplayer properties
                disp('Audioplayer Properties:');
                disp(app.Player);

                % Play the audio
                play(app.Player);

                % Debugging: Display a message when playing
                disp('Playing audio...');
          else
                % Debugging: Display a message when no file is selected
                disp('No audio file selected.');
            end

            plotFFTInUIAxes(app,app.UIAxes, audioData, fs);

        end

        function plotFFTInUIAxes(app,uiAxes, audioData, fs)
                    % Calculate FFT
                    L = length(audioData);
                    Y = fft(audioData);
                    P2 = abs(Y/L);
                    P1 = P2(1:L/2+1);
                    P1(2:end-1) = 2*P1(2:end-1);
                    f = fs*(0:(L/2))/L;
                    
                    % Plot FFT in UIAxes
                    plot(uiAxes, f, P1)
                    xlabel(uiAxes, 'Frequency (Hz)')
                    ylabel(uiAxes, '|Y(f)|')
        end
        function plotFFTInUIAxes_2(app,uiAxes_2, audioData, fs)
                    % Calculate FFT
                    L = length(audioData);
                    Y = fft(audioData);
                    P2 = abs(Y/L);
                    P1 = P2(1:L/2+1);
                    P1(2:end-1) = 2*P1(2:end-1);
                    f = fs*(0:(L/2))/L;
                    
                    % Plot FFT in UIAxes
                    plot(uiAxes_2, f, P1)
                    xlabel(uiAxes_2, 'Frequency (Hz)')
                    ylabel(uiAxes_2, '|Y(f)|')
    end

        % Button pushed function: PauseButton
        function PauseButtonPushed(app, event)
            % Implement pause functionality
                disp('Pausing audio...');
                pause(app.Player);
        end

        % Button pushed function: ResumeButton
        function ResumeButtonPushed(app, event)
             % Implement resume functionality
                disp('Resuming audio...');
                resume(app.Player);
        end

        % Button pushed function: StopButton
        function StopButtonPushed(app, event)
            % Implement stop functionality
                disp('Stopping audio...');
                stop(app.Player);
        end

        % Button pushed function: RecordButton
        function RecordButtonPushed(app, event)
            
        end

        
        function UIAxesButtonPushed(app, event)
            % Check if a file is selected
            if isempty(app.PlayButton.UserData)
                disp('No audio file selected.');
                return;
            end
            
            % Load the selected audio file into the audioplayer
            [audio, fs] = audioread(app.PlayButton.UserData);
        
            % Compute FFT
            L = length(audio);  % Length of the signal
            Y = fft(audio);
            P2 = abs(Y/L); % Two-sided spectrum
            P1 = P2(1:L/2+1); % Single-sided spectrum
            P1(2:end-1) = 2*P1(2:end-1);
        
            % Frequency vector
            f = fs*(0:(L/2))/L;
        
            % Plot FFT on UIAxes
            plot(app.UIAxes, f, P1);
            title(app.UIAxes, 'Single-Sided Amplitude Spectrum of Audio');
            xlabel(app.UIAxes, 'Frequency (Hz)');
            ylabel(app.UIAxes, '|P1(f)|');
        end

function isolatedVocals(app,audioData, sampleRate)

    length2 = pow2(nextpow2(length(audioData)) - 1);
    
    ad_1 = fft(audioData, length2);

    lowerFreq = 50;
    upperFreq = 1000;

    lowerIndex = round(lowerFreq * length2 / sampleRate) + 1;
    upperIndex = round(upperFreq * length2 / sampleRate) + 1;

    % Set the values outside of the desired frequency range to zero
    ad_1(1:lowerIndex, :) = 0;
    ad_1(upperIndex:end, :) = 0;

    v_3 = real(ifft(ad_1));

    app.Player = audioplayer(v_3, sampleRate);

     play(app.Player);

end

        % Button pushed function: VocalsButton
        function VocalsButtonPushed(app, event)
                [audio_in, audio_freq] = audioread('C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav');
            
                
                lower_freq = 200;
                upper_freq = 500;
            
                
                [b, a] = butter(4, [lower_freq/(audio_freq/2), upper_freq/(audio_freq/2)], 'bandpass');
                vocals_filtered = filtfilt(b, a, audio_in);
            
                
                volume_factor = 1; 
                vocals_filtered = volume_factor * vocals_filtered;
            
                % Stop any currently playing audio
                stop(app.Player);
            
                % Play the filtered vocals
                if isempty(app.Player) || ~isplaying(app.Player)
                    app.Player = audioplayer(vocals_filtered, audio_freq);
                    play(app.Player);
                else
                    % If audioplayer is already playing, update the data
                    app.Player.UserData = vocals_filtered;
                end 
                plotFFTInUIAxes_2(app,app.UIAxes_2, vocals_filtered, audio_freq);

        end



        
        function InstrumentsButtonPushed(app, event)
                [audio_in, audio_freq] = audioread('C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav');
            
                
                lower_freq = 2500;
                upper_freq = 15000;
            
                
                [b, a] = butter(4, [lower_freq/(audio_freq/2), upper_freq/(audio_freq/2)], 'bandpass');
                vocals_filtered = filtfilt(b, a, audio_in);
            
                
                volume_factor = 1; 
                vocals_filtered = volume_factor * vocals_filtered;
            
                
                stop(app.Player);
            
               
                if isempty(app.Player) || ~isplaying(app.Player)
                    app.Player = audioplayer(vocals_filtered, audio_freq);
                    play(app.Player);
                else
                 
                    app.Player.UserData = vocals_filtered;
                end     
                plotFFTInUIAxes_2(app,app.UIAxes_2, vocals_filtered, audio_freq);
        end




      
        function NoisyButtonPushed(app, event)

                [audio_in, audio_freq] = audioread('C:\Users\adars\OneDrive\Desktop\dsp_project\sample_data1.wav');                
                lower_freq = 100; 
                upper_freq = 10000; 
            
                
                filter_order = 4;
            
                
                [b, a] = butter(filter_order, [lower_freq/(audio_freq/2), upper_freq/(audio_freq/2)], 'bandpass');
                signal_filtered = filtfilt(b, a, audio_in);
            
                
                volume_factor = 1;
                signal_filtered = volume_factor * signal_filtered;
            
                
                stop(app.Player);
            
                
                if isempty(app.Player) || ~isplaying(app.Player)
                    app.Player = audioplayer(signal_filtered, audio_freq);
                    play(app.Player);
                else    
                    app.Player.UserData = signal_filtered;
                end
                 plotFFTInUIAxes_2(app,app.UIAxes_2, signal_filtered, audio_freq);
            
        end

    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1846 918];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.Scrollable = 'on';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.Scrollable = 'on';
            app.Panel.Position = [29 840 580 60];

            % Create FileAddressLabel
            app.FileAddressLabel = uilabel(app.Panel);
            app.FileAddressLabel.Position = [19 28 82 22];
            app.FileAddressLabel.Text = 'File Address - ';

            % Create Label
            app.Label = uilabel(app.Panel);
            app.Label.Tag = 'address';
            app.Label.BackgroundColor = [0.902 0.902 0.902];
            app.Label.HorizontalAlignment = 'center';
            app.Label.Position = [109 28 337 22];
            app.Label.Text = '';

            % Create BrowseButton
            app.BrowseButton = uibutton(app.Panel, 'push');
            app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
            app.BrowseButton.BackgroundColor = [0.651 0.651 0.651];
            app.BrowseButton.Position = [462 27 100 23];
            app.BrowseButton.Text = 'Browse';

            % Create EqualizerPanel
            app.EqualizerPanel = uipanel(app.UIFigure);
            app.EqualizerPanel.Title = 'Equalizer';
            app.EqualizerPanel.Scrollable = 'on';
            app.EqualizerPanel.Position = [29 498 974 297];

            % Create HzSlider_2Label
            app.HzSlider_2Label = uilabel(app.EqualizerPanel);
            app.HzSlider_2Label.HorizontalAlignment = 'right';
            app.HzSlider_2Label.Position = [101 245 64 22];
            app.HzSlider_2Label.Text = '201-400Hz';

            % Create HzSlider_2
            app.HzSlider_2 = uislider(app.EqualizerPanel);
            app.HzSlider_2.Limits = [-15 15];
            app.HzSlider_2.Orientation = 'vertical';
            app.HzSlider_2.ValueChangedFcn = createCallbackFcn(app, @HzSlider_2ValueChanged, true);
            app.HzSlider_2.Position = [156 70 3 169];

            % Create HzSlider_3Label
            app.HzSlider_3Label = uilabel(app.EqualizerPanel);
            app.HzSlider_3Label.HorizontalAlignment = 'right';
            app.HzSlider_3Label.Position = [196 245 64 22];
            app.HzSlider_3Label.Text = '401-800Hz';

            % Create HzSlider_3
            app.HzSlider_3 = uislider(app.EqualizerPanel);
            app.HzSlider_3.Limits = [-15 15];
            app.HzSlider_3.Orientation = 'vertical';
            app.HzSlider_3.ValueChangedFcn = createCallbackFcn(app, @HzSlider_3ValueChanged, true);
            app.HzSlider_3.Position = [252 70 3 169];

            % Create Label_2
            app.Label_2 = uilabel(app.EqualizerPanel);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [15 245 54 22];
            app.Label_2.Text = '0-200 Hz';

            % Create HzSlider
            app.HzSlider = uislider(app.EqualizerPanel);
            app.HzSlider.Limits = [-15 15];
            app.HzSlider.Orientation = 'vertical';
            app.HzSlider.ValueChangedFcn = createCallbackFcn(app, @HzSliderValueChanged, true);
            app.HzSlider.Position = [60 70 3 169];

            % Create HzLabel
            app.HzLabel = uilabel(app.EqualizerPanel);
            app.HzLabel.HorizontalAlignment = 'right';
            app.HzLabel.Position = [285 245 70 22];
            app.HzLabel.Text = '801-1500Hz';

            % Create HzSlider_4
            app.HzSlider_4 = uislider(app.EqualizerPanel);
            app.HzSlider_4.Limits = [-15 15];
            app.HzSlider_4.Orientation = 'vertical';
            app.HzSlider_4.ValueChangedFcn = createCallbackFcn(app, @HzSlider_4ValueChanged, true);
            app.HzSlider_4.Position = [347 70 3 169];

            % Create KHzSliderLabel
            app.KHzSliderLabel = uilabel(app.EqualizerPanel);
            app.KHzSliderLabel.HorizontalAlignment = 'right';
            app.KHzSliderLabel.Position = [397 245 55 22];
            app.KHzSliderLabel.Text = '1.5-3KHz';

            % Create KHzSlider
            app.KHzSlider = uislider(app.EqualizerPanel);
            app.KHzSlider.Limits = [-15 15];
            app.KHzSlider.Orientation = 'vertical';
            app.KHzSlider.ValueChangedFcn = createCallbackFcn(app, @KHzSliderValueChanged, true);
            app.KHzSlider.Position = [443 70 3 169];

            % Create KHzSlider_2Label
            app.KHzSlider_2Label = uilabel(app.EqualizerPanel);
            app.KHzSlider_2Label.HorizontalAlignment = 'right';
            app.KHzSlider_2Label.Position = [503 245 45 22];
            app.KHzSlider_2Label.Text = '3-5KHz';

            % Create KHzSlider_2
            app.KHzSlider_2 = uislider(app.EqualizerPanel);
            app.KHzSlider_2.Limits = [-15 15];
            app.KHzSlider_2.Orientation = 'vertical';
            app.KHzSlider_2.ValueChangedFcn = createCallbackFcn(app, @KHzSlider_2ValueChanged, true);
            app.KHzSlider_2.Position = [539 70 3 169];

            % Create KHzSlider_3Label
            app.KHzSlider_3Label = uilabel(app.EqualizerPanel);
            app.KHzSlider_3Label.HorizontalAlignment = 'right';
            app.KHzSlider_3Label.Position = [599 245 45 22];
            app.KHzSlider_3Label.Text = '5-7KHz';

            % Create KHzSlider_3
            app.KHzSlider_3 = uislider(app.EqualizerPanel);
            app.KHzSlider_3.Limits = [-15 15];
            app.KHzSlider_3.Orientation = 'vertical';
            app.KHzSlider_3.ValueChangedFcn = createCallbackFcn(app, @KHzSlider_3ValueChanged, true);
            app.KHzSlider_3.Position = [635 70 3 169];

            % Create KHzSlider_4Label
            app.KHzSlider_4Label = uilabel(app.EqualizerPanel);
            app.KHzSlider_4Label.HorizontalAlignment = 'right';
            app.KHzSlider_4Label.Position = [688 245 52 22];
            app.KHzSlider_4Label.Text = '7-10KHz';

            % Create KHzSlider_4
            app.KHzSlider_4 = uislider(app.EqualizerPanel);
            app.KHzSlider_4.Limits = [-15 15];
            app.KHzSlider_4.Orientation = 'vertical';
            app.KHzSlider_4.ValueChangedFcn = createCallbackFcn(app, @KHzSlider_4ValueChanged, true);
            app.KHzSlider_4.Position = [731 70 3 169];

            % Create KHzSlider_5Label
            app.KHzSlider_5Label = uilabel(app.EqualizerPanel);
            app.KHzSlider_5Label.HorizontalAlignment = 'right';
            app.KHzSlider_5Label.Position = [779 245 58 22];
            app.KHzSlider_5Label.Text = '10-15KHz';

            % Create KHzSlider_5
            app.KHzSlider_5 = uislider(app.EqualizerPanel);
            app.KHzSlider_5.Limits = [-15 15];
            app.KHzSlider_5.Orientation = 'vertical';
            app.KHzSlider_5.ValueChangedFcn = createCallbackFcn(app, @KHzSlider_5ValueChanged, true);
            app.KHzSlider_5.Position = [828 70 3 169];

            % Create KHzSlider_6Label
            app.KHzSlider_6Label = uilabel(app.EqualizerPanel);
            app.KHzSlider_6Label.HorizontalAlignment = 'right';
            app.KHzSlider_6Label.Position = [885 245 48 22];
            app.KHzSlider_6Label.Text = '>15KHz';

            % Create KHzSlider_6
            app.KHzSlider_6 = uislider(app.EqualizerPanel);
            app.KHzSlider_6.Limits = [-15 15];
            app.KHzSlider_6.Orientation = 'vertical';
            app.KHzSlider_6.ValueChangedFcn = createCallbackFcn(app, @KHzSlider_6ValueChanged, true);
            app.KHzSlider_6.Position = [924 70 3 169];

            % Create Label_3
            app.Label_3 = uilabel(app.EqualizerPanel);
            app.Label_3.BackgroundColor = [1 1 1];
            app.Label_3.Position = [42 18 58 30];
            app.Label_3.Text = '';

            % Create Label_4
            app.Label_4 = uilabel(app.EqualizerPanel);
            app.Label_4.BackgroundColor = [1 1 1];
            app.Label_4.Position = [139 18 58 30];
            app.Label_4.Text = '';

            % Create Label_5
            app.Label_5 = uilabel(app.EqualizerPanel);
            app.Label_5.BackgroundColor = [1 1 1];
            app.Label_5.Position = [234 18 58 30];
            app.Label_5.Text = '';

            % Create Label_6
            app.Label_6 = uilabel(app.EqualizerPanel);
            app.Label_6.BackgroundColor = [1 1 1];
            app.Label_6.Position = [329 18 58 30];
            app.Label_6.Text = '';

            % Create Label_7
            app.Label_7 = uilabel(app.EqualizerPanel);
            app.Label_7.BackgroundColor = [1 1 1];
            app.Label_7.Position = [426 18 58 30];
            app.Label_7.Text = '';

            % Create Label_8
            app.Label_8 = uilabel(app.EqualizerPanel);
            app.Label_8.BackgroundColor = [1 1 1];
            app.Label_8.Position = [522 18 58 30];
            app.Label_8.Text = '';

            % Create Label_9
            app.Label_9 = uilabel(app.EqualizerPanel);
            app.Label_9.BackgroundColor = [1 1 1];
            app.Label_9.Position = [618 18 58 30];
            app.Label_9.Text = '';

            % Create Label_10
            app.Label_10 = uilabel(app.EqualizerPanel);
            app.Label_10.BackgroundColor = [1 1 1];
            app.Label_10.Position = [713 18 58 30];
            app.Label_10.Text = '';

            % Create Label_11
            app.Label_11 = uilabel(app.EqualizerPanel);
            app.Label_11.BackgroundColor = [1 1 1];
            app.Label_11.Position = [811 18 58 30];
            app.Label_11.Text = '';

            % Create Label_12
            app.Label_12 = uilabel(app.EqualizerPanel);
            app.Label_12.BackgroundColor = [1 1 1];
            app.Label_12.Position = [906 18 58 30];
            app.Label_12.Text = '';

            % Create PresetsPanel
            app.PresetsPanel = uipanel(app.UIFigure);
            app.PresetsPanel.Title = 'Presets';
            app.PresetsPanel.Scrollable = 'on';
            app.PresetsPanel.Position = [30 260 973 210];

            % Create PopButton
            app.PopButton = uibutton(app.PresetsPanel, 'push');
            app.PopButton.ButtonPushedFcn = createCallbackFcn(app, @PopButtonPushed, true);
            app.PopButton.Tag = 'pop';
            app.PopButton.BackgroundColor = [0.8 0.8 0.8];
            app.PopButton.Position = [61 126 92 43];
            app.PopButton.Text = 'Pop';

            % Create ReggaeButton
            app.ReggaeButton = uibutton(app.PresetsPanel, 'push');
            app.ReggaeButton.ButtonPushedFcn = createCallbackFcn(app, @ReggaeButtonPushed, true);
            app.ReggaeButton.Tag = 'reggae';
            app.ReggaeButton.BackgroundColor = [0.8 0.8 0.8];
            app.ReggaeButton.Position = [217 126 92 43];
            app.ReggaeButton.Text = 'Reggae';

            % Create RockButton
            app.RockButton = uibutton(app.PresetsPanel, 'push');
            app.RockButton.ButtonPushedFcn = createCallbackFcn(app, @RockButtonPushed, true);
            app.RockButton.Tag = 'rock';
            app.RockButton.BackgroundColor = [0.8 0.8 0.8];
            app.RockButton.Position = [380 126 92 43];
            app.RockButton.Text = 'Rock';

            % Create TechnoButton
            app.TechnoButton = uibutton(app.PresetsPanel, 'push');
            app.TechnoButton.ButtonPushedFcn = createCallbackFcn(app, @TechnoButtonPushed, true);
            app.TechnoButton.Tag = 'techno';
            app.TechnoButton.BackgroundColor = [0.8 0.8 0.8];
            app.TechnoButton.Position = [538 126 92 43];
            app.TechnoButton.Text = 'Techno';

            % Create PartyButton
            app.PartyButton = uibutton(app.PresetsPanel, 'push');
            app.PartyButton.ButtonPushedFcn = createCallbackFcn(app, @PartyButtonPushed, true);
            app.PartyButton.Tag = 'party';
            app.PartyButton.BackgroundColor = [0.8 0.8 0.8];
            app.PartyButton.Position = [697 126 92 43];
            app.PartyButton.Text = 'Party';

            % Create ClassicalButton
            app.ClassicalButton = uibutton(app.PresetsPanel, 'push');
            app.ClassicalButton.ButtonPushedFcn = createCallbackFcn(app, @ClassicalButtonPushed, true);
            app.ClassicalButton.Tag = 'classical';
            app.ClassicalButton.BackgroundColor = [0.8 0.8 0.8];
            app.ClassicalButton.Position = [841 126 92 43];
            app.ClassicalButton.Text = 'Classical';

            % Create VocalsButton
            app.VocalsButton = uibutton(app.PresetsPanel, 'push');
            app.VocalsButton.ButtonPushedFcn = createCallbackFcn(app, @VocalsButtonPushed, true);
            app.VocalsButton.Tag = 'vocals';
            app.VocalsButton.BackgroundColor = [0.8 0.8 0.8];
            app.VocalsButton.Position = [137 21 96 58];
            app.VocalsButton.Text = 'Vocals';

            % Create InstrumentsButton
            app.InstrumentsButton = uibutton(app.PresetsPanel, 'push');
            app.InstrumentsButton.ButtonPushedFcn = createCallbackFcn(app, @InstrumentsButtonPushed, true);
            app.InstrumentsButton.Tag = 'instruments';
            app.InstrumentsButton.BackgroundColor = [0.8 0.8 0.8];
            app.InstrumentsButton.Position =  [424 21 96 58];
            app.InstrumentsButton.Text = 'Instruments';

            % Create NoisyButton
            app.NoisyButton = uibutton(app.PresetsPanel, 'push');
            app.NoisyButton.ButtonPushedFcn = createCallbackFcn(app, @NoisyButtonPushed, true);
            app.NoisyButton.Tag = 'noisy';
            app.NoisyButton.BackgroundColor = [0.8 0.8 0.8];
            app.NoisyButton.Position = [712 21 96 58];
            app.NoisyButton.Text = 'Noisy';

            % Create SettingsPanel
            app.SettingsPanel = uipanel(app.UIFigure);
            app.SettingsPanel.Title = 'Settings';
            app.SettingsPanel.Scrollable = 'on';
            app.SettingsPanel.Position = [29 126 973 98];

            % Create PlayButton
            app.PlayButton = uibutton(app.SettingsPanel, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.Tag = 'play';
            app.PlayButton.BackgroundColor = [0.8 0.8 0.8];
            app.PlayButton.Position = [11 22 92 43];
            app.PlayButton.Text = 'Play';

            % Create PauseButton
            app.PauseButton = uibutton(app.SettingsPanel, 'push');
            app.PauseButton.ButtonPushedFcn = createCallbackFcn(app, @PauseButtonPushed, true);
            app.PauseButton.Tag = 'pause';
            app.PauseButton.BackgroundColor = [0.8 0.8 0.8];
            app.PauseButton.Position = [143 22 92 43];
            app.PauseButton.Text = 'Pause';

            % Create ResumeButton
            app.ResumeButton = uibutton(app.SettingsPanel, 'push');
            app.ResumeButton.ButtonPushedFcn = createCallbackFcn(app, @ResumeButtonPushed, true);
            app.ResumeButton.Tag = 'resume';
            app.ResumeButton.BackgroundColor = [0.8 0.8 0.8];
            app.ResumeButton.Position = [283 22 92 43];
            app.ResumeButton.Text = 'Resume';

            % Create StopButton
            app.StopButton = uibutton(app.SettingsPanel, 'push');
            app.StopButton.ButtonPushedFcn = createCallbackFcn(app, @StopButtonPushed, true);
            app.StopButton.Tag = 'stop';
            app.StopButton.BackgroundColor = [0.8 0.8 0.8];
            app.StopButton.Position = [425 22 92 43];
            app.StopButton.Text = 'Stop';

            % Create RecordButton
            app.RecordButton = uibutton(app.SettingsPanel, 'push');
            app.RecordButton.ButtonPushedFcn = createCallbackFcn(app, @RecordButtonPushed, true);
            app.RecordButton.Tag = 'record';
            app.RecordButton.BackgroundColor = [0.8 0.8 0.8];
            app.RecordButton.Position = [559 22 92 43];
            app.RecordButton.Text = 'Record';

            % Create VolumeSliderLabel
            app.VolumeSliderLabel = uilabel(app.SettingsPanel);
            app.VolumeSliderLabel.Tag = 'volume';
            app.VolumeSliderLabel.HorizontalAlignment = 'right';
            app.VolumeSliderLabel.Position = [691 35 45 22];
            app.VolumeSliderLabel.Text = 'Volume';

            % Create VolumeSlider
            app.VolumeSlider = uislider(app.SettingsPanel);
            app.VolumeSlider.ValueChangedFcn = createCallbackFcn(app, @VolumeSliderValueChanged, true);
            app.VolumeSlider.Position = [757 44 152 3];

            % Create AxesPanel
            app.AxesPanel = uipanel(app.UIFigure);
            app.AxesPanel.Title = 'Axes';
            app.AxesPanel.Scrollable = 'on';
            app.AxesPanel.Position = [1049 246 682 546];

            % Create UIAxes
            app.UIAxes = uiaxes(app.AxesPanel);
            title(app.UIAxes, 'FFT Graph')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [125 269 430 194];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.AxesPanel);
            title(app.UIAxes_2, 'FFT Graph')
            xlabel(app.UIAxes_2, 'X')
            ylabel(app.UIAxes_2, 'Y')
            zlabel(app.UIAxes_2, 'Z')
            app.UIAxes_2.Position = [125 15 430 194];

            % Create OriginalLabel
            app.OriginalLabel = uilabel(app.AxesPanel);
            app.OriginalLabel.HorizontalAlignment = 'center';
            app.OriginalLabel.Position = [281 478 160 22];
            app.OriginalLabel.Text = 'Original';

            % Create FilterLabel
            app.FilterLabel = uilabel(app.AxesPanel);
            app.FilterLabel.HorizontalAlignment = 'center';
            app.FilterLabel.Position = [281 221 160 22];
            app.FilterLabel.Text = 'Filter';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = equlizer_exported8

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end