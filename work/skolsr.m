function v2=skolsr(v,rasm,kolskol)
% ��������� �� ����������� ��������
% ����� �������:
%               skolsr
% ������������ �������:
%                      
% ������������ ������� MATLAB:
%                       mean     
% ������� ����������:
% v- ������ ���������� ���������
% kol_skol - ���-�� ��������� �� ������� ��������� �������
% rasm - ����� ������� ��� kol_skol

v2=zeros(size(v));
for tara2=1:rasm
   prom=0;
   for tara3=tara2:(kolskol+tara2)
      prom=prom+v(tara3);
   end
   %v2(tara2)=(sum(v(tara2:(tara2+kolskol))))/kolskol;
   v2(tara2)=prom/kolskol;
end   
