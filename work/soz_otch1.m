function soz_otch(dia_any,name_f_pas,f_zam,puti)%naz_f

% soz_otch центральная (родительская) функция при создании отчетов
% Вызов функции:
%               soz_otch1(dia_any,name_f_pas,f_zam)
% где dia_any-стандартный(1) или нестандартный файл(0)
% name_f_pas - название файла паспортов (или файла паспорта)
% f_zam - структура с названиями файлов замеров которые выбраны
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные:

global gl_put; % путь к гл каталогу
global gl_fun;
%path_f_zam='C:\Matlab\Toolbox\work3\';
%fil_f_obr=lower(naz_f); %название файла данных

% Чтение файла установок в массив A1 с 18-тью числами
load ([gl_put,'ust1.mat'])%c:\Matlab\Toolbox\work\ust1.mat
%disp(A1);

vrem_f_pas='pasp.wks'; %название временного файла паспортов
vr_ot1='vr_otchet1.mat';
vr_ot2='vr_otchet_gar.mat';

if A1(1)>0
   path_f_zam=puti{1,2};
   path_f_vrem=puti{5,2};
   path_f_otch=puti{6,2};
   put_exl=puti{7,2};
   %создание временного файла паспортов
   
   exst_f = dir(strcat(path_f_vrem,'Foxlab.exe'));
   if isempty(exst_f) == 0
      %Запуск функции FOXPRO для поиска необх файлов 
      ex_osh=soz_vr_pas_vfp(dia_any,name_f_pas,f_zam,vrem_f_pas,puti);
   else
      ex_osh=soz_vr_pas1(dia_any,name_f_pas,f_zam,vrem_f_pas,puti);
   end
   
   %ex_osh=1;
else
   path_f_zam=puti{2,2};
   feval(gl_fun);%временно пока не написана созд отчета для нест файлов
   break;
end

if ex_osh==0, feval(gl_fun); break; end
kz=30;
uuu = WK1READ1([path_f_vrem,vrem_f_pas],0,0,[1 1 kz 40]);
%найти количество записей во временном файле паспортов
zap_f_pas=size(uuu,1);
vvv=uuu(2:zap_f_pas,:);

switch A1(1)
   case 1
      chast=400; %частота опроса АЦП
      chan=16;   %кол-во каналов опроса
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
      
      
 

   %чтение текущего файла данных в соответствии с паспортом
   %передается в функцию:vvv-массив ячеек с данными паспортов
   % path_f_zam- путь до файла данных
   % A1- массив с установками из гл. окна
   ex_osh=feval('read_f_data1',vvv(nomer_fila,:),path_f_zam,A1,...
      chast,chan,otsch,path_f_vrem,B);
   if ex_osh==0, feval(gl_fun); return; end
   % создание временного файла отчета для всех файлов
   % где по кажому выбр каналу амплитуда вибрации (выбр типа) и оценка
   if A1(4)==1
      feval('soz_f_otch1',vvv(nomer_fila,:),path_f_zam,A1,...
         chast,chan,otsch,nomer_fila,vr_ot1,path_f_vrem,B);
   end
   
   % создание временного файла отчета по гармоникам для всех файлов
   % где по кажому выбр каналу амплитуды вибрации для выбр гармоник и оценка
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

% создание выходных граф данных по отчету (график, таблица) и текстов файл
if A1(4)==1
      feval('soz_gr_otch1',uuu,path_f_vrem,A1,...
         vr_ot1,path_f_otch,put_exl);
end

% создание выходных граф данных по отчету (график, таблица) и текстов файл
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