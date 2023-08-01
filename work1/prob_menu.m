function prob_menu()
% prob_menu эксперимент с меню данные вызываются из файла
% Вызов функции:
%    prob_menu
% Используемые функци: Нет
% Входные переменные: Нет

fr=(1:426);
ch=(1:16);
ot=(1:500);
ob_fr=400;
ob_ot=500;

ok = uicontrol('Style','Pushbutton','Position',...
   [600 30 50 50], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.');

 osn = uicontrol('Style','Popup','String',...
    'DIAGNOST|Любой','Position',[20 430 100 50],'Callback','');


filu= uicontrol('Style','listbox','String',{'list__01.bin' 'losh__01.bin'},'ListboxTop',1,...
  'Position',[20 220 140 200],'Max',1,'Value',1);
       uicontrol('Style','text','String','Выберите файлы для обработки',...
          'Position',[20 420 140 30]);
       
filu_pas= uicontrol('Style','listbox','String',{'sp1.wks' 'sp2.wks'},'ListboxTop',1,...
  'Position',[170 220 140 200],'Max',1,'Value',1);
       uicontrol('Style','text','String','Выберите файлы паспортов',...
          'Position',[170 420 140 30]);

       
%kuski = uicontrol('Style','listbox','String',{'Нет',ot},'ListboxTop',1,...
 %  'Position',[20 310 100 100],'Max',1,'Value',1);
            
kuski1=uicontrol('Style','Checkbox','Position',[20 180 20 20],...
       'Max',1,'Value',0,'Enable','on');
       uicontrol('Style','text','String','Разбить файл на части?',...
          'Position',[40 180 260 20]);
kuski2=uicontrol('Style','Edit','String',...
       200,'Position',[20 160 80 20]);
       uicontrol('Style','text','String','Кол-во отсчетов в части',...
          'Position',[100 160 200 20]);

    
%otm = uicontrol('Style','listbox','String',{'Нет',ch},'ListboxTop',1,...
 %  'Position',[140 165 100 100],'Max',1,'Value',1);
  %    uicontrol('Style','text','String','Канал отметчика',...
   %    'Position',[140 265 100 30]);
    
%furie = uicontrol('Style','listbox','String',{'Нет',ot},'ListboxTop',1,...
   %'Position',[20 180 100 100],'Max',1,'Value',1);
    %  uicontrol('Style','text','String','Фурье',...
     %    'Position',[20 280 100 15]);
      
furie1=uicontrol('Style','Checkbox','Position',[20 120 20 20],...
       'Max',1,'Value',0,'Enable','on');
       uicontrol('Style','text','String','Делать разложение в ряд Фурье?',...
          'Position',[40 120 260 20]);
furie2=uicontrol('Style','Edit','String',...
       200,'Position',[20 100 80 20]);
       uicontrol('Style','text','String','Кол-во точек разложения',...
          'Position',[100 100 200 20]);

    
%filtr = uicontrol('Style','listbox','String',{'Нет',ot},'ListboxTop',1,...
 %  'Position',[20 20 100 100],'Max',1,'Value',1);
  %    uicontrol('Style','text','String','Фильтровать данные?',...
   %    'Position',[20 120 100 30]);
    
filtr1=uicontrol('Style','Checkbox','Position',[20 60 20 20],...
       'Max',1,'Value',0,'Enable','on');
       uicontrol('Style','text','String','Отфильтровать данные?',...
          'Position',[40 60 260 20]);
filtr2=uicontrol('Style','Edit','String',...
       200,'Position',[20 40 80 20]);
       uicontrol('Style','text','String','Нижняя граница фильтра',...
          'Position',[100 40 200 20]);
filtr3=uicontrol('Style','Edit','String',...
       200,'Position',[20 20 80 20]);
       uicontrol('Style','text','String','Верхняя граница фильтра',...
          'Position',[100 20 200 20]);


    
uiwait

val = get(osn,'Value');
%f=get(frec,'Value')
%gg=get(frec,'ListboxTop')
gora=get(ok,'Selected');
%set(rad,'Enable','off')
%set(ok,'Callback','close')
close







