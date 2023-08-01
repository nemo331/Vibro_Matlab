function soz_gr_otch(hhh,path_f_zam,A1,vr_ot,path_f_otch,put_exl);

% soz_gr_otch окончательная функция которая создает граф окна отчета
% Вызов функции:
%               soz_gr_otch(hhh,path_f_zam,A1,vr_ot);
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные: hhh-массив ячеек с паспортными данными
%  path_f_zam -путь до файлов с данными
%  A1 - массив с установками из гл окна
%  vr_ot - название файла временного отчета

global gl_put; % путь к гл каталогу
% загрузить врем файл отчета массив vr_mass
load ([path_f_zam,vr_ot])
% Чтение файла установок в массив D с 21-им числом
load ([gl_put,'ust_ot_vib.mat']);%c:\Matlab\Toolbox\work\ust_ot_vib.mat 
%disp(D);


   lx=size(hhh,1)-1;% кол-во записей в файле паспортов
   ggg=hhh(2:(lx+1),:);
   x=(1:lx);
   ly=size(vr_mass,1); % кол-во записей во вр файле отчета
   wy=size(vr_mass,2);% кол-во столбцов во вр файле отчета
   x2=(1:wy/2); % массив по порядку номеров выбр каналов
   y=vr_mass(2:ly,1:2:wy);
   nomer_kan=vr_mass(1,1:2:wy);
   

      reg_podreg=cell (lx,1);
   for ghj=1:lx
      if isnumeric(ggg{ghj,6})==1
         promeg=num2str(ggg{ghj,6});
      else
         promeg=ggg{ghj,6};
      end
      promeg2=ggg{ghj,5};
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
            
      reg_podreg{ghj}=[promeg2,'-',promeg];
   end
   y2=ones(lx,4);
   y3=ones(wy/2,4);
   ock=[50 100 140 180];
   for nock=1:4
      y2(:,nock)=y2(:,nock).*ock(nock);
      y3(:,nock)=y3(:,nock).*ock(nock);
   end
   
   
 if D(19)==1
   tip_lin={'m-','m:','r-','r:','b-','b:','k-','k:', 'g-','g:',...
   'm-o','m:o','r-o','r:o','b-o','b:o','k-o','k:o', 'g-o','g:o',...
   'm-x','m:x','r-x','r:x','b-x','b:x','k-x','k:x', 'g-x','g:x'};
   if D(22)==1; % по оси x названия подрежимов
   figure;
   hold on
   for tnz=1:(wy/2)
      plot(x,y(:,tnz),tip_lin{tnz})   
   end
   plot(x,y2(:,1),'g-','LineWidth',1.5)
   plot(x,y2(:,2),'y-','LineWidth',1.5)
   plot(x,y2(:,3),'b-','LineWidth',1.5)
   plot(x,y2(:,4),'r-','LineWidth',1.5)
   hold off
   
   title('График общего размаха вибрации по режимам ГА')
   xlabel('Режимы работы ГА ,ХХ - в %, Ген - в МВт')
   if D(17)==1
      ylabel(...
      'Двойная амплитуда среднеквадратичного значения 2Aсркв, мкм')
   elseif D(17)==2
      ylabel(...
      'Двойная амплитуда по скользящему среднему 2Aсклср, мкм')
   else
      ylabel('Двойная амплитуда пикового значения 2Aпик, мкм')
   end
   
   set(gca,'XTick',1:lx);
   set(gca,'XTickLabel',reg_podreg,'Fontsize',8);
   
   % Создание массива строк с местами установки и номерами датчиков 
   % для легенды
   
   kolsim=zeros(1,length(nomer_kan));
   for tnz=1:(wy/2)
      %disp(ggg{1,17+(nomer_kan(tnz))});
      kolsim(tnz)=length(ggg{1,17+(nomer_kan(tnz))});
   end
   maksim=max(kolsim);
   oc={'граница "отл" ','граница "хор" ','граница "уд"  ',...
         'граница "неуд"'};
   for tnz=1:4
      kolsimoc(tnz)=length(oc{tnz});
   end
   maksimoc=max(kolsimoc);
   if maksim<maksimoc
      maksim=maksimoc;
   end
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
   for tnz=1:4
      str_mass3=[oc{tnz},blanks(maksim-kolsimoc(tnz))];
      str_mass=[str_mass;str_mass3];
   end
   
   legend(str_mass,0);
   grid on;
else  % если D(22)=2 по оси х названия каналов
   figure;
   hold on
   for tnz=1:(ly-1)
      plot(x2,y(tnz,:),tip_lin{tnz})   
   end
   plot(x2,y3(:,1),'g-','LineWidth',1.5)
   plot(x2,y3(:,2),'y-','LineWidth',1.5)
   plot(x2,y3(:,3),'b-','LineWidth',1.5)
   plot(x2,y3(:,4),'r-','LineWidth',1.5)
   hold off
   title('График общего размаха вибрации по каналам для нескольких режимов')
   xlabel('Номера датчиков и места их установки')
   if D(17)==1
      ylabel(...
      'Двойная амплитуда среднеквадратичного значения 2Aсркв, мкм')
   elseif D(17)==2
      ylabel(...
      'Двойная амплитуда по скользящему среднему 2Aсклср, мкм')
   else
      ylabel('Двойная амплитуда пикового значения 2Aпик, мкм')
   end
   
   kan_mest=cell(1,wy/2);
   pop=0;
   for nn_pop=nomer_kan
      pop=pop+1;
      kan_mest{pop}=ggg{1,17+(nn_pop)};
   end
   set(gca,'XTick',1:wy/2);
   %set(gca,'XTickLabelMode','manual')
   set(gca,'XTickLabel',kan_mest,'Fontsize',8);
   
    % Создание массива строк с местами установки и номерами датчиков 
   % для легенды
   
   kolsim=zeros(1,length(reg_podreg));
   for tnz=x
      %disp(ggg{1,17+(nomer_kan(tnz))});
      kolsim(tnz)=length(reg_podreg{tnz});
   end
   maksim=max(kolsim);
   oc={'граница "отл" ','граница "хор" ','граница "уд"  ',...
         'граница "неуд"'};
   for tnz=1:4
      kolsimoc(tnz)=length(oc{tnz});
   end
   maksimoc=max(kolsimoc);
   if maksim<maksimoc
      maksim=maksimoc;
   end
   for tnz=x
      if tnz==1
         str_mass=[reg_podreg{tnz},...
               blanks(maksim-kolsim(tnz))];
      else
      str_mass2=[reg_podreg{tnz},...
            blanks(maksim-kolsim(tnz))];
      str_mass=[str_mass;str_mass2];
      end
   end
   for tnz=1:4
      str_mass3=[oc{tnz},blanks(maksim-kolsimoc(tnz))];
      str_mass=[str_mass;str_mass3];
   end
   
   legend(str_mass,0);
   grid on;

end
end




   mass_iach=num2cell(vr_mass);
   %преобразовать числовые оценки в символьные
   for kl=2:2:wy %столбец
      for km=2:ly % строка
         switch mass_iach{km,kl}   
         case 1
            mass_iach{km,kl}='недоп.';
         case 2
            mass_iach{km,kl}='неуд.';
         case 3
            mass_iach{km,kl}='уд.';
         case 4
            mass_iach{km,kl}='хор.';
         case 5
            mass_iach{km,kl}='отл.';
         otherwise
            mass_iach{km,kl}='';
         end  
      end
   end
   %заполнение строки с каналами, датчиками и местами установки
   for tnz=1:2:wy
      mass_iach{1,tnz}=ggg{1,17+(mass_iach{1,tnz})};
      mass_iach{1,tnz+1}='';
   end
   
   %добавление столбца с подрежимами
   reg_podreg=[{' '};reg_podreg];
   mass_iach=[reg_podreg,mass_iach];
      
   if D(21)==1
      %создание wks-файла отчета
      %disp (mass_iach)
      perv_str_iach=cell(1,size(mass_iach,2));%перв заголовок
      vtor_str_iach=cell(1,size(mass_iach,2));%заголовок для таблицы режимов
      tab_reg=cell(size(mass_iach,1),15);% табл режимов
      perv_str_iach{2}=['ГА N',(num2str(ggg{1,3}))];
      perv_str_iach{3}='2А Общей вибрации';
      mass_iach=[perv_str_iach;mass_iach];
      vtor_str_iach{1}='Нагрузочные режимы работы ГА';
      mass_iach=[mass_iach;vtor_str_iach];
      reg_podreg{1}='Подрежимы Параметры';
      tab_reg(:,1)=reg_podreg;
      tab_reg(:,3:12)=hhh(:,7:16);
      tab_reg(:,14)=hhh(:,2);
      tab_reg(:,2)=hhh(:,4);
      % обработка дат
      kol_dat =size(tab_reg(:,2),1);
      flagok=0;
      text_date='';
      dmax=0;
      dmin=1000000;
      for kkkk=2:kol_dat
         if isnumeric(tab_reg{kkkk,2})==1
         if tab_reg{kkkk,2}>dmax
            dmax=tab_reg{kkkk,2};
         end
         if tab_reg{kkkk,2}<dmin
            dmin=tab_reg{kkkk,2};
         end
         else
         text_date=tab_reg{kkkk,2};
         end
      end
      
      if dmax==0
         dmax=0;
      end
      if dmin==1000000
         dmin=0;
      end

      %disp(dmin);
      %disp(dmax);
      
      % выравнять массивы mass_iach, tab_reg по кол-ву столбцов
      raznstlb=(size(mass_iach,2))-(size(tab_reg,2));
      if raznstlb<0
         dobav=cell(size(mass_iach,1),abs(raznstlb));
         mass_iach=[mass_iach,dobav];
      elseif raznstlb>0
         dobav=cell(size(tab_reg,1),abs(raznstlb));
         tab_reg=[tab_reg,dobav];
      end
      
      mass_iach{1,(size(mass_iach,2)-2)}='Дата:';
      if (dmin~=0)&(dmax~=0)
      mass_iach{1,(size(mass_iach,2)-1)}=dmin;
      if dmin~=dmax
         mass_iach{1,(size(mass_iach,2))}=dmax;
      end
      else
      mass_iach{1,(size(mass_iach,2)-1)}= text_date;
      end
      
      mass_iach=[mass_iach;tab_reg];
      
      naz_wks=ggg{1,2};
      dlin_naz_f=length(naz_wks);
      naz_wks(dlin_naz_f-6:dlin_naz_f)=[];
      wk1write1([path_f_otch,naz_wks,'_ov.wks'],mass_iach,0,0)
      
      % открыть созданный файл
      if D(20)==1
         dos([put_exl,'excel.exe ',path_f_otch,naz_wks,'_ov.wks',' ',path_f_otch,'empty.xls',' &']);
      end
   end

