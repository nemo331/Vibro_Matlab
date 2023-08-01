function soz_gr_garm(hhh,path_f_vrem,A1,vr_ot,path_f_otch,put_exl);

% soz_gr_garm окончательная функция которая создает граф окна по гармоникам отчета
% Вызов функции:
%               soz_gr_garm(hhh,path_f_zam,A1,vr_ot);
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные: hhh-массив ячеек с паспортными данными
%  path_f_vrem -путь до файлов с данными
%  A1 - массив с установками из гл окна
%  vr_ot - название файла временного отчета

global gl_put; % путь к гл каталогу
% загрузить врем файл отчета массив vr_mass
load ([path_f_vrem,vr_ot])
% Чтение файла установок в массив E
load ([gl_put,'ust_ot_garm.mat']) 
%disp(E);

% Поиск выбранных номеров гармоник
nom_garm2= find(E(17:26));
for pop1=1:(length(nom_garm2))
   nom_garm2(pop1)=E(26+nom_garm2(pop1));
end


lx=size(hhh,1)-1;% кол-во записей в файле паспортов
ggg=hhh(2:(lx+1),:);
x=(1:lx);
%ly=size(vr_garm,1); % кол-во записей во вр файле отчета
%wy=size(vr_garm,2);% кол-во столбцов во вр файле отчета
%y=vr_garm(2:lx,1:2:wy);

% Кол-во гармоник 
kol_garm = sum(E(17:26));

% Сортируем записи вр файла по подрежимам т.е. в каждом блоке данные 
% для одной гарм всех подрежимов

vr_podr=zeros(size(vr_garm));
vr_podr(1,:)=vr_garm(1,:);
por_str=1;
for n_garm=1:kol_garm
   for n_pod=1:lx
      por_str=por_str+1;
      vr_podr(por_str,:)=vr_garm((n_pod-1)*kol_garm+n_garm+1,:);
   end
end
%break;
% создадим массив ячеек для сохранения потом на диске (если задано)
pod_gar=cell(length(vr_podr(:,1))+kol_garm,length(vr_podr(1,:)));


for n_garm=0:kol_garm-1
   for n_pod=1:lx
      if isnumeric(ggg{n_pod,6})==1
         promeg=num2str(ggg{n_pod,6});
      else
         promeg=ggg{n_pod,6};
      end
      promeg2=ggg{n_pod,5};
      if strcmp(promeg2,'рхх')==1
         promeg2='ХХ';
      elseif strcmp(promeg2,'воз')==1
         promeg2='Возб';
      elseif strcmp(promeg2,'ген')==1
         promeg2='Ген';   
      elseif strcmp(promeg2,'рск')==1
         promeg2='СК';
      elseif strcmp(promeg2,'ост')==1
         promeg2='Остан';
      elseif strcmp(promeg2,'выб')==1
         promeg2='Выбег';
      else
         promeg2=' ';
      end
      
      pod_gar{(n_pod+n_garm*(lx+1))+2,1}=[promeg2,'-',promeg];
   end
end
n_pp=0;
% занесение в массив ячеек данных по вибрации и оценок 
for n_garm=0:kol_garm-1 %цикл по гармоникам
   %pod_gar{n_garm*(lx+1)+2,2}=[num2str(vr_podr(n_garm*lx+2,1)),'Гц']
   pod_gar{n_garm*(lx+1)+2,1}=[num2str(nom_garm2(n_garm+1)),' гармоника'];
   n_pp=1;
   flg=1;
   for n_pod=1:lx %цикл по подрежимам
      for ghj=2:length(vr_podr(1,:)) %цикл по каналам
         if (n_pod==1)
            if flg==1
               pod_gar{(n_pod+n_garm*(lx+1))+1,ghj}=n_pp;
               n_pp=n_pp+1;
               flg=-1;
            end
            flg=flg+1;
         end
         pod_gar{(n_pod+n_garm*(lx+1))+2,ghj}=vr_podr(n_pod+n_garm*lx+1,ghj);
      end
   end
end

% Заполнение первой строки с местами установки датчиков
for ghj=2:2:length(vr_podr(1,:))
   pod_gar{1,ghj}=ggg{1,vr_podr(1,ghj)+17};
end


%преобразовать числовые оценки в символьные
for ghj=3:2:length(vr_podr(1,:)) %столбец
   for por_str=3:length(vr_podr(:,1))+kol_garm % строка
      if isempty(pod_gar{por_str,ghj})~=1
         switch pod_gar{por_str,ghj}
         case 1
            pod_gar{por_str,ghj}='недоп.';
         case 2
            pod_gar{por_str,ghj}='неуд.';
         case 3
            pod_gar{por_str,ghj}='уд.';
         case 4
            pod_gar{por_str,ghj}='хор.';
         case 5
            pod_gar{por_str,ghj}='отл.';
         otherwise
            pod_gar{por_str,ghj}='';
         end  
      end
   end
end

%disp (pod_gar);
%break;

%break;
if E(37)==1
   tip_lin={'m-','m:','r-','r:','b-','b:','k-','k:', 'g-','g:',...
   'm-o','m:o','r-o','r:o','b-o','b:o','k-o','k:o', 'g-o','g:o',...
   'm-x','m:x','r-x','r:x','b-x','b:x','k-x','k:x', 'g-x','g:x'};
   ly=size(vr_podr,1); % кол-во строк во вр файле отчета
   wy=size(vr_podr,2);% кол-во столбцов во вр файле отчете
   wy2=(wy-1)/2; % кол-во каналов замера
   ly2=(ly-1)/kol_garm; %кол-во подрежимов(файлов)
   nomer_kan=vr_podr(1,2:2:wy);% Номера каналов
   
   kan_mest=cell(1,wy2);
   pop=0;
   for nn_pop=nomer_kan
      pop=pop+1;
      kan_mest{pop}=ggg{1,17+(nn_pop)};
   end
   %disp(vr_podr)
   y=vr_podr(2:ly,2:2:wy);
   
   if E(42)==1
      % Создание массива строк с режимами-подрежимами 
      % для легенды
      
      kolsim=zeros(1,length(pod_gar(3:ly2+2,1)));
      for tnz=x
         %disp(ggg{1,17+(nomer_kan(tnz))});
         kolsim(tnz)=length(pod_gar{tnz+2,1});
      end
      maksim=max(kolsim);
      for tnz=x
         if tnz==1
            str_mass=[pod_gar{tnz+2,1},...
                  blanks(maksim-kolsim(tnz))];
         else
            str_mass2=[pod_gar{tnz+2,1},...
                  blanks(maksim-kolsim(tnz))];
            str_mass=[str_mass;str_mass2];
         end
      end
   end

   if E(42)==2
      % Создание массива строк с местами установки и номерами датчиков 
      % для легенды
      kolsim=zeros(1,length(nomer_kan));
      for tnz=1:(wy-1)/2
         %disp(ggg{1,17+(nomer_kan(tnz))});
         kolsim(tnz)=length(ggg{1,17+(nomer_kan(tnz))});
      end
      maksim=max(kolsim);
      for tnz=1:(wy/2)
         if tnz==1
            str_mass=[ggg{1,17+(nomer_kan(tnz))},...
                  blanks(maksim-kolsim(tnz))];
         else
            str_mass2=[ggg{1,17+(nomer_kan(tnz))},...
                  blanks(maksim-kolsim(tnz))];
            str_mass=[str_mass;str_mass2];
         end
      end
   end
   
   if E(42)==3
      %y3=(1:kol_garm);
      for te=1:kol_garm   
         %str_mass1=num2str(vr_podr((te-1)*ly2+2,1));
         str_mass1=num2str(nom_garm2(te));
         if te==1
            maksim=length(str_mass1);
         else
            kolsim=length(str_mass1);
            if maksim<kolsim
               maksim=kolsim;
            end
         end
      end
      for te=1:kol_garm   
         %str_mass1=num2str(vr_podr((te-1)*ly2+2,1));
         str_mass1=num2str(nom_garm2(te));
         kolsim=length(str_mass1);
         str_mass2=[str_mass1,' Гармоника',blanks(maksim-kolsim)];
         if te==1
            str_mass=str_mass2;
         else
            str_mass=[str_mass;str_mass2];
         end
      end
   end
   
   %break;
   %-----------------------------------------------------------------------------------
   if E(43)==3 % в окнах гармоники
      for n_garm=1:kol_garm
         figure;
         if E(41)==1 % по оси X подрежимы
            hold on
            for tnz=1:(wy-1)/2
               plot(x,y((n_garm-1)*lx+1:n_garm*lx,tnz),tip_lin{tnz});   
            end
            hold off
            %break;
            xlabel('Режимы работы ГА ,ХХ - в %, Ген - в МВт')
            set(gca,'XTick',1:lx);
            set(gca,'XTickLabel',pod_gar(3:end),'Fontsize',8);
            %legend(str_mass,0);
         else if E(41)==2 % по оси X датчики и места их установки 
               hold on
               for tnz=1:ly2
                  plot(1:wy2,y(tnz+(ly2*(n_garm-1)),:),tip_lin{tnz});   
               end
               hold off
               xlabel('Датчики и места установки')
               
               set(gca,'XTick',1:wy2);
               set(gca,'XTickLabel',kan_mest,'Fontsize',8);
               
            end
         end
         title(['График ',num2str(nom_garm2(n_garm)),' гармоники'])
         ylabel('Двойная амплитуда пикового значения гармоники 2Aпик, мкм')
         legend(str_mass,0);        
         grid on;
      end
   end
   %-----------------------------------------------------------------------------------
   if E(43)==2 % в окнах датчики и места установки
      for n_chan=1:wy2
         figure;
         if E(41)==1 % по оси X подрежимы
            hold on
            for tnz=1:kol_garm
               plot(x,y(((tnz-1)*ly2+1):(tnz*ly2),n_chan),tip_lin{tnz});   
            end
            hold off
            %break;
            xlabel('Режимы работы ГА ,ХХ - в %, Ген - в МВт')
            set(gca,'XTick',1:lx);
            set(gca,'XTickLabel',pod_gar(3:end),'Fontsize',8);
            grid on;
         else if E(41)==3 % по оси X гармоники 
               hold on
               y2=(1:kol_garm);
               y3=y2;
               for tnz=1:ly2
                  for te=1:kol_garm
                     y2(te)=y((te-1)*ly2+tnz,n_chan);
                     if tnz==1
                        %y3(te)=vr_podr((te-1)*ly2+2,1);
                        y3(te)=nom_garm2(te);
                     end
                  end
                  plot(1:kol_garm,y2,tip_lin{tnz});   
               end
               hold off
               xlabel('Гармоники')
               
               set(gca,'XTick',1:kol_garm);
               set(gca,'XTickLabel',y3(1:end),'Fontsize',8);
               
            end
         end
         title(['Графики по датчику: ',kan_mest{n_chan}])
         ylabel('Двойная амплитуда пикового значения гармоники 2Aпик, мкм')
         legend(str_mass,0);
         grid on;
      end
   end
   %-----------------------------------------------------------------------------------
   if E(43)==1 % в окнах режимы-подрежимы
      for n_podr=x
         figure;
         if E(41)==2 % по оси X датчики и места
            hold on
            for tnz=1:kol_garm
                  plot(1:wy2,y((tnz-1)*ly2+n_podr,:),tip_lin{tnz});   
            end
            hold off
            %break;
            xlabel('Датчики и места установки')
            set(gca,'XTick',1:wy2);
            set(gca,'XTickLabel',kan_mest,'Fontsize',8);
            grid on;
         else if E(41)==3 % по оси X гармоники 
               hold on
               y2=(1:kol_garm);
               y3=y2;
               for tnz=1:wy2
                  for te=1:kol_garm
                     y2(te)=y((te-1)*ly2+n_podr,tnz);
                     if tnz==1
                        %y3(te)=vr_podr((te-1)*ly2+2,1);
                        y3(te)=nom_garm2(te);
                     end
                  end
                  plot(1:kol_garm,y2,tip_lin{tnz});   
               end
               hold off
               xlabel('Гармоники')
               
               set(gca,'XTick',1:kol_garm);
               set(gca,'XTickLabel',y3(1:end),'Fontsize',8);
               
            end
         end
         title(['Графики по режиму: ',pod_gar{n_podr+2,1}])
         ylabel('Двойная амплитуда пикового значения гармоники 2Aпик, мкм')
         legend(str_mass,0);
         grid on;
      end
   end
end

if E(38)==1
   perv_str_iach=cell(1,size(pod_gar,2));%перв заголовок
   perv_str_iach{2}=['ГА N',(num2str(ggg{1,3}))];
   perv_str_iach{3}='2А гармонических составляющих вибрации';
   pod_gar=[perv_str_iach;pod_gar];
   % обработка дат
   kol_dat =size(ggg(:,4),1);
   dmax=0;
   dmin=1000000;
   for kkkk=1:kol_dat
      if isnumeric(ggg{kkkk,4})==1
         if ggg{kkkk,4}>dmax
            dmax=ggg{kkkk,4};
         end
         if ggg{kkkk,4}<dmin
            dmin=ggg{kkkk,4};
         end
      end
   end
   
   if dmax==0
      dmax=0;
   end
   if dmin==1000000
      dmin=0;
   end
   if (dmin~=0)&(dmax~=0)
      pod_gar{1,(size(pod_gar,2)-2)}='Дата:';
      pod_gar{1,(size(pod_gar,2)-1)}=dmin;
      if dmin~=dmax
         pod_gar{1,(size(pod_gar,2))}=dmax;
      end
   end
   naz_wks=ggg{1,2};
   dlin_naz_f=length(naz_wks);
   naz_wks(dlin_naz_f-6:dlin_naz_f)=[];
   wk1write1([path_f_otch,naz_wks,'_of.wks'],pod_gar,0,0)
   
   % открыть созданный файл
   if E(39)==1
      dos([put_exl,'excel.exe ',path_f_otch,naz_wks,'_of.wks',' ',path_f_otch,'empty2.xls',' &']);
   end
end


