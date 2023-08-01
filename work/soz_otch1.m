function soz_otch(dia_any,name_f_pas,f_zam,puti)%naz_f

% soz_otch ����������� (������������) ������� ��� �������� �������
% ����� �������:
%               soz_otch1(dia_any,name_f_pas,f_zam)
% ��� dia_any-�����������(1) ��� ������������� ����(0)
% name_f_pas - �������� ����� ��������� (��� ����� ��������)
% f_zam - ��������� � ���������� ������ ������� ������� �������
% ������������ �������:
%                      
% ������������ ������� MATLAB:
%                            
% ������� ����������:

global gl_put; % ���� � �� ��������
global gl_fun;
%path_f_zam='C:\Matlab\Toolbox\work3\';
%fil_f_obr=lower(naz_f); %�������� ����� ������

% ������ ����� ��������� � ������ A1 � 18-��� �������
load ([gl_put,'ust1.mat'])%c:\Matlab\Toolbox\work\ust1.mat
%disp(A1);

vrem_f_pas='pasp.wks'; %�������� ���������� ����� ���������
vr_ot1='vr_otchet1.mat';
vr_ot2='vr_otchet_gar.mat';

if A1(1)>0
   path_f_zam=puti{1,2};
   path_f_vrem=puti{5,2};
   path_f_otch=puti{6,2};
   put_exl=puti{7,2};
   %�������� ���������� ����� ���������
   
   exst_f = dir(strcat(path_f_vrem,'Foxlab.exe'));
   if isempty(exst_f) == 0
      %������ ������� FOXPRO ��� ������ ����� ������ 
      ex_osh=soz_vr_pas_vfp(dia_any,name_f_pas,f_zam,vrem_f_pas,puti);
   else
      ex_osh=soz_vr_pas1(dia_any,name_f_pas,f_zam,vrem_f_pas,puti);
   end
   
   %ex_osh=1;
else
   path_f_zam=puti{2,2};
   feval(gl_fun);%�������� ���� �� �������� ���� ������ ��� ���� ������
   break;
end

if ex_osh==0, feval(gl_fun); break; end
kz=30;
uuu = WK1READ1([path_f_vrem,vrem_f_pas],0,0,[1 1 kz 40]);
%����� ���������� ������� �� ��������� ����� ���������
zap_f_pas=size(uuu,1);
vvv=uuu(2:zap_f_pas,:);

switch A1(1)
   case 1
      chast=400; %������� ������ ���
      chan=16;   %���-�� ������� ������
      otsch=7680;
      B = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
   case 0
      
   case 2
      load ([gl_put,'ust_pros.mat'])
      f_zam = vibor_f(f_zam,puti);
      B(67)= 0;
      B = obr_biv(lower(f_zam(1).name),puti,B);
      chast=B(35); 
      chan=B(67);
      pprm = 62.5/60;
      kol_lin = fix((B(37)*pprm)/chast);
      otsch=(chast/pprm)*kol_lin;
      B(67)=1;
   end

for nomer_fila=1:(zap_f_pas-1)
   %break;
      
      
 

   %������ �������� ����� ������ � ������������ � ���������
   %���������� � �������:vvv-������ ����� � ������� ���������
   % path_f_zam- ���� �� ����� ������
   % A1- ������ � ����������� �� ��. ����
   ex_osh=feval('read_f_data1',vvv(nomer_fila,:),path_f_zam,A1,...
      chast,chan,otsch,path_f_vrem,B);
   if ex_osh==0, feval(gl_fun); return; end
   % �������� ���������� ����� ������ ��� ���� ������
   % ��� �� ������ ���� ������ ��������� �������� (���� ����) � ������
   if A1(4)==1
      feval('soz_f_otch1',vvv(nomer_fila,:),path_f_zam,A1,...
         chast,chan,otsch,nomer_fila,vr_ot1,path_f_vrem,B);
   end
   
   % �������� ���������� ����� ������ �� ���������� ��� ���� ������
   % ��� �� ������ ���� ������ ��������� �������� ��� ���� �������� � ������
   if A1(5)==1
      feval('soz_otch_garm1',vvv(nomer_fila,:),A1,...
         chast,chan,otsch,nomer_fila,vr_ot2,path_f_vrem,B);
   end

   dlin_naz_f=length(vvv{nomer_fila,2});
   naz_mat_f=vvv{nomer_fila,2};
   naz_mat_f(dlin_naz_f-3:dlin_naz_f)=[];
   poln_naz_mat_f=[path_f_vrem,naz_mat_f,'.mat'];
   delete(poln_naz_mat_f)

end

% �������� �������� ���� ������ �� ������ (������, �������) � ������� ����
if A1(4)==1
      feval('soz_gr_otch1',uuu,path_f_vrem,A1,...
         vr_ot1,path_f_otch,put_exl);
end

% �������� �������� ���� ������ �� ������ (������, �������) � ������� ����
if A1(5)==1
     feval('soz_gr_garm1',uuu,path_f_vrem,A1,...
        vr_ot2,path_f_otch,put_exl);
     delete ([path_f_vrem,vr_ot2]);
end

delete ([path_f_vrem,vrem_f_pas]);
if A1(4)==1
      delete ([path_f_vrem,vr_ot1]);
end

feval(gl_fun);