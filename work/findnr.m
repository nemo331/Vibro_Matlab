function num_r=findnr(podr,sterka)
%FINDNR ������� ����� ������ � ������� ����� ����������� �� �������
%����� �������:
%  num_r=findnr(podr,sterka)
%  ,��� podr-��� ���������� ������ �����
%       sterka-��� ������.
%������������ �������: length, strcmp.

chislo=length(podr);
      for ddd=1:chislo
          num_r=strcmp(podr{ddd},sterka);
          if num_r==1 
             num_r=ddd;
             break;
          end
       end 
