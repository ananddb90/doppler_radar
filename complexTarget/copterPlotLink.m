function link = copterPlotLink( N )
%COPTERPLOTLINK 
%   ����������� ������ ����� :
%   ������ - ������
%   ������ �� ����������� ����

% posArr = [r1 r0 r2 ... c0]

num = N;

for k = 1 : num 
    link{k} = (k - 1) * 3 + [1 2 3] ;
end


end

