function passport3(dia_any,name_f_pas,naz_f,puti)
% passport3 эксперимент с меню данные вызываются из файла
% Вызов функции:
%               passport3
% Используемые функции:
%                      wk1read1,,wk1write1,findnr
% Используемые функции MATLAB:
%                            wk1read
% Входные переменные: dia_any, path_f, name_f  


global gl_put; % путь к гл каталогу
global gl_fun; %название головной функции
global kof;% коэф для изменения размеров упр элементов
%dia_any=1; %1-файлы DIAGNOST, 2-любые файлы(DSK)
path_f_pas=puti{3,2}; %путь до файла паспортов
%чтение имен файлов замеров из опр каталога в массив ячеек
path_f=puti{1,2};%Для стандартн файлов
name_f=lower(naz_f); %название файла данных
%name_f_pas1='ghj';
%disp(name_f_pas)
if dia_any==1
   hi = waitbar(1,'Ждите...');
   %Чтение файла с паспортами замеров (формат **.wks(Lotus 1-2-3))
   % в массив ячеек
   kol_f_pas=length(name_f_pas);
   name_fl_pas=dir([path_f_pas,'*.wks']);%Чтение из опр каталога имена файлов паспортов
   if (kol_f_pas~=1)|(name_f_pas==0)
      if name_f_pas==0 %strcmp('все',name_f_pas)==1
         kol_f_pas=1:(length(name_fl_pas)); %Определяем кол-во паспортов
      else
      kol_f_pas=name_f_pas;
   end
   
      for gh=kol_f_pas
         aaa = WK1READ1([path_f_pas,name_fl_pas(gh).name],0,0,[1 1 1 34]);%Чтение первой строки
         kz=300;
         vvv = WK1READ1([path_f_pas,name_fl_pas(gh).name],1,0,[2 1 kz 2]);%Предварительное чтение для нахождения кол-ва записей
         fff = vvv'; 
         kz=length(fff(1,:));
         nmn=cell2struct(fff(2,:),'name',kz);
         sovp=0;
         for sd=1:kz
            sovp=strcmp (name_f,nmn(sd).name);
            if sovp==1
               break;
            end
         end
         if sovp==1
            name_f_pas1=name_fl_pas(gh).name;
            break;
         end
      end
      if sovp==0
         name_f_pas1=name_fl_pas(1).name;
         aaa = WK1READ1([path_f_pas,name_f_pas1],0,0,[1 1 1 34]);
         kz=300;
         vvv = WK1READ1([path_f_pas,name_f_pas1],1,0,[2 1 kz 1]);
         fff = vvv'; 
         kz=length(fff(1,:));
      end
   else
      name_f_pas1=name_fl_pas(name_f_pas).name;
      aaa = WK1READ1([path_f_pas,name_f_pas1],0,0,[1 1 1 34]);
      kz=300;
      vvv = WK1READ1([path_f_pas,name_f_pas1],1,0,[2 1 kz 1]);
      fff = vvv';
      kz=length(fff(1,:));  
   end
   sss = WK1READ1([path_f_pas,name_f_pas1],1,0,[2 1 (kz+1) 34]);%Окончательное чтение  
   ccc=sss'; % Транспонирование массива ячеек
   % Преобразование чисел из столбца дат в строковые значения которые показывают дату
   % в виде: месяц/число/год и хранение их в структуре ddd
   dlin=length(ccc(4,:));
   dd=cell2struct(ccc(4,:),'dat',dlin);
   ddd=struct('dates',cell(1,dlin));
   for ndl=1:dlin
      % Преобразование в представление MATLAB из представления Lotus (+693960)
      % затем получение строки соответствующей дате и запись в структуру ddd
      if isempty(dd(ndl).dat)~=0
         ddd(1,ndl).dates=' ';
      else
         ddd(1,ndl).dates=(datestr((dd(ndl).dat+693960),2));
      end
   end
   %stracta=fpas_read4(dia_any,path_f,name_f,name_f_pas);
   close(hi)
else
   stracta=fpas_read4(dia_any,path_f,name_f);
end
%disp (name_f(1:5))
for nwr=dlin:-1:1
   naz_file=cell2struct(ccc(2,nwr),'fl',2);
   if strcmp(name_f,naz_file.fl)==1
      zn_osn=nwr; %Номер значения в двух основных окнах
      break
   else
      zn_osn=1;
   end
end
if zn_osn==1
   for nwr=dlin:-1:1
      naz_file=cell2struct(ccc(2,nwr),'fl',2);
      if strcmp(name_f(1:5),naz_file.fl(1:5))==1
         zn_osn=nwr; %Номер значения в двух основных окнах
         break
      else
         zn_osn=1;
      end
   end
end
if zn_osn==1
   for nwr=dlin:-1:1
      naz_file=cell2struct(ccc(2,nwr),'fl',2);
      if strcmp(name_f(1),naz_file.fl(1))==1
         zn_osn=nwr; %Номер значения в двух основных окнах
         break
      else
         zn_osn=1;
      end
   end
end

%ccc=struct2cell(stracta);
naz_reg={'ген','рхх','воз','рск','выб','ост',' '}; % Названия режимов
num_ga={1:10,' '}; % Номера агрегатов  
%zn_osn=1; %Номер значения в двух основных окнах
nab=(1:11);%Набор коэффициентов для домножения на коды АЦП
%----------------------------------------------------------------------
figure;
% Формирование окон и органов управления на форме
uicontrol('Style','text','String',['Паспорт замера из файла ',name_f_pas1],...
   'Position',[140/kof 480/kof 440/kof 20/kof],'FontSize',10);
ok = uicontrol('Style','Pushbutton','Position',...
   [600/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','Возврат','UserData',0);
sav = uicontrol('Style','Pushbutton','Position',...
   [600/kof 100/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[2])',...
   'String','Сохранить','UserData',0);
met = uicontrol('Style','Pushbutton','Position',...
   [600/kof 170/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[3])',...
   'String','Пометить','UserData',0);
osn = uicontrol('Style','Popup','String',...
   ccc(2,:),'Position',[140/kof 440/kof 130/kof 20/kof],'Callback','uiresume',...
   'Value',zn_osn);
uicontrol('Style','text','String','Название файла',...
   'Position',[140/kof 460/kof 130/kof 15/kof]);
%set(osn,'String',ccc(1,:))
osn2=uicontrol('Style','Popup','String',ccc(1,:),'Position',...
   [20/kof 440/kof 100/kof 20/kof],'Callback','uiresume','Value',zn_osn);
uicontrol('Style','text','String','Порядковый номер',...
   'Position',[20/kof 460/kof 100/kof 30/kof]);
% ga=find(num_ga==str2num(ccc{3,zn_osn}))%stracta(zn_osn).NGA)) 
NGA=uicontrol('Style','Popup','String',...
   num_ga,'Position',[290/kof 440/kof 45/kof 20/kof],'Value',ccc{3,zn_osn});
uicontrol('Style','text','String','NГА',...
   'Position',[290/kof 460/kof 45/kof 15/kof]);

Date=uicontrol('Style','Edit','String',...
   ddd(1,zn_osn).dates,'Position',[350/kof 440/kof 95/kof 20/kof]);
uicontrol('Style','text','String','Дата',...
   'Position',[350/kof 460/kof 95/kof 15/kof]);

Regim=uicontrol('Style','Popup','String',naz_reg,'Position',...
   [455/kof 440/kof 60/kof 20/kof],'Value',findnr(naz_reg,ccc{5,zn_osn}));
uicontrol('Style','text','String','Режим',...
   'Position',[455/kof 460/kof 60/kof 15/kof]);

Podregim=uicontrol('Style','Edit','String',...
   ccc{6,zn_osn},'Position',[525/kof 440/kof 65/kof 20/kof]);
uicontrol('Style','text','String','Подрежим',...
   'Position',[525/kof 460/kof 65/kof 15/kof]);

Nabor=uicontrol('Style','Popup','String',...
   nab,'Position',[600/kof 440/kof 50/kof 20/kof],'Value',1);
uicontrol('Style','text','String','Набор',...
   'Position',[600/kof 460/kof 50/kof 15/kof]);


frec = uicontrol('Style','edit','String',400,'Position',...
   [20/kof 380/kof 100/kof 20/kof],'Enable','off');
uicontrol('Style','text','String','Частота опроса',...
   'Position',[20/kof 400/kof 100/kof 30/kof]);


otch= uicontrol('Style','edit','String',8192,...
   'Position',[140/kof 380/kof 100/kof 20/kof],'Enable','off');
uicontrol('Style','text','String','Кол-во отсчетов',...
   'Position',[140/kof 400/kof 100/kof 30/kof]);

uicontrol('Style','text','String','Канал,              Место ,N дат',...
   'Position',[20/kof 340/kof 200/kof 20/kof]); 
for nn=1:16
   if isempty(ccc{(nn+17),zn_osn})~=1, vval=1;
   else, vval=-1;
   end
   ChanC(nn)=uicontrol('Style','Checkbox','Position',[20/kof (342/kof)-(20/kof)*nn 15/kof 15/kof],...
      'Max',vval,'Value',vval,'Enable','off');
   Chan(nn)=uicontrol('Style','Edit','String',...
      ccc{(nn+17),zn_osn},'Position',[75/kof (340/kof)-(20/kof)*nn 200/kof 20/kof]);
   uicontrol('Style','text','String',nn,'Position',[35/kof (340/kof)-(20/kof)*nn 40/kof 20/kof]);
end


uicontrol('Style','text','String','Электрические параметры',...
   'Position',[280/kof 400/kof 180/kof 30/kof]);
uicontrol('Style','text','String','Другие параметры',...
   'Position',[470/kof 400/kof 180/kof 30/kof]);

for n=1:10
   if n<=5
      Param(n)=uicontrol('Style','Edit','String',...
         ccc{(n+6),zn_osn},'Position',[360/kof (400/kof)-(20/kof)*n 100/kof 20/kof]);
   else
      Param(n)=uicontrol('Style','Edit','String',...
         ccc{(n+6),zn_osn},'Position',[550/kof (500/kof)-(20/kof)*n 100/kof 20/kof]);
   end
end

uicontrol('Style','text','String','P,МВт','Position',[280/kof 380/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Q,МВар','Position',[280/kof 360/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Iр,кА','Position',[280/kof 340/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Iст,кА','Position',[280/kof 320/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Uст,кВ','Position',[280/kof 300/kof 80/kof 20/kof]);
uicontrol('Style','text','String','РК,°','Position',[470/kof 380/kof 80/kof 20/kof]);
uicontrol('Style','text','String','НА,дел','Position',[470/kof 360/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Обороты,%','Position',[470/kof 340/kof 80/kof 20/kof]);
uicontrol('Style','text','String','tж,°C','Position',[470/kof 320/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Напор,м','Position',[470/kof 300/kof 80/kof 20/kof]);

uicontrol('Style','text','String','Примечания','Position',[280/kof 270/kof 300/kof 20/kof]);
Remark=uicontrol('Style','edit','String',ccc{17,zn_osn},'Max',100,...
   'Position',[280/kof 20/kof 300/kof 250/kof],'HorizontalAlignment','left');


gg=0; 
sav_fl=0; % флаг сохранения изменений
met_fl=0; % флаг для меток
while gg==0 % Повторять цикл пока не нажата кнопка 'O.K.'
   
   vosn = get(osn,'Value');
   vosn2=get(osn2,'Value');
   if zn_osn~=vosn, zn_osn=vosn;
   else, zn_osn=vosn2;
   end
   % Установка в окнах формы значений соответствующих порядковому номер записи (zn_osn)   
   set(osn,'Value',zn_osn);
   set(osn2,'Value',zn_osn);
   if isspace(ccc{3,zn_osn})~=0, set(NGA,'Value',11);
   else, set(NGA,'Value',ccc{3,zn_osn});
   end
   set(Date,'String',ddd(1,zn_osn).dates);
   set(Regim,'Value',findnr(naz_reg,ccc{5,zn_osn}));
   set(Podregim,'String',ccc{6,zn_osn});
   
   if size(ccc,1)==33
      jjj=cell(1,kz);
      ccc=[ccc;jjj];
   end
   
   if (isspace(ccc{34,zn_osn})~=0)|(isempty(ccc{34,zn_osn})~=0), set(Nabor,'Value',1);
   else,set(Nabor,'Value',ccc{34,zn_osn});
   end   
   
   for nnnn=1:16
      set(Chan(nnnn),'String',ccc{(nnnn+17),zn_osn});
   end
   
   for nvn=1:10
      set(Param(nvn),'String',ccc{(nvn+6),zn_osn});
   end
   set(Remark,'String',ccc{17,zn_osn});
   
   uiwait
   %Получение из окон формы значений и запись их в массив ячеек
   pr_zn=get(NGA,'Value');
   if pr_zn==11, ccc{3,zn_osn}=' ';
   else, ccc{3,zn_osn}=pr_zn;
   end
   
   %ddd(1,zn_osn).dates=get(Date,'String')
   promeg=get(Date,'String');
   dlina=length(promeg);
   promeg2='';
   promeg3='';
   promeg4='';
   nom_chert=0;
   %break
   %
   if (dlina==0)|(dlina>8) % если пусто значит числовое значени будет нуль
      prost=1;
      
   else
      prost=0;
      for jjj=1:dlina
         if isletter(promeg(jjj))~=0 % если символ алфавита значит числовое значени будет нуль
            prost=1;
         elseif (isnumeric(promeg(jjj))==0)
            nom_chert=nom_chert+(strncmp(promeg(jjj),'/',1));
            switch nom_chert
            case 0
               if strncmp(promeg(jjj),'/',1)==0
                  promeg2=[promeg2,promeg(jjj)];
               end
            case 1
               if strncmp(promeg(jjj),'/',1)==0
                  promeg3=[promeg3,promeg(jjj)];
               end
            case 2
               if strncmp(promeg(jjj),'/',1)==0
                  promeg4=[promeg4,promeg(jjj)];
               end
            otherwise 
               prost=1;
               break
            end
            
         end
      end
      if nom_chert<2
         prost=1;
      end
      yy=str2num(promeg4);
      mm=str2num(promeg2);
      day=str2num(promeg3);
      if mm<=12&mm>=1
         if yy>=0
            if day>=1&day<=31
               prost=0;
            else
               prost=1;
            end
         else
            prost=1;
         end
      else
         prost=1;
      end
      if yy>80
         yy=yy+1900;
      else
         yy=yy+2000;
      end
      
      
   end
   

if prost==0
   ccc{4,zn_osn}=datenum(yy,mm,day)-693960;
   ddd(1,zn_osn).dates=datestr((ccc{4,zn_osn}+693960),2);
else
   msgbox('Неправильно введена дата','Сообщение')
end
%
   
   pr_zn2=get(Regim,'Value');
   if  pr_zn2==0 ,pr_zn2=7;
   end
   
   reg_struc=cell2struct(naz_reg(pr_zn2),'freg',2);
   ccc{5,zn_osn}=reg_struc.freg;
   ccc{6,zn_osn}=get(Podregim,'String');
   ccc{34,zn_osn}=get(Nabor,'Value');
   
   for eeee=1:16
      ccc{(eeee+17),zn_osn}=get(Chan(eeee),'String');
   end
   
   for eee=1:10
      ccc{(eee+6),zn_osn}=get(Param(eee),'String');
   end
   ccc{17,zn_osn}=get(Remark,'String');
   
   sav_fl=get(sav,'UserData');
   if sav_fl==2
      hite = waitbar(1,'Ждите...');
      sss=ccc'; % Транспонирование массива ячеек
      
      %выравнивание первой строки ячеек с остальными по длине
      razm_aaa=length(aaa(1,:));
      razm_sss=length(sss(1,:));
      raznitca=razm_aaa-razm_sss;
      one_cell=cell(1);
      if (raznitca)~=0
         if raznitca<0
            for kak=1:(abs(raznitca))
               aaa=[aaa,one_cell];
            end
         else
            for kak=1:(abs(raznitca))
               aaa=aaa(1,1:(razm_aaa-kak));
            end     
         end 
      end
      
      rrr=[aaa;sss]; % Объединение первой строки файла с остальными строками
      wk1write1([path_f_pas,name_f_pas1],rrr,0,0)
      close(hite)
      
   end
   
   sav_fl=0; % флаг сохранения изменений
   set(sav,'UserData',sav_fl);
   
   met_fl=get(met,'UserData');
   if met_fl==3
      load ([gl_put,'ust1.mat']);
      nom_file=0;
      name_fl_zam=dir(strcat(path_f,'*.bin'));
      nom_file1=length(dir(strcat(path_f,'*.bin')));
      if isempty(name_fl_zam)==1
         msgbox('В заданном каталоге нет файлов с расширением .bin','Сообщение')
         nom_file=1;
         break
      end
      %disp(name_fl_zam(1).name)
      
      for nwr=dlin:-1:1
         naz_file=cell2struct(ccc(2,nwr),'fl',2);
         %prom2=naz_file.fl
         for vcv=1:nom_file1
            %prom1=lower(name_fl_zam(vcv).name)
            
            if strcmp(lower(name_fl_zam(vcv).name),naz_file.fl)==1
               if nom_file==0
                  nom_file=vcv;
               else
                  nom_file=[nom_file,vcv];
               end
            end
         end
      end
      if nom_file~=0
         A4=sort([A2,nom_file]);
         A2=[];
         llen=length(A4);
         for jk=1:llen-1
            if A4(jk)~=A4(jk+1)
               if jk==1
                  A2=[A2,A4(jk),A4(jk+1)];
               else
                  A2=[A2,A4(jk+1)];
               end
            elseif jk==1
               A2=[A2,A4(jk)];
            end
         end
         %disp(A2)
      else
         msgbox('Ни один файл не найден','Сообщение')
      end
      save ([gl_put,'ust1.mat'],'A1','A2','A3');
   end
   
   met_fl=0; % флаг сохранения изменений
   set(met,'UserData',met_fl);
   gg=get(ok,'UserData');
end

close
feval(gl_fun);
