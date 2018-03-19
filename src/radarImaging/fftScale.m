function [Y, fScale]  = fftScale(x, fs)
%  y - ������,
%  f - ��������� �����
%  t - ��������� �������
%  s - ������� ��������
% 
L = length(x) - rem(length(x),2); % ������ ���-�� �������� ����
x = x(1:L);

y = fft(x);
Y = abs(y/L);
Y = fftshift(Y);

fPos = fs*(0:L/2)/L;
fNeg = -flip(fPos(2:end-1));
fScale = [fNeg  fPos];


