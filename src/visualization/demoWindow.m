function handles = demoWindow
% ��������� ���� ������������ ����������, ������� ���������� ������ �� 
% �������� ������������ ����������.


%  Create and then hide the UI as it is being constructed.
handles.f = figure('Position',[900, 40, 1000, 900], ...
                   'MenuBar','none','toolbar', 'none',...
                   'Clipping', 'off', 'DockControls', 'off');

% Construct the components.

handles.ax1 = axes('Units','pixels','Position',[50,50, 460-40, 400-40]);
title(handles.ax1, 'Target moving')

handles.ax2 = axes('Units','pixels','Position',[400+2*50+30,50, 460-40, 400-40]);
title(handles.ax2, 'Pulse accumulation long-time frame')
xlabel(handles.ax2,'Time, [ sec ]')
ylabel(handles.ax2,'Range, [ m ] ')


%f2 = figure('Position',[250, 20, 800, 500], 'toolbar', 'none','MenuBar','none');

handles.ax3 = axes('Units','pixels','Position',[100, 480, 880, 400]);

colormap(handles.ax3, 'jet' )
view(handles.ax3,0,-90);
title(handles.ax3, 'Micro-Doppler Spectrogramm')
xlabel(handles.ax3,'Time, [sec]')
ylabel(handles.ax3,'Frequency, [Hz] ')
% xlabel('Dht')
% Initialisation components.

end