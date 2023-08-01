function passport()
% prob_menu эксперимент с меню данные вызываются из файла
% Вызов функции:
%    passport
% Используемые функци: Нет
% Входные переменные: Нет

dia_any=1; %1-файлы DIAGNOST, 2-любые файлы(DSK)
path_f='d:\DIAGNOST\BIN\'; %путь до файла
name_f='losh__01.bin'; %название файла данных
if dia_any==1
   name_f_pas='d:\DIAGR\soho.txt';
   %structura=fpas_read (dia_any,path_f,name_f,name_f_pas);
else
   %structura=fpas_read (dia_any,path_f,name_f);
end

fr=(1:426);
ch=(1:16);
ot=(1:500);
ob_fr=400;
ob_ot=500;
kof=1.25;
ok = uicontrol('Style','Pushbutton','Position',...
   [600/kof 30/kof 50/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0)
 osn = uicontrol('Style','Popup','String',...
    'boot__34.bin|boot__40.bin','Position',[140/kof 450/kof 150/kof 20/kof],'Callback','uiresume');
       uicontrol('Style','text','String','Название файла',...
          'Position',[140/kof 470/kof 150/kof 15/kof]);
 osn2=uicontrol('Style','Popup','String',...
    ot,'Position',[20/kof 450/kof 100/kof 20/kof],'Callback','');
       uicontrol('Style','text','String','Порядковый номер',...
          'Position',[20/kof 470/kof 100/kof 30/kof]);
       
 NGA=uicontrol('Style','Popup','String',...
    '1|2|3|4|5|6|7|8|9|10','Position',[310 450 40 20],'Value',7);
       uicontrol('Style','text','String','NГА',...
         'Position',[310 470 40 15]);
      
 Date=uicontrol('Style','Edit','String',...
    '12.05.99','Position',[370 450 60 20]);
       uicontrol('Style','text','String','Дата',...
          'Position',[370 470 60 15]);
       
 Regim=uicontrol('Style','Popup','String',...
    'ген|рхх|воз|рск|выб|ост','Position',[440 450 60 20]);
       uicontrol('Style','text','String','Режим',...
          'Position',[440 470 60 15]);
       
 Podregim=uicontrol('Style','Edit','String',...
    '100','Position',[510 450 80 20]);
       uicontrol('Style','text','String','Подрежим',...
          'Position',[510 470 80 15]);
       
 Nabor=uicontrol('Style','Popup','String',...
    '1|2|3|4|5','Position',[600 450 50 20]);
       uicontrol('Style','text','String','Набор',...
          'Position',[600 470 50 15]);


 frec = uicontrol('Style','edit','String','400','Position',[20 380 100 20]);
    uicontrol('Style','text','String','Частота опроса',...
       'Position',[20 400 100 30]);


otch= uicontrol('Style','edit','String','8192',...
  'Position',[140 380 100 20]);
       uicontrol('Style','text','String','Кол-во отсчетов',...
          'Position',[140 400 100 30]);
       
uicontrol('Style','text','String','Канал,              Место ,N дат',...
          'Position',[20 340 200 20]); 
 for n=1:16
ChanC(n)=uicontrol('Style','Checkbox','Position',[20 342-20*n 15 15]);
Chan(n)=uicontrol('Style','Edit','String',...
    '','Position',[75 340-20*n 200 20]);
uicontrol('Style','text','String',n,'Position',[35 340-20*n 40 20]);
end


uicontrol('Style','text','String','Электрические параметры',...
   'Position',[280 400 180 30]);
uicontrol('Style','text','String','Другие параметры',...
   'Position',[470 400 180 30]);

for n=1:10
   if n<=5
Param(n)=uicontrol('Style','Edit','String',...
   '','Position',[360 400-20*n 100 20]);
   else
   Param(n)=uicontrol('Style','Edit','String',...
   '','Position',[550 500-20*n 100 20]);
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
Remark=uicontrol('Style','edit','String','Примечания','Max',100,...
   'Position',[280 20 100 250],'HorizontalAlignment','left');


gg=0;    
while gg==0
   val = get(osn,'Value')
f=get(frec,'Value')


uiwait
refresh
gg=get(ok,'UserData')
end

close







