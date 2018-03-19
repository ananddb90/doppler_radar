% 
clc
clear
close all

% -------------------------------------------------------------------------
% --- Initialisation

% ��������� ����  
% 'Target' OR 'TargetCopter' OR 'TargetHuman'
tgOpt.targetType    = 'TargetHuman'; 
% --- TargetCopter �ptions
tgOpt.numBlade    = 2;                  % ���-�� ����������� � �������������
tgOpt.rotFreq     = 100;                  % ������� �������� ����������
% --- moving options
tgOpt.absVelocity   = 10;                % ������ �������� 
tgOpt.traceType     = 'TraceCircle'; % 'TraceReclinear' OR 'TraceCircle' 
% --- options TraceRecliniar 
tgOpt.traceAz       = 0;                % ����������� �������� �� ��� X
tgOpt.traceRotation = [0 0]; % [Azimut Elevation] % ������� �������� �������� ������������ ������
% --- options TraceCircle 
tgOpt.traceRadius   = 2;                % ������ ���������� ��� �������� ����������
tgOpt.position      = [500 0 0];% ��������� ���������� ����. 


% ��������� ���
rdOpt.carrierFreq       = 9e9;          % ������� ������� ������
rdOpt.pulseRate         = 8e3;         % ������� ���������� ���������
rdOpt.pulseFormId       = 1;            % ������ ������������ ����� ���������.
rdOpt.rangeResolution   = 30;           % ���������� �� ���������
rdOpt.rangeLim          = sqrt(sum(tgOpt.position.^2)) + [ -1 1 ]*50;
rdOpt.frameBufferImageTimeLim   = 0.05;  % ��������� �������, ������������� ������� � 'Pulse accumulation long-time frame'
rdOpt.lenSpertrAccum    = 1024;     % ����� ������� Short-time Fourier transform
rdOpt.windowsFftLen     = 128;          % ������ ���� � STFT



[ tg, rf ] = radarSceneInit( tgOpt, rdOpt );
% tg - ��������� � ����������� �� ������ ����
% rf - ��������� � ����������� �� ������� ���������������� �������

% ---
dRadc = 3e8 / rf.radar.fadc_ / 2;       % ������� ��������� � ������� ���
% ����� ������ ��������� � �����
tgChen = ceil( ( sqrt(sum(tgOpt.position.^2)) - rdOpt.rangeLim(1)) / dRadc );
meanFreq = 2*tgOpt.absVelocity / (3e8 / rdOpt.carrierFreq )



% -------------------------------------------------------------------------
% --- Execution
timeSimulation = 20 / tgOpt.absVelocity ;                 % ����� ������������� 


% ��������� ��� �������������
timeStep = 1 / tgOpt.absVelocity / 50;
tPause = 0.08;

if max(tgOpt.traceRotation) > 0     % ���� ���� ���������
    dt = 2 / rdOpt.pulseRate;
    tPause = 0;
end

tBias = 1e-9;
T = 0 : timeStep : timeSimulation;

hAx = demoWindow;
lastSampleSpectrumPlot = 0;

for n = 1 : (length(T)-1)
    t1 = T(n);
    t2 = T(n+1) - tBias;
    w = rf.radar.echoComplexTarget( [ t1 t2 ], tg.target);
    rf.radarImager.pushBuffer( w );
    
    rf.radarImager.imageBuffer( hAx.ax2);
    tg.target.drawObj(t1, hAx.ax1);
    
    rf.radarImager.trackSpectrum( tgChen )
    if rf.radarImager.numPulses_ - lastSampleSpectrumPlot > rdOpt.windowsFftLen
        rf.radarImager.imageSpecgramm( hAx.ax3 );
        lastSampleSpectrumPlot = rf.radarImager.numPulses_;
    end
    
    pause(tPause)
    drawnow    
end






