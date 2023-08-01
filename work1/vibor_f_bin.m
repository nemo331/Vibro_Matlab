function probn = vibor_f_bin(f_zam,puti)

% ����� ����� bin
% ����� �������:
%               vibor_f_bin
% ������������ �������:
%                      
% ������������ ������� MATLAB:
%                            
% ������� ����������:

global gl_put; % ���� � �� ��������
kol_f_zam=length(f_zam);
path_f_zam=puti{1,2};
vibor = zeros(1,kol_f_zam);
p_biv=0;
for npp=1:kol_f_zam
   fil_f_obr=lower(f_zam(npp).name);
   str1=[path_f_zam,fil_f_obr];
   fil_zam=fopen (str1,'rb');
   if fil_zam==-1
      msgbox(['�� ���� ������� ���� ',str1],'���������')
      break;
   end
   
   % ��������� ���� ������
   kod_char=(fread(fil_zam,8,'char'))';
   str_kod = sprintf('%s',kod_char);
   if (strcmp (str_kod,'vibracia'))==0
      vibor(npp)=1;     
   end 
   fclose(fil_zam);
end
ex_n=0;
flag =0;
for npp=1:kol_f_zam
   if vibor(npp)==1
      ex_n=ex_n+1;
      if ex_n == 1
         probn=f_zam(npp);
      else
         probn=[probn;f_zam(npp)];
      end   
   else
      flag = 1;
   end
end

if (flag==1)
   msgbox(['��������� ����� ������� �� ��������� ��-�� �������������� ����'],'���������')
end
