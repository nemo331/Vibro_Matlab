function obr(f_zam,puti)

% Просмотр файла замера вибрации
% Вызов функции:
%               obr
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные:

global gl_put; % путь к гл каталогу
global gl_fun; %название головной функции
global kof;% коэф для изменения размеров упр элементов
%fil_f_obr=dir([path_f_zam,naz_f]);
%fil_pas='C:\Matlab\Toolbox\work2\Список_замеров2.wks';

% Чтение файла установок в массив A1 с 18-тью числами
load ([gl_put,'ust1.mat']);%c:\Matlab\Toolbox\work\ust1.mat
%disp(A1);
 % Чтение файла установок для просмотра в массив B с 42-мя числами
if A1(1)>0
   %для стандартного файла
   path_f_zam=puti{1,2};
   load ([gl_put,'ust_pros.mat']);%c:\Matlab\Toolbox\work\ust_pros.mat 
   else
   %для нестандартного файла
   path_f_zam=puti{2,2};
   load ([gl_put,'ust_pros1.mat']);%c:\Matlab\Toolbox\work\ust_pros1.mat
end
load ([gl_put,'ust_stat.mat']);
path_f_vrem=puti{5,2}; %путь к директории врем файлов
%disp(B);
%break;  
% Чтение файла с коэффициентами для домножения на коды АЦП
% массивы K1 K2 K3 K4 K5 K6 K7
load ([gl_put,'kof_mul.mat']);%c:\Matlab\Toolbox\work\kof_mul.mat
if A1(1)==2
   f_zam = vibor_f(f_zam,puti);%проверка на соответствие друг другу всех выбранных файлов
else
   f_zam = vibor_f_bin(f_zam,puti);
end

  kol_f_zam=length(f_zam); %количество выбранных файлов замеров
 
    
  
    
    win1=figure; % формируем окно аварийного останова
    set(win1,'Position',[850/kof,400/kof,100/kof,150/kof]); % позиция и размеры окна
    uicontrol('Style','text','String','Окно останова',...
          'Position',[20/kof 100/kof 80/kof 50/kof],'FontSize',10);
    ok = uicontrol('Style','Pushbutton','Position',...
    [20/kof 20/kof 80/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
    'String','Стоп','UserData',0); 
    gg=0;
 
    for por_n_fila=1:kol_f_zam
    
      gg=get(ok,'UserData'); % обработка нажатия на кнопку "Стоп"
      if gg==1
         close(win1);
         feval(gl_fun);
         return;
      end
      
   
   fil_f_obr=lower(f_zam(por_n_fila).name);
   
   dl=length(fil_f_obr);
   fil_f_obr2=fil_f_obr;
        for dxd=1:dl
           if strcmp(fil_f_obr2(dxd),'_')==1
              fil_f_obr2(dxd)=' ';
           end
        end
        perch=fil_f_obr2(1:(dl-4));
        perch2=fil_f_obr2((dl-3):dl);

uu3 = waitbar(0,['Идет обработка. Файл:',perch,perch2]);

B(67)= 1;
B = obr_biv(fil_f_obr,puti,B);



chast=B(35); %частота опроса АЦП
 
chan=0;   %кол-во каналов опроса
for ddd=1:16
   if B(ddd+16)<17 % проверка,есть номер канала или нет (17- нет канала)
      chan=chan+1;
      kanalu(chan)=B(ddd+16);%строка (номера каналов в массиве kanalu)
   end
end

nach=B(36);
kon=B(37);
otsch=kon-nach+1;  %кол-во отсчетов замера(должно быть число которое делится на два без остатка)
col=(nach:kon);  % массив под один канал
vremia=(col-1)./chast; %массив времен по отсчетам(строка)
vrem=vremia';     %массив времен по отсчетам(столбец)
clear col vremia
%массив отсчеты x каналы
%frt=[col;col;col;col;col;col;col;col;col;col;col;col;col;col;col;col];
% массив коэффициентов для домножения на коды АЦП
       switch B(41) % в зависимости от номера выбираем соотв набор коэф-тов 
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

str1=[path_f_zam,fil_f_obr];
fil_zam=fopen (str1,'rb');
if fil_zam==-1
   msgbox(['Не могу открыть файл ',str1],'Сообщение')
   break;
end
%установить позицию
if B(68) == 1
   fseek(fil_zam,2*chan*(nach-1)+ 128,'bof');
else
   fseek(fil_zam,2*chan*(nach-1),'bof');
end
   
% Прочитать файл замера
[mat,sch_kol]=fread(fil_zam,chan*otsch,'short');
%disp(sch_kol);
fclose(fil_zam);
%определение на соответствие длины файла с данными(sch_kol) и заданного
%количества отсчетов(chan*otsch) с последующей корректировкой заданного 
%значения
     real_otsch=(floor(sch_kol/chan));
     if real_otsch<otsch
        msgbox('Заданное кол-во отсчетов больше длины файла данных','Сообщение')
     end
     otsch=(floor(real_otsch/2))*2;
     waitbar(0.1);
     frt=zeros(chan,otsch);
  % Сортировка данных по замеру по каналам и отсчетам
  for sl_otsch=chan:chan:(otsch*chan)
     frt(:,sl_otsch/chan)=mat((sl_otsch-(chan-1)):sl_otsch); 
  end
  waitbar(0.2);
      clear mat
      if (B(41)==3)|(B(41)==5)|(B(41)==11)
         %транспонировать массив(по столбцам-каналы по строкам-отсчеты)
         vrt=frt'-2048;
      else
         vrt=frt';
      end
      clear frt 
      %disp(vrt(:,2));
      %format;
      waitbar(0.3);
      % домножить на коэффициенты
      %disp (vrt(1:10,1));
      for sss=1:chan
         vrt(:,sss)=vrt(:,sss).*koof(kanalu(sss));
      end
      %disp (vrt(1:10,1));
      %vrem((otsch+1):length(vrem))=[];
      %dddddl=length(vrem)
      % добавить столбец времен
      mass=[vrem(1:otsch),vrt];
      mass_skl=[vrem(1:otsch),vrt];
      
      %disp(mass_dest);
      spectr=[vrem(1:otsch),vrt];  
      % Очистить область памяти от ненужных переменных
      clear vremia vrt       
      
      if B(33)==1   %если совмещать отметчик с виброграммой 
         B(B(34))=1;% добавить позицию канала отметчика 
         nom_chan_otm=kanalu(B(34)); % номер канала отметчика 
      end
      nom_chan = (find(B(1:16)));
      nom_kanalu= find(kanalu);
      %disp (kanalu)
      dosia=0;
      for tyu=nom_chan
         dosia=dosia+1;
         probna(dosia)=find(nom_kanalu==tyu)+1;
      end
      nom_chan=probna;
 
      %break;
      if B(40)==1
         % Удаление постоянной составляющей сигнала
         
         for tyu=nom_chan%2:(chan+1)
         sredina=mean(mass(:,tyu));
         mass(:,tyu)=mass(:,tyu)-sredina;
         end
      end
      dest=zeros(1,chan);
      % Вычисление действующего значения
      for tyu=nom_chan%2:(chan+1)
         sredina=mean(abs(mass(:,tyu)));
         dest(tyu-1)=sredina;
      end
      if por_n_fila==1
           mas_dest=[(1:chan);dest];
      else
           mas_dest=[mas_dv_amp;dest];
      end
      %disp(mas_dest)
      waitbar(0.3);
       probnaia=(1:chan);
      %Разложение в ряд фурье
     for tyu=nom_chan%2:(chan+1)
        spectr(:,tyu)=abs(fft(mass(:,tyu))/(otsch/2));
        dfd=find(max(spectr(1:otsch/2,tyu))==spectr(1:otsch/2,tyu));
        probnaia(tyu-1)= dfd(1);
        probnaia(tyu-1)=fix(otsch/probnaia(tyu-1));
        %probnaia(tyu-1)=abs(sum(fft(mass(:,tyu))/(otsch/2)))
        spectr(:,tyu)=spectr(:,tyu).*2;
     end
     %break;
     %t2=(0:((otsch-1)/2))/(otsch/2)*(chast/2);
     t2=(0:((otsch-1)/2))/(otsch/chast);
     %disp(t2');
     spectr(1:(otsch/2),1)=t2';
     spectr((otsch/2+1):otsch,:)=[];
        waitbar(0.4);
     %Двойная амплитуда вибрации
     max_vib=(1:chan);
     min_vib=(1:chan);
     dva_vib=(1:chan);
     for tara=nom_chan%2:(chan+1)
        max_vib(tara-1)=(round(max(mass(:,tara))*100))/100;    
        min_vib(tara-1)=(round(min(mass(:,tara))*100))/100;
        dva_vib(tara-1)=max_vib(tara-1)-min_vib(tara-1);
     end
     
     sr_ob_max=(1:chan);
     sr_ob_min=(1:chan);
     sr_ob_dva=(1:chan);
     for tara=nom_chan%2:(chan+1)
        promezh1=zeros(1,(fix(otsch/probnaia(tara-1))));
        promezh2=zeros(1,(fix(otsch/probnaia(tara-1))));
        for tyu=1:(fix(otsch/probnaia(tara-1)))
           promezh1(tyu)=(round(max(mass(((tyu-1)*probnaia(tara-1)+1):(tyu*probnaia(tara-1)),tara))*100))/100;
           promezh2(tyu)=(round(min(mass(((tyu-1)*probnaia(tara-1)+1):(tyu*probnaia(tara-1)),tara))*100))/100;
       end
       sr_ob_max(tara-1)=mean(promezh1);
       sr_ob_min(tara-1)=mean(promezh2);
       sr_ob_dva(tara-1)=sr_ob_max(tara-1)-sr_ob_min(tara-1);
       %disp(sr_ob_dva(tara-1))
     end

     
      if por_n_fila==1
           mas_dv_amp=[(1:chan);dva_vib];
      else
           mas_dv_amp=[mas_dv_amp;dva_vib];
      end
     
        waitbar(0.5);
     %Среднеквадратичное значение вибрации
     SKZ2A=(1:chan);
     for tara=nom_chan%2:(chan+1)
        SKZ2A(tara-1)=(round(sqrt(sum((spectr(:,tara).^2)./2))*100))/100;
        %SKZ2A(tara-1)=(round(sqrt(sum((spectr(:,tara).^2)./1.4142))*100))/100;
        %SKZ2A(tara-1)=(sqrt((sum(mass(:,tara).^2))/otsch))*2;
     end
     
     if por_n_fila==1
           mas_skz=[(1:chan);SKZ2A];
      else
           mas_skz=[mas_skz;SKZ2A];
      end
         close(uu3)
     %Амплитуда вибрации по скользящему среднему по 31-ому
     
     max_vib_skl=(1:chan);
     min_vib_skl=(1:chan);
     dva_vib_skl=(1:chan);
     if B(38)==1 %Если 1, то делать обработку по скользящему среднему 
        kol_skol=B(39);
        rasm=otsch-kol_skol;
        uu4 = waitbar(0,['Обработка по скользящему среднему.Файл:',perch,perch2]);
        %tic
        for tara=nom_chan%2:4%(chan+1)
           waitbar(tara/length(nom_chan));
           %Вызов функции обработки по сколзящему среднему
           
           mass_skl(:,tara)=skolsr(mass(:,tara),rasm,kol_skol);
           
           %mass_skl(end-kol_skol:end,tara)=0;
           max_vib_skl(tara-1)=(round(max(mass_skl(:,tara))*100))/100;    
           min_vib_skl(tara-1)=(round(min(mass_skl(:,tara))*100))/100;
           dva_vib_skl(tara-1)=max_vib_skl(tara-1)-min_vib_skl(tara-1);
        end
        %toc
        %disp(mass_skl)
        close(uu4)
        if por_n_fila==1
           mas_skl_sr=[(1:chan);dva_vib_skl];
        else
           mas_skl_sr=[mas_skl_sr;dva_vib_skl];
        end
     else
        dva_vib_skl=dva_vib_skl.*0;
     end
          uu5 = waitbar(0.6,['Идет обработка. Файл:',perch,perch2]);
     massa=mass(1:otsch,[1 nom_chan]);
     spectra=spectr(:,[1 nom_chan]);
     %disp(nom_chan);
     %сохранение в файле значений вибрации
     dlin_naz_f=length(fil_f_obr);
     fil_f_obr(dlin_naz_f-3:dlin_naz_f)=[];
     if B(42)==1
        poln_naz_wk_v=[path_f_zam,fil_f_obr,'v.wk1'];
        wk1write(poln_naz_wk_v,massa,0,0);
        dr_naz_wk_v=[path_f_vrem,'wk_v.wk1'];
        wk1write(dr_naz_wk_v,massa,0,0);
     end
     
     if B(43)==1
        if (B(41)~=3)|(B(41)~=5)
           poln_naz_wk_f=[path_f_zam,fil_f_obr,'f.wk1'];
           wk1write(poln_naz_wk_f,spectra,0,0);
           dr_naz_wk_f=[path_f_vrem,'wk_f.wk1'];
           wk1write(dr_naz_wk_f,spectra,0,0);
        end
     end
     
       waitbar(0.8); 
    if B(45)==1 % условия выводить графики в окне(ах)
     kol_ot1=ceil((otsch*40)/chast);
     kol_ot2=ceil((otsch*98)/chast);
     kol_ot3=ceil((otsch*102)/chast);
     %odno=1;
     if B(44)==1 % условие графики в одном окне
        
        tip_lin={'k-','m-','r-','b-','g-','k:','m:','r:',...
              'b:','g:','k-x','m-x','r-x','b-x','k-o','m-o'};
        % Создание матрицы для легенды графика
        kan_str=char(ones(length(nom_chan),6));
        kkk=0;
        figure;
        for tyu=nom_chan
           
           kkk=kkk+1;
           % Занесение данных в матрицу
           if kanalu(tyu-1)<10
              kan_str(kkk,:)=sprintf('Кан  %d',kanalu(tyu-1));
           else
              kan_str(kkk,:)=sprintf('Кан %d',kanalu(tyu-1));
           end
           hold on
           subplot(2,1,1),...
              plot(mass(1:otsch,1),mass(1:otsch,tyu),tip_lin{kkk});
            hold off
        stroka=sprintf('Виброперемещение( Файл: %s%s)',perch,perch2);
        title(stroka);
           grid on;
           zoom on;
           
         
           
           if kol_ot1<otsch/2 
              hold on
           subplot(2,2,3),...
              plot(spectr(1:kol_ot1,1),spectr(1:kol_ot1,tyu),tip_lin{kkk});
            hold off
            title('Спектр мощности сигнала')
            xlabel('Частота, Гц')
            ylabel('Амплитуда(2А), мкм')
           grid on;
           zoom on;
           end
        
           if kol_ot3<otsch/2
              hold on
           subplot(2,2,4),...
              plot(spectr(kol_ot2:kol_ot3,1),spectr(kol_ot2:kol_ot3,tyu),tip_lin{kkk});
           hold off
           title('Спектр мощности сигнала')
           xlabel('Частота, Гц')
           ylabel('Амплитуда(2А), мкм')
           grid on;
           zoom on;
           end
           pause(0)
        end
        if length(nom_chan)>6
           siz=round((57+length(nom_chan))/length(nom_chan));
        else
           siz=10;
        end
        set(gca,'FontSize',siz);
        legend(kan_str,-1);
        set(gca,'FontSize',10);
           waitbar(0.9);
     else %иначе в нескольких окнах
        
     for tyu=nom_chan%3:2:7%(chan+1) цикл по каналам для окон графиков
        figure;
        if B(33)==1
           kofi=max_vib(find(kanalu== nom_chan_otm))/max_vib(tyu-1);
           mass(:,(find(kanalu==nom_chan_otm)+1))=mass(:,(find(kanalu==nom_chan_otm)+1))./kofi;
        subplot(2,1,1),...
           plot(mass(1:otsch,1),[mass(1:otsch,tyu) mass(1:otsch,(find(kanalu==nom_chan_otm)+1))]);
           mass(:,(find(kanalu==nom_chan_otm)+1))=mass(:,(find(kanalu==nom_chan_otm)+1)).*kofi;
        else
        subplot(2,1,1),...
           plot(mass(1:otsch,1),mass(1:otsch,tyu));
        end
        
        stroka=sprintf('Виброперемещение( Канал %d,Файл: %s%s)',...
           kanalu(tyu-1),perch,perch2);
        title(stroka);
        if B(38)==1 
           stroka2=sprintf('2Апик=%.2f мкм  СКЗ(2А)=%.2f мкм  Скользящее среднее(2A)=%.2f мкм  Время, сек',...
              dva_vib(tyu-1),SKZ2A(tyu-1),dva_vib_skl(tyu-1));
        else
           stroka2=sprintf('2Апик=%.2f мкм  СКЗ(2А)=%.2f мкм  Время, сек',...
              dva_vib(tyu-1),SKZ2A(tyu-1));
        end
        
        
        xlabel(stroka2)
        ylabel('Амплитуда, мкм')
        grid on;
        zoom on;
        
        %disp(spectr)
        %disp(spectr)
        if kol_ot1<otsch/2 
           subplot(2,2,3),...
              plot(spectr(1:kol_ot1,1),spectr(1:kol_ot1,tyu));
           title('Спектр мощности сигнала')
           xlabel('Частота, Гц')
           ylabel('Амплитуда(2А), мкм')
           grid on;
           zoom on;
        end
        
        if kol_ot3<otsch/2
           subplot(2,2,4),...
              plot(spectr(kol_ot2:kol_ot3,1),spectr(kol_ot2:kol_ot3,tyu));
           title('Спектр мощности сигнала')
           xlabel('Частота, Гц')
           ylabel('Амплитуда(2А), мкм')
           grid on;
           zoom on;
        end  
        pause(0)
        waitbar(1);
     end % конец цикла по каналам для окон графиков
  end % конец условия в одном окне или нескольких
  end % конец условия выводить графики в окне(ах)
  %who;
      close(uu5)
  clear  dva_vib_skl mass_skl siz dxd massa sl_otsch max_vib spectr fil_f_obr...
  max_vib_skl  spectra fil_zam min_vib sredina min_vib_skl sss str1 kan_str ...
  stroka nom_kanalu t2 SKZ2A kkk tara tara2 kol_ot1 perch tip_lin kol_ot2 perch2 tyu... 
  kol_ot3 por_n_fila uu1 dl kol_skol probna uu2 dlin_naz_f uuu dosia real_otsch...    
  dva_vib mass sch_kol
  %who;
end
prob=(1:chan);
prob(nom_chan-1)=[];
mas_dv_amp(:,prob)=[];% выделение данных по выбранным каналам
mas_skz(:,prob)=[];
mas_dest(:,prob)=[];
% Создание файла с амплитудными данными по каналам и замерам
otch_cell1=cell(kol_f_zam,1);
for por_n_fila=1:kol_f_zam
   otch_cell1(por_n_fila)=struct2cell(f_zam(por_n_fila));
end
mas_dv_amp_cel=num2cell(mas_dv_amp);
for n_pp=1:length(nom_chan)
   mas_dv_amp_cel{1,n_pp}=['Кан.',int2str(mas_dv_amp_cel{1,n_pp})];
end
otch_cell1_dv=[{'Пик. зн. вибрац.2Апик'};otch_cell1];
mas_dv_amp_cel=[otch_cell1_dv,mas_dv_amp_cel];

mas_skz_cel=num2cell(mas_skz);
for n_pp=1:length(nom_chan)
   mas_skz_cel{1,n_pp}=['Кан.',int2str(mas_skz_cel{1,n_pp})];
end
otch_cell1_skz=[{'Сркв. зн. вибрац.2Асркв'};otch_cell1];
mas_skz_cel=[otch_cell1_skz,mas_skz_cel];

vuh_mas=[mas_dv_amp_cel;mas_skz_cel];
if B(38)==1
   mas_skl_sr(:,prob)=[];
   mas_skl_sr_cel=num2cell(mas_skl_sr);
   for n_pp=1:length(nom_chan)
      mas_skl_sr_cel{1,n_pp}=['Кан.',int2str(mas_skl_sr_cel{1,n_pp})];
   end
   otch_cell1_skl=[{'Скол.ср. зн. вибрац.2Асклср'};otch_cell1];
   mas_skl_sr_cel=[otch_cell1_skl,mas_skl_sr_cel];
   vuh_mas=[vuh_mas;mas_skl_sr_cel];
end

if B(47)==1
   a_naz_wk_f=[path_f_vrem,'wk_a.wks'];
   wk1write1(a_naz_wk_f,vuh_mas,0,0);
end
%Y=3;% может быть 1, 2 или 3

if B(46)==1
   
   switch F(1)  
   case 1
      mas_skl_sr=mas_dv_amp;
   case 2
      mas_skl_sr=mas_skz;
   case 3
      if B(38)~=1
         msgbox('Не выбрана обработка по скользящему среднему','Сообщение')
         feval(gl_fun);
         break;
      end
   end
      
   mas_skl_sr(1,:)=[];
     sr_zn=mas_skl_sr(1,:);
     sr_kv_otkl=mas_skl_sr(1,:);
     max_z=mas_skl_sr(1,:);
     min_z=mas_skl_sr(1,:);
     
  
   fflg=1;  
   while (fflg==1)
      ocenki=zeros(kol_f_zam);
      otk_ot_sr=mas_skl_sr;
      otk_ot_sr_proc=mas_skl_sr;
      for p_chan=1:length(mas_skl_sr(1,:))
         max_z(p_chan)=(round(max(mas_skl_sr(:,p_chan))*100))/100; %массив макс значений среди выбр файлов(по кан)
         min_z(p_chan)=(round(min(mas_skl_sr(:,p_chan))*100))/100; %массив миним значений среди выбр файлов(по кан)
         sr_zn(p_chan)=(round(mean(mas_skl_sr(:,p_chan))*100))/100; %массив средн значений среди выбр файлов(по кан)
         sr_kv_otkl(p_chan)=(round(std(mas_skl_sr(:,p_chan))*100))/100;%массив сркв отклонений среди выбр файлов(по кан)
         switch F(2)  
         case 1
            otk_ot_sr(:,p_chan)=abs(mas_skl_sr(:,p_chan)-min_z(p_chan));
            otk_ot_sr_proc(:,p_chan)=otk_ot_sr(:,p_chan)/min_z(p_chan);
         case 2
            otk_ot_sr(:,p_chan)=abs(mas_skl_sr(:,p_chan)-sr_zn(p_chan));
            otk_ot_sr_proc(:,p_chan)=otk_ot_sr(:,p_chan)/sr_zn(p_chan);
         case 3
            otk_ot_sr(:,p_chan)=abs(mas_skl_sr(:,p_chan)-max_z(p_chan));
            otk_ot_sr_proc(:,p_chan)=otk_ot_sr(:,p_chan)/max_z(p_chan);
         end
         
         
         %otk_ot_sr(:,p_chan)=abs(mas_skl_sr(:,p_chan)-sr_zn(p_chan));%массив отклонений значений от среднего среди выбр файлов(по кан)
         rty=find((abs(mas_skl_sr(:,p_chan)-sr_zn(p_chan)))>(sr_kv_otkl(p_chan)*F(5)));%нахождение индексов массива которы входят в 95%-й интервал
         %disp(rty);
         if isempty(rty)~=1
            for ppp=1:(length(rty))
               %заполнение второго столбца ocenki массива номерами файлов не соответств 95%-ому интервалу(отклонение от ср больше двух среднеквадратическ отклонений)
               ocenki(rty(ppp),2)=rty(ppp);
            end
         end 
      end
      
      if F(3)~=1
         break;
      end
      index_pr=find(ocenki(:,2)>0);

      if length(index_pr)<length(mas_skl_sr(:,1))
         if isempty(index_pr)==0
            mas_skl_sr(index_pr,:)=[];
            kol_f_zam=kol_f_zam-length(index_pr);
            otch_cell1(index_pr,:)=[];
            f_zam(index_pr)=[];
         else
            fflg=0;
         end
      else
         break;
      end
      
   end
   
   sr_otkl_ot_sr=zeros(kol_f_zam,1);
   sr_otkl_ot_sr_proc=zeros(kol_f_zam,1);
   for d_d=1:kol_f_zam
      sr_otkl_ot_sr(d_d,1)=mean(otk_ot_sr(d_d,:));
      if F(3)==1
         if (ocenki(d_d,2)==0)%&(F(3)~=1)
            sr_otkl_ot_sr_proc(d_d,1)=mean(otk_ot_sr_proc(d_d,:));
         else
            sr_otkl_ot_sr_proc(d_d,1)=max(otk_ot_sr_proc(d_d,:))+1;
         end
      else
         sr_otkl_ot_sr_proc(d_d,1)=mean(otk_ot_sr_proc(d_d,:));
      end
   end
   vub_sr=find(sr_otkl_ot_sr==min(sr_otkl_ot_sr));
   
   vub_srproc=find(sr_otkl_ot_sr_proc==min(sr_otkl_ot_sr_proc));
         
  %disp(f_zam(1).name);
   if isempty(find(ocenki(:,2)==0))==1
      msgbox(['Ни один файл не входит в заданный интервал.Рекомендуется-',...
            getfield(f_zam(vub_srproc).name)],'Сообщение')
   else
      msgbox(['Рекомендуется-',getfield(f_zam(vub_srproc).name)],'Сообщение')
      %msgbox(['Усредненное отклонение от среднего по каналам-',getfield(f_zam(index2(1)).name)],'Сообщение')
   end
   anal_mass=num2cell([max_z;min_z;sr_zn;sr_kv_otkl]);
   naz_anal={'Макс. знач' 'Мин.знач' 'Ср.знач' 'Сркв.откл'}';
   anal_mass=[naz_anal,anal_mass];
   %celldisp(otch_cell1)
   otch_cell2=num2cell(mas_skl_sr);
   otch_cell=[otch_cell1,otch_cell2];
   otch_cell=[otch_cell;anal_mass];
   otch_chan1=num2cell(nom_chan-1);
   for n_pp=1:length(nom_chan)
      otch_chan1{n_pp}=['Кан.',int2str(otch_chan1{n_pp})];
   end
   if kol_f_zam>1
      nazvan=getfield(f_zam(vub_srproc).name);
   else
      nazvan=getfield(f_zam(1).name);
   end
   otch_chan=[{nazvan},otch_chan1];
   otch_cell=[otch_chan;otch_cell];
   
   
   dlin_naz_f=length(nazvan);
   nazvan(dlin_naz_f-3:dlin_naz_f)=[];
   if F(4)==1
      wk1write1([path_f_zam,nazvan,'.wks'],otch_cell,0,0)%сохранить данные
   end
   %disp(nom_chan)
   if F(6)==1 %создавать график
      
      lx=length(mas_skl_sr(:,1));
      x=1:lx;
      sr_zn_lin=ones(size(mas_skl_sr));
      up_srkv_lin=ones(size(mas_skl_sr));
      but_srkv_lin=ones(size(mas_skl_sr));
      
      for por_n_gr=1:(length(mas_skl_sr(1,:)))
         sr_zn_lin(:,por_n_gr)=sr_zn(por_n_gr);
         up_srkv_lin(:,por_n_gr)=sr_zn(por_n_gr)+sr_kv_otkl(por_n_gr)*F(5);
         but_srkv_lin(:,por_n_gr)=sr_zn(por_n_gr)-sr_kv_otkl(por_n_gr)*F(5);
         
         figure;
         
         
         hold on
         
         plot(x,mas_skl_sr(:,por_n_gr),'b-')
         plot(x,sr_zn_lin(:,por_n_gr),'g-','LineWidth',1.5)
         if F(3)==1
            plot(x,up_srkv_lin(:,por_n_gr),'r-','LineWidth',1.5)
            plot(x,but_srkv_lin(:,por_n_gr),'r-','LineWidth',1.5)
         end
         
         
         title(['График амплитуды вибрации по каналу: ',int2str(nom_chan(por_n_gr)-1)])
         xlabel('Названия файлов замера')
         
         
         if F(1)==1
            ylabel('Двойная амплитуда пикового значения 2Aпик, мкм')
         elseif F(1)==2
            ylabel(...
               'Двойная амплитуда среднеквадратичного значения 2Aсркв, мкм')
         else
            ylabel(...
               'Двойная амплитуда по скользящему среднему 2Aсклср, мкм')
         end
         set(gca,'XTick',1:lx);
         set(gca,'XTickLabel',otch_cell1,'FontSize',7)
         
         grid on;
         zoom on;
         hold off
      end
      
   end
   
   %disp(mas_skl_sr)
end
close(win1)
feval(gl_fun);