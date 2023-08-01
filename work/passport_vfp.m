function passport_vfp(dia_any,name_f_pas,f_zam,puti)
% passport3 эксперимент с меню данные вызываются из файла
% Вызов функции:
%               passport_vfp
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные: dia_any, path_f, name_f  


global gl_put; % путь к гл каталогу
global gl_fun; %название головной функции
path_f=puti{1,2};%Для стандартн файлов
path_f_vrem=puti{5,2};%путь до временного файла паспортов
path_f_pas=puti{3,2};%'C:\Matlab\Toolbox\work2\'; %путь до файла паспортов
%vrem_f_pas='vrem_pas.wks'; %название временного файла паспортов
kol_f_zam=length(f_zam(1,:)); %количество выбранных файлов замеров
mat_kol_f=[1:kol_f_zam]; % вектор-строка с порядковыми номерами всех файлов
%name_f=lower(f_zam(1).name); %название первого в списке файла данных
%break;
if dia_any>0
   %por_n_f=1; %порядковый номер файла берется из матрицы mat_kol_f
   n_f_pasvse=name_f_pas;% если вместо имени файла паспорта стоит 'все'
   
   %Чтение файла с паспортами замеров (формат **.wks(Lotus 1-2-3))
   % в массив ячеек
   
      if n_f_pasvse==0%strcmp('все',n_f_pasvse)==1
         name_fl_pas=dir([path_f_pas,'*.wks']);%Чтение из опр каталога имена файлов паспортов
         kol_f_=length(name_fl_pas);   %Определяем кол-во паспортов
         kol_f_pas=1:kol_f_;
      else 
         name_fl_pas=dir([path_f_pas,'*.wks']);
         %name_fl_pas=struct('name',name_f_pas);
         kol_f_pas=name_f_pas;
      end
      
      f_txt_zam = fopen([path_f_vrem,'Tree.txt'],'wt');
      
      fprintf(f_txt_zam,'Имя файла\n');
      for por_n_f=mat_kol_f
         pert =  cell2struct(lower(f_zam(1,por_n_f)),'name');
         fprintf(f_txt_zam,'%s\n',pert(1).name);
      end
      fclose(f_txt_zam);   
      
      f_txt_pas = fopen([path_f_vrem,'listpasp.txt'],'wt');
      n_n=0;     
      for por_n_f=kol_f_pas
         name_len1=length(name_fl_pas(por_n_f).name)-4;
         name_pr2=name_fl_pas(por_n_f).name;
         name_pr3=name_pr2(1:name_len1);
         if n_n==0
            fprintf(f_txt_pas,'%s',name_pr3);
         else
            fprintf(f_txt_pas,'\n%s',name_pr3);
         end
      n_n=n_n + 1;
      end
      fclose(f_txt_pas);
     root_dir= cd;
     n_path_f_pas2 = length(path_f_pas)-1;
     path_f_pas2 = path_f_pas(1:n_path_f_pas2);
     n_path_f_vrem2 = length(path_f_vrem)-1;
     path_f_vrem2 = path_f_vrem(1:n_path_f_vrem2);
     cd (path_f_vrem2);
   dos([path_f_vrem,'Viewpasp.exe ',' ',path_f_vrem,'Tree.txt',' ',path_f_vrem,'Listpasp.txt',' ',path_f_pas2]);
   cd (root_dir);
   exst_f = dir([path_f_vrem,'tree.wks']);
   if isempty(exst_f) == 0
      
      kol_f_zam2 = kol_f_zam + 1;
      bbb = WK1READ1([path_f_vrem,'tree.wks'],0,0,[1 1 1 1]);%Чтение первой строки
      %aaa = WK1READ1([path_f_pas,name_pr2],0,0,[1 1 1 1]);%Чтение первой строки
      vvv = WK1READ1([path_f_vrem,'tree.wks'],1,0,[1 1 kol_f_zam2 1]);%Предварительное чтение для нахождения кол-ва записей
      %kkk = [aaa;vvv];
      %wk1write1([path_f_vrem,vrem_f_pas],kkk,0,0)
      kol_met_f=length(vvv);
      load ([gl_put,'ust1.mat']);
      
      for met_f = 1:kol_met_f
         for prost_f = mat_kol_f
            if strcmp(vvv(met_f),lower(f_zam(1,prost_f)))==1
               A2(met_f)= prost_f;
            end
         end
      end
      
      save ([gl_put,'ust1.mat'],'A1','A2','A3');
   end      
   
   else
   stracta=fpas_read4(dia_any,path_f,name_f);
end
feval(gl_fun);
