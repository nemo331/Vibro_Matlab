function osh=read_f_data(ggg,path_f_zam,A1,chast,chan,otsch,path_f_vrem,B);

% read_f_data ������� ������ ����� ������ � ���������� � ���� �������
% ����� �������:
%               read_f_data(ggg,path_f_zam,A1,chast,chan,otsch);
% ������������ �������:
%                      
% ������������ ������� MATLAB:
%                            
% ������� ����������: ggg-������ ����� � ����������� �������
%  path_f_zam -���� �� ������ � �������
%  A1 - ������ � ����������� �� �� ����
%  chast - ������� ������ ���
%  chan - ���-�� ������� ������
%  otsch - ���������� �������� ��� ������ ������ 


% 
osh=0;
global gl_put; % ���� � �� ��������
% ������ ����� � �������������� ��� ���������� �� ���� ���
% ������� K1 K2 K3 K4 K5 K6
load ([gl_put,'kof_mul.mat']);%c:\Matlab\Toolbox\work\kof_mul.mat

naz_f_zam2=ggg{1,2};
        for dxd=1:(length(naz_f_zam2));
           if strcmp(naz_f_zam2(dxd),'_')==1
              naz_f_zam2(dxd)=' ';
           end
        end

hi = waitbar(0,['������ ����� ',naz_f_zam2,'. �����...']);
col=(1:otsch);  % ������ ��� ���� �����
vremia=(col-1)./chast; %������ ������ �� ��������(������)
vrem=vremia';      %������ ������ �� ��������(�������)

% ������ ������������� ��� ���������� �� ���� ���
       switch ggg{1,34} % � ����������� �� ������ �������� ����� ����� ����-��� 
         case 1
            koof=K1.*0.0025;%������������ 0.025 � 0.25
         case 2
            koof=K2.*0.0025;%������������ ���-1 (��������� �����������)
         case 3
            koof=K3.*0.0025;%������������ ���-2(����� ����. ���������� �� ���)
         case 4
            koof=K4.*0.0025;%������������ ���-2 (��������� �����������)
         case 5
            koof=K5.*0.0025;%������������ ���-1(����� ����. ���������� �� ���)
         case 6
            koof=K6.*0.0025;%������������ 1 (� ����� ���)
         case 7
            koof=K7.*0.0025;%������������ 0.25
         case 8
            koof=K8.*0.0025;%������������ ���-1 � ���-2 (��������� �����������)
         case 9
            koof=K9.*0.0025;%������������ ���-2 � ���-1 (��������� �����������)
         case 10
            koof=K10.*0.0025;%������������ ���������� � ���� ����
         case 11
            koof=K11.*0.0025;%������������ ���������� � ���� ����
         end   
       
 %disp(koof)      
 str1=[path_f_zam,ggg{1,2}];
fil_zam=fopen (str1,'rb');
if fil_zam==-1
   close(hi)
   msgbox(['�� ���� ������� ���� ',str1],'���������')
   return;
end
%���������� �������
%fseek(fil_zam,2*chan*(nach-1),'bof');
% ��������� ���� ������
switch A1(1)
case 1
   [mat,sch_kol]=fread(fil_zam,chan*otsch,'short');
case 2
   fseek(fil_zam,128,'bof');
   [mat,sch_kol]=fread(fil_zam,chan*otsch,'short');
end


%disp(sch_kol);
fclose(fil_zam);
waitbar(0.2)
%����������� �� ������������ ����� ����� � �������(sch_kol) � ���������
%���������� ��������(chan*otsch) � ����������� �������������� ��������� 
%��������
     real_otsch=(floor(sch_kol/chan));
     if real_otsch<otsch
        close(hi)
        msgbox(['����:',ggg{1,2},' ������ �������� �����'],'���������')
        return;
     end
frt=zeros(chan,otsch);
  % ���������� ������ �� ������ �� ������� � ��������
  for sl_otsch=chan:chan:(otsch*chan)
     %disp(sl_otsch);
     frt(:,sl_otsch/chan)=mat((sl_otsch-(chan-1)):sl_otsch); 
     
  end
      %��������������� ������(�� ��������-������ �� �������-�������)
      vrt=frt';
      waitbar(0.4)
      %disp(vrt(:,2));
      %format;
      % ��������� �� ������������
      %disp (vrt(1:10,1));
      for sss=(B(16+1):B(16+chan))
         vrt(:,sss)=vrt(:,sss).*koof(sss); 
      end
      %disp (vrt(1:10,1))
      waitbar(0.6)
      % �������� ������� ������
      mass=[vrem,vrt];
      waitbar(0.8)    
%������������ �������� mat-����� ��� ���������� ������� � �������
dlin_naz_f=length(ggg{1,2});
naz_mat_f=ggg{1,2};
naz_mat_f(dlin_naz_f-3:dlin_naz_f)=[];
poln_naz_mat_f=[path_f_vrem,naz_mat_f,'.mat'];
save (poln_naz_mat_f, 'mass')
waitbar(1)
%clear mass
%load (poln_naz_mat_f)
%disp(mass)  
 close(hi)

osh=1;
return;
 