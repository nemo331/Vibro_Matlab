function passport2()
% passport2 эксперимент с меню данные вызываются из файла
% Вызов функции:
%    passport2
% Используемые функци: Нет
% Входные переменные: Нет

dia_any=1; %1-файлы DIAGNOST, 2-любые файлы(DSK)
path_f='d:\DIAGNOST\BIN\'; %путь до файла
name_f='losh__01.bin'; %название файла данных
if dia_any==1
   name_f_pas='d:\DIAGR\soho.txt';
   %name_f_pas='d:\MATLAB\BIN\Список_замеров2.wks';
   %ccc = WK1READ(name_f_pas,0,0,[1 1 32 168])
   stracta=fpas_read4(dia_any,path_f,name_f,name_f_pas);
else
   stracta=fpas_read4(dia_any,path_f,name_f);
end

ccc=struct2cell(stracta);
naz_reg={'ген','рхх','воз','рск','выб','ост','Режим'};
num_ga=(1:10);
zn_osn=4; %Номер значения в двух основных окнах
nab=(1:5);%Набор коэффициентов для домножения на коды АЦП

ok = uicontrol('Style','Pushbutton','Position',...
   [600 30 50 50], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);
 osn = uicontrol('Style','Popup','String',...
    ccc(2,:),'Position',[140 450 150 20],'Callback','uiresume',...
    'Value',zn_osn);
       uicontrol('Style','text','String','Название файла',...
          'Position',[140 470 150 15]);
       %set(osn,'String',ccc(1,:))
       osn2=uicontrol('Style','Popup','String',ccc(1,:),'Position',...
          [20 450 100 20],'Callback','uiresume','Value',zn_osn);
       uicontrol('Style','text','String','Порядковый номер',...
          'Position',[20 470 100 30]);
     % ga=find(num_ga==str2num(ccc{3,zn_osn}))%stracta(zn_osn).NGA)) 
 NGA=uicontrol('Style','Popup','String',...
    num_ga,'Position',[310 450 40 20],'Value',str2num(ccc{3,zn_osn}));
       uicontrol('Style','text','String','NГА',...
         'Position',[310 470 40 15]);
      
 Date=uicontrol('Style','Edit','String',...
    ccc{4,zn_osn},'Position',[370 450 60 20]);
       uicontrol('Style','text','String','Дата',...
          'Position',[370 470 60 15]);
       
       Regim=uicontrol('Style','Popup','String',naz_reg,'Position',...
          [440 450 60 20],'Value',findnr(naz_reg,ccc{5,zn_osn}));
       uicontrol('Style','text','String','Режим',...
          'Position',[440 470 60 15]);
       
 Podregim=uicontrol('Style','Edit','String',...
    ccc{6,zn_osn},'Position',[510 450 80 20]);
       uicontrol('Style','text','String','Подрежим',...
          'Position',[510 470 80 15]);
       
 Nabor=uicontrol('Style','Popup','String',...
    nab,'Position',[600 450 50 20],'Value',ccc{36,zn_osn});
       uicontrol('Style','text','String','Набор',...
          'Position',[600 470 50 15]);

       
 frec = uicontrol('Style','edit','String',ccc{34,zn_osn},'Position',...
          [20 380 100 20],'Enable','off');
    uicontrol('Style','text','String','Частота опроса',...
       'Position',[20 400 100 30]);


otch= uicontrol('Style','edit','String',ccc{35,zn_osn},...
  'Position',[140 380 100 20],'Enable','off');
       uicontrol('Style','text','String','Кол-во отсчетов',...
          'Position',[140 400 100 30]);
       
uicontrol('Style','text','String','Канал,              Место ,N дат',...
          'Position',[20 340 200 20]); 
for nn=1:16
   if isempty(ccc{(nn+17),zn_osn})~=1, vval=1;
   else, vval=-1;
   end
   ChanC(nn)=uicontrol('Style','Checkbox','Position',[20 342-20*nn 15 15],...
       'Max',vval,'Value',vval,'Enable','off');
Chan(nn)=uicontrol('Style','Edit','String',...
    ccc{(nn+17),zn_osn},'Position',[75 340-20*nn 200 20]);
uicontrol('Style','text','String',nn,'Position',[35 340-20*nn 40 20]);
end


uicontrol('Style','text','String','Электрические параметры',...
   'Position',[280 400 180 30]);
uicontrol('Style','text','String','Другие параметры',...
   'Position',[470 400 180 30]);

for n=1:10
   if n<=5
   Param(n)=uicontrol('Style','Edit','String',...
   ccc{(n+6),zn_osn},'Position',[360 400-20*n 100 20]);
   else
   Param(n)=uicontrol('Style','Edit','String',...
   ccc{(n+6),zn_osn},'Position',[550 500-20*n 100 20]);
   end
end

uicontrol('Style','text','String','P,МВт','Position',[280 380 80 20]);
uicontrol('Style','text','String','Q,МВар','Position',[280 360 80 20]);
uicontrol('Style','text','String','Iр,кА','Position',[280 340 80 20]);
uicontrol('Style','text','String','Iст,кА','Position',[280 320 80 20]);
uicontrol('Style','text','String','Uст,кВ','Position',[280 300 80 20]);
uicontrol('Style','text','String','РК,°','Position',[470 380 80 20]);
uicontrol('Style','text','String','НА,дел','Position',[470 360 80 20]);
uicontrol('Style','text','String','Обороты,%','Position',[470 340 80 20]);
uicontrol('Style','text','String','tж,°C','Position',[470 320 80 20]);
uicontrol('Style','text','String','Напор,м','Position',[470 300 80 20]);

uicontrol('Style','text','String','Примечания','Position',[280 270 300 20]);
Remark=uicontrol('Style','edit','String',ccc{17,zn_osn},'Max',100,...
   'Position',[280 20 300 250],'HorizontalAlignment','left');


gg=0;    
while gg==0
      
   vosn = get(osn,'Value');
   vosn2=get(osn2,'Value');
   if zn_osn~=vosn, zn_osn=vosn;
   else, zn_osn=vosn2;
   end
   %disp(zn_osn);
set(osn,'Value',zn_osn);
set(osn2,'Value',zn_osn);
set(NGA,'Value',str2num(ccc{3,zn_osn}));
set(Date,'String',ccc{4,zn_osn});
set(Regim,'Value',findnr(naz_reg,ccc{5,zn_osn}));
set(Podregim,'String',ccc{6,zn_osn});
set(Nabor,'Value',ccc{36,zn_osn});

for nnnn=1:16
   set(Chan(nnnn),'String',ccc{(nnnn+17),zn_osn});
end

for nvn=1:10
   set(Param(nvn),'String',ccc{(nvn+6),zn_osn});
end
set(Remark,'String',ccc{17,zn_osn});
%f=get(frec,'Value');
uiwait
%refresh
ccc{3,zn_osn}=num2str(get(NGA,'Value'));
ccc{4,zn_osn}=get(Date,'String');
ccc{5,zn_osn}=naz_reg(get(Regim,'Value'));
ccc{6,zn_osn}=get(Podregim,'String');
ccc{36,zn_osn}=get(Nabor,'Value');

for eeee=1:16
   ccc{(eeee+17),zn_osn}=get(Chan(eeee),'String');
end

for eee=1:10
   ccc{(eee+6),zn_osn}=get(Param(eee),'String');
end
ccc{17,zn_osn}=get(Remark,'String');


%ccc{3,zn_osn}=num2str(get(NGA,'Value'));
%ccc{3,zn_osn}=num2str(get(NGA,'Value'));

gg=get(ok,'UserData');
end

close







