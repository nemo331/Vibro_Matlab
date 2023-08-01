function osh=read_f_data(ggg,path_f_zam,A1,chast,chan,otsch,path_f_vrem,B);

% read_f_data функция чтения файла данных и сохранения в виде матрицы
% Вызов функции:
%               read_f_data(ggg,path_f_zam,A1,chast,chan,otsch);
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные: ggg-массив ячеек с паспортными данными
%  path_f_zam -путь до файлов с данными
%  A1 - массив с установками из гл окна
%  chast - частота опроса АЦП
%  chan - кол-во каналов опроса
%  otsch - количество отсчетов для одного канала 


% 
osh=0;
global gl_put; % путь к гл каталогу
% Чтение файла с коэффициентами для домножения на коды АЦП
% массивы K1 K2 K3 K4 K5 K6
load ([gl_put,'kof_mul.mat']);%c:\Matlab\Toolbox\work\kof_mul.mat

naz_f_zam2=ggg{1,2};
        for dxd=1:(length(naz_f_zam2));
           if strcmp(naz_f_zam2(dxd),'_')==1
              naz_f_zam2(dxd)=' ';
           end
        end

hi = waitbar(0,['Чтение файла ',naz_f_zam2,'. Ждите...']);
col=(1:otsch);  % массив под один канал
vremia=(col-1)./chast; %массив времен по отсчетам(строка)
vrem=vremia';      %массив времен по отсчетам(столбец)

% массив коэффициентов для домножения на коды АЦП
       switch ggg{1,34} % в зависимости от номера выбираем соотв набор коэф-тов 
         case 1
            koof=K1.*0.0025;%коэффициенты 0.025 и 0.25
         case 2
            koof=K2.*0.0025;%коэффициенты БКВ-1 (Шлейфовый осциллограф)
         case 3
            koof=K3.*0.0025;%коэффициенты БКВ-2(Выход пост. напряжения на ЭВМ)
         case 4
            koof=K4.*0.0025;%коэффициенты БКВ-2 (Шлейфовый осциллограф)
         case 5
            koof=K5.*0.0025;%коэффициенты БКВ-1(Выход пост. напряжения на ЭВМ)
         case 6
            koof=K6.*0.0025;%коэффициенты 1 (в кодах АЦП)
         case 7
            koof=K7.*0.0025;%коэффициенты 0.25
         case 8
            koof=K8.*0.0025;%коэффициенты БКВ-1 и БКВ-2 (Шлейфовый осциллограф)
         case 9
            koof=K9.*0.0025;%коэффициенты БКВ-2 и БКВ-1 (Шлейфовый осциллограф)
         case 10
            koof=K10.*0.0025;%коэффициенты занесенные в диал окне
         case 11
            koof=K11.*0.0025;%коэффициенты занесенные в диал окне
         end   
       
 %disp(koof)      
 str1=[path_f_zam,ggg{1,2}];
fil_zam=fopen (str1,'rb');
if fil_zam==-1
   close(hi)
   msgbox(['Не могу открыть файл ',str1],'Сообщение')
   return;
end
%установить позицию
%fseek(fil_zam,2*chan*(nach-1),'bof');
% Прочитать файл замера
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
%определение на соответствие длины файла с данными(sch_kol) и заданного
%количества отсчетов(chan*otsch) с последующей корректировкой заданного 
%значения
     real_otsch=(floor(sch_kol/chan));
     if real_otsch<otsch
        close(hi)
        msgbox(['Файл:',ggg{1,2},' меньше заданной длины'],'Сообщение')
        return;
     end
frt=zeros(chan,otsch);
  % Сортировка данных по замеру по каналам и отсчетам
  for sl_otsch=chan:chan:(otsch*chan)
     %disp(sl_otsch);
     frt(:,sl_otsch/chan)=mat((sl_otsch-(chan-1)):sl_otsch); 
     
  end
      %транспонировать массив(по столбцам-каналы по строкам-отсчеты)
      vrt=frt';
      waitbar(0.4)
      %disp(vrt(:,2));
      %format;
      % домножить на коэффициенты
      %disp (vrt(1:10,1));
      for sss=(B(16+1):B(16+chan))
         vrt(:,sss)=vrt(:,sss).*koof(sss); 
      end
      %disp (vrt(1:10,1))
      waitbar(0.6)
      % добавить столбец времен
      mass=[vrem,vrt];
      waitbar(0.8)    
%формирование названия mat-файла для сохранения массива с данными
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
 