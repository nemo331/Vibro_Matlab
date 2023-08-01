function prosm_set()
% prosm_set вызов окна установок для просмотра
% Вызов функции:
%               prosm_set
% Используемые функци: Нет
% Входные переменные: Нет


global gl_put; % путь к гл каталогу
global kof;% коэф для изменения размеров упр элементов
% Чтение файла установок в массив B 
load ([gl_put,'ust1.mat']);%c:\Matlab\Toolbox\work\ust1.mat
%disp(A1);
if A1(1)==1
   %для стандартного файла
   load ([gl_put,'ust_pros.mat']);%c:\Matlab\Toolbox\work\ust_pros.mat 
   else
   %для нестандартного файла
   load ([gl_put,'ust_pros1.mat']);%c:\Matlab\Toolbox\work\ust_pros1.mat
end
%disp(B);

%kof=1;
num_chan={1:16,'нет'}; % кол-во каналов которые опрашивались
num_otm=(1:16);
num_otm2=(1:16);
%num_otm3=(1:16);
num_nab=(1:6);   % номер набора коэффициентов

%---------------------------------------------------------------------
win1=figure;
uicontrol('Style','text','String','Окно установок для просмотра файла замера вибрации',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);

help_but = uicontrol('Style','Pushbutton','Position',...
   [580/kof 100/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','Help','UserData',0);


%uicontrol('Style','text','String','Выберите каналы для просмотра',...
   %'Position',[40/kof 60/kof 320/kof 20/kof]);
for nn=1:16
   uic(nn)=uicontrol('Style','Checkbox','Callback','uiresume','Position',...
      [480/kof (420-25*(nn-1))/kof 15/kof 15/kof],...
       'Max',1,'Value',B(nn),'Enable','on');
    %uicontrol('Style','text','String',(nn),'Position',...
       %[(20/kof)+(20/kof)*(nn) 20/kof 15/kof 15/kof]);
end
       
uicontrol('Style','text','String','Позиция канала',...
   'Position',[280/kof 440/kof 150/kof 20/kof]); 
uicontrol('Style','text','String','Канал',...
   'Position',[420/kof 440/kof 60/kof 20/kof]);
uicontrol('Style','text','String','Просмотр',...
          'Position',[480/kof 440/kof 80/kof 20/kof]);

for zzz=17:32      
uic(zzz)=uicontrol('Style','Popup','String',...
    num_chan,'Callback','uiresume','Position',[420/kof (420-25*(zzz-17))/kof 60/kof 20/kof],'Value',B(zzz));
       uicontrol('Style','text','String',zzz-16,...
          'Position',[400/kof (415-25*(zzz-17))/kof 20/kof 25/kof]);
end



uic(33)=uicontrol('Style','Checkbox','Position',[40/kof 120/kof 20/kof 20/kof],...
       'Max',1,'Value',B(33),'Enable','on');
       uicontrol('Style','text','String','Совмещать отметчик с виброграммой?',...
          'Position',[60/kof 120/kof 300/kof 20/kof]);

uic(34)=uicontrol('Style','Popup','String',...
   num_otm,'Callback','uiresume','Position',[40/kof 90/kof 45/kof 20/kof],...
   'Value',B(34));
       uicontrol('Style','text','String','Позиция канала отметчика',...
          'Position',[85/kof 90/kof 275/kof 20/kof]);
       
uic(35)=uicontrol('Style','Edit','String',...
       B(35),'Position',[40/kof 380/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Частота опроса АЦП',...
          'Position',[120/kof 380/kof 240/kof 20/kof]);


uic(36)=uicontrol('Style','Edit','String',...
       B(36),'Position',[40/kof 320/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Начальный отсчет просмотра',...
          'Position',[120/kof 320/kof 240/kof 20/kof]);
uic(37)=uicontrol('Style','Edit','String',...
       B(37),'Position',[40/kof 300/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Конечный отсчет просмотра',...
          'Position',[120/kof 300/kof 240/kof 20/kof]);
         


uic(38)=uicontrol('Style','Checkbox','Position',[40/kof 260/kof 20/kof 20/kof],...
       'Max',1,'Value',B(38),'Enable','on');
       uicontrol('Style','text','String','Делать обработку скользящим средним',...
          'Position',[60/kof 260/kof 300/kof 20/kof]);
uic(39)=uicontrol('Style','Edit','String',...
       B(39),'Position',[40/kof 240/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Кол-во отсчетов для среднего',...
          'Position',[120/kof 240/kof 240/kof 20/kof]);
       
uic(40)=uicontrol('Style','Checkbox','Position',[40/kof 200/kof 20/kof 20/kof],...
       'Max',1,'Value',B(40),'Enable','on');
       uicontrol('Style','text','String','Удалять пост. составляющую сигнала',...
          'Position',[60/kof 200/kof 300/kof 20/kof]);
       
uic(41)=uicontrol('Style','Popup','String',...
    num_nab,'Callback','uiresume','Position',[40/kof 160/kof 45/kof 20/kof],'Value',B(41));
       uicontrol('Style','text','String','Номер набора коэффициентов',...
         'Position',[85/kof 160/kof 275/kof 20/kof]);
       

%-----------------------------------------------------------------------

gg=0;
gh=0;
while (gg==0)
      for n_uic=[1:34 38 40 41]
      set(uic(n_uic),'Value',B(n_uic));
     end
     
     for n_uic=[35:37 39]
        set(uic(n_uic),'String',B(n_uic));
     end
     if B(17)==17 %Для первой позиции канала
        B(17)=1;
        set(uic(17),'Value',1);        
     end
         por_net=100; %номер позиции канала с которого начинаются 'нет' 
     for n_uic=[1:16]
        if B(n_uic+16)==17|n_uic>por_net
           set(uic(n_uic),'Value',0);
           set(uic(n_uic),'Enable','off');
           set(uic(n_uic+16),'Value',17);
           num_otm(n_uic)=0;
           por_net=n_uic;
        else
           set(uic(n_uic),'Enable','on');
           num_otm(n_uic)=B(n_uic+16);
        end
        
     end
     num_otm2=sort(find(num_otm)); %удаляем нулевые и сортируем по возрастанию
     dl_vec=length(num_otm2);
     set(uic(34),'String',num_otm2)
     if B(34)>dl_vec   % если номер канала больше доступного то  
        B(34)=num_otm2(dl_vec); % уменьшаем его до ближайшего 
        set(uic(34),'Value',B(34)); %доступного
     end
  
    if(sum(B(1:16))&B(35))==0 %если не выбран ни один канал и частота=0
        set(ok,'Enable','off'); % то кнопка ok недоступна
     else
        set(ok,'Enable','on');
     end

     
uiwait

   % чтение из окон числовых значений и проверка их на предмет того что это числа
for n_uics=[35:37 39]
   promeg=get(uic(n_uics),'String');
   sdf=length(promeg);
   prost=0;
   if isempty(promeg)~=0 % если пусто значит числовое значени будет нуль
         prost=1;
   end
   for jjj=1:sdf
      if isletter(promeg(jjj))~=0 % если символ алфавита значит числовое значени будет нуль
         prost=1;
      end
   end
   if prost==0
      switch n_uics % в зависимости от номера окна делаем соотв. преобразования
         case 35
            B(n_uics)=abs(str2num(promeg));% приводим к неотриц числу
         case 36
            B(n_uics)=abs(fix(str2num(promeg)));% приводим к целому неотриц числу
         case 37
            B(n_uics)=abs(fix(str2num(promeg)));% приводим к целому неотриц числу
         case 39
            B(n_uics)=abs(fix(str2num(promeg)));% приводим к целому неотриц числу
      end
   else
      B(n_uics)=0;
      msgbox('В каком то окне возможно неправильно введены данные','Сообщение')
   end
end
%Проверка и исправление диапазона файла данных с тем чтобы диапазон не
% перекрывался т.е.был(от 1 до 12 или от 2 до 13) одно из чисел 
%обязательно четное другое нечетное
for n_uics=36:37
   switch n_uics
      case 36
            raznica=(fix((B(n_uics+1)-B(n_uics))/2))*2+1;
            %raznica=fix(B(n_uics+1)-B(n_uics));
            if raznica<99 
               B(n_uics)=1;
               B(n_uics+1)=100;  
            else
               B(n_uics)=abs(B(n_uics+1)-raznica);
            end
            
            if B(n_uics)==0, B(n_uics)=1;,end
      case 37
            raznica=(fix((B(n_uics)-B(n_uics-1))/2))*2+1;
            if raznica<99 
               B(n_uics-1)=1;
               B(n_uics)=100;     
            else
              B(n_uics)=abs(B(n_uics-1)+raznica); 
            end
      end
end
% Проверка значения скользящего среднего чтобы был меньше диапазона
% просмотра
if B(39)>((B(37)-B(36))+1)/2 
   B(39)=((B(37)-B(36))+1)/2;
end

   for n_uic=[1:34 38 40 41]
     B(n_uic)=get(uic(n_uic),'Value');
   end

gg=get(ok,'UserData');
gh=get(help_but,'UserData');
   if gh==1
      help_prosm_set;
      %win2=figure;%граф окно для "Помощи"
      set(help_but,'UserData',0);% установить для кнопки 'Help' польз данные
      set(0,'CurrentFigure',win1);% установить текущим граф окно с кнопками
   end
   
end
% запись в файл значений установок просмотра
close
if A1(1)==1
   save ([gl_put,'ust_pros.mat'],'B')%c:\Matlab\Toolbox\work\ust_pros.mat B; %сохранить данные из окон в файле ust_pros.mat
else
   save ([gl_put,'ust_pros1.mat'],'B')%c:\Matlab\Toolbox\work\ust_pros1.mat B; %сохранить данные из окон в файле ust_pros.mat
end

flags1;