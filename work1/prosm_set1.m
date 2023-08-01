function prosm_set()
% prosm_set вызов окна установок для просмотра
% Вызов функции:
%               prosm_set

global gl_put; % путь к гл каталогу
global gl_fun; %название головной функции
global kof;% коэф для изменения размеров упр элементов
% Чтение файла установок в массив A1 
load ([gl_put,'ust1.mat']);%c:\Matlab\Toolbox\work\ust1.mat
%disp(A1);
if A1(1)>0
   %для стандартного файла
   load ([gl_put,'ust_pros.mat']);%c:\Matlab\Toolbox\work\ust_pros.mat 
else
   %для нестандартного файла
   load ([gl_put,'ust_pros1.mat']);%c:\Matlab\Toolbox\work\ust_pros1.mat
end

load ([gl_put,'kof_mul.mat']);
load ([gl_put,'ust_stat.mat']);
%disp(K10)
num_chan={1:16,'нет'}; % кол-во каналов которые опрашивались
num_otm=(1:16);
num_otm2=(1:16);
%num_otm3=(1:16);
num_nab=(1:11);   % номер набора коэффициентов

%---------------------------------------------------------------------
win1=figure;
uicontrol('Style','text','String','Окно установок для просмотра файла замера вибрации',...
   'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [600/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);

help_but = uicontrol('Style','Pushbutton','Position',...
   [600/kof 100/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
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



uic(33)=uicontrol('Style','Checkbox','Position',[40/kof 240/kof 20/kof 20/kof],...
   'Max',1,'Value',B(33),'Callback','uiresume','Enable','on');
uicontrol('Style','text','String','Совмещать отметчик с виброграммой?',...
   'Position',[60/kof 240/kof 300/kof 20/kof]);

uic(34)=uicontrol('Style','Popup','String',...
   num_otm,'Callback','uiresume','Position',[40/kof 220/kof 45/kof 20/kof],...
   'Value',B(34));
uicontrol('Style','text','String','Позиция канала отметчика',...
   'Position',[85/kof 220/kof 275/kof 20/kof]);

uic(35)=uicontrol('Style','Edit','String',...
   B(35),'Position',[40/kof 420/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Частота опроса АЦП',...
   'Position',[120/kof 420/kof 240/kof 20/kof]);


uic(36)=uicontrol('Style','Edit','String',...
   B(36),'Position',[40/kof 400/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Начальный отсчет просмотра',...
   'Position',[120/kof 400/kof 240/kof 20/kof]);
uic(37)=uicontrol('Style','Edit','String',...
   B(37),'Position',[40/kof 380/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Конечный отсчет просмотра',...
   'Position',[120/kof 380/kof 240/kof 20/kof]);



uic(38)=uicontrol('Style','Checkbox','Position',[40/kof 350/kof 20/kof 20/kof],...
   'Max',1,'Value',B(38),'Callback','uiresume','Enable','on');
uicontrol('Style','text','String','Делать обработку скользящим средним',...
   'Position',[60/kof 350/kof 300/kof 20/kof]);
uic(39)=uicontrol('Style','Edit','String',...
   B(39),'Position',[40/kof 330/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Кол-во отсчетов для среднего',...
   'Position',[120/kof 330/kof 240/kof 20/kof]);

uic(40)=uicontrol('Style','Checkbox','Position',[40/kof 300/kof 20/kof 20/kof],...
   'Max',1,'Value',B(40),'Enable','on');
uicontrol('Style','text','String','Удалять пост. составляющую сигнала',...
   'Position',[60/kof 300/kof 300/kof 20/kof]);

uic(41)=uicontrol('Style','Popup','String',...
   num_nab,'Callback','uiresume','Position',[40/kof 270/kof 45/kof 20/kof],'Value',B(41));
uicontrol('Style','text','String','Номер набора коэффициентов',...
   'Position',[85/kof 270/kof 275/kof 20/kof]);

uic(42)=uicontrol('Style','Checkbox','Position',[40/kof 190/kof 20/kof 20/kof],...
   'Max',1,'Value',B(42),'Enable','on');
uicontrol('Style','text','String','Файл виброграмм в формате v.wk1',...
   'Position',[60/kof 190/kof 300/kof 20/kof]);

uic(43)=uicontrol('Style','Checkbox','Position',[40/kof 170/kof 20/kof 20/kof],...
   'Max',1,'Value',B(43),'Enable','on');
uicontrol('Style','text','String','Файл спектрограмм в формате f.wk1',...
   'Position',[60/kof 170/kof 300/kof 20/kof]);
uic(44)=uicontrol('Style','Checkbox','Position',[40/kof 120/kof 20/kof 20/kof],...
   'Max',1,'Value',B(44),'Enable','on');
uicontrol('Style','text','String','Графики в одном окне',...
   'Position',[60/kof 120/kof 300/kof 20/kof]);

uic(45)=uicontrol('Style','Checkbox','Position',[40/kof 140/kof 20/kof 20/kof],...
   'Max',1,'Value',B(45),'Callback','uiresume','Enable','on');
uicontrol('Style','text','String','Выводить графики в окне(ах)',...
   'Position',[60/kof 140/kof 300/kof 20/kof]);

uic(46)=uicontrol('Style','Checkbox','Position',[40/kof 90/kof 20/kof 20/kof],...
   'Max',1,'Value',B(46),'Callback','uiresume','Enable','on');
uicontrol('Style','text','String','Статистическая обработка',...
   'Position',[60/kof 90/kof 230/kof 20/kof]);

opc = uicontrol('Style','Pushbutton','Position',...
   [290/kof 90/kof 70/kof 20/kof],'Callback','uiresume,set(gco,''UserData'',[2])',...
   'String','Опции','UserData',0);

uic(47)=uicontrol('Style','Checkbox','Position',[40/kof 60/kof 20/kof 20/kof],...
   'Max',1,'Value',B(47),'Enable','on');
uicontrol('Style','text','String','Файл с амплитудами вибрации wk_a.wks',...
   'Position',[60/kof 60/kof 300/kof 20/kof]);
edit=uicontrol('Style','Pushbutton','Position',...
   [600/kof 170/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[3])',...
   'String','Edit','Visible','off','UserData',0);
for ttt=51:66      
   uic(ttt)=uicontrol('Style','Edit','String',...
      K7(ttt-50),'Position',[500/kof (440-25*(ttt-50))/kof 80/kof 22/kof]);
end

vspom=B(41);

%-----------------------------------------------------------------------

gg=0;
gh=0;
gs=0;
ge=0;
gobch=0;
while (gobch==0)
   for n_uic=[1:34 38 40:47]
      set(uic(n_uic),'Value',B(n_uic));
   end
   
   if B(45)==0, set(uic(44),'Value',0); set(uic(44),'Enable','off');
   else, set(uic(44),'Enable','on');
   end
   
   if B(46)==0, set(opc,'Enable','off');
   else, set(opc,'Enable','on');
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
   
   for n_uic=[33 38]
      if B(n_uic)==0, set(uic(n_uic+1),'Enable','off');
      else, set(uic(n_uic+1),'Enable','on');
      end
   end
   
   switch B(41) %В зависимости от номера набора коэф 
   case 1 
      for n_uic1=[51:66]
         set(uic(n_uic1),'String',K1(n_uic1-50));
         set(uic(n_uic1),'Enable','off');
      end
   case 2 
      for n_uic2=[51:66]
         set(uic(n_uic2),'String',K2(n_uic2-50));
         set(uic(n_uic2),'Enable','off');
      end
   case 3 
      for n_uic3=[51:66]
         set(uic(n_uic3),'String',K3(n_uic3-50));
         set(uic(n_uic3),'Enable','off');
      end
   case 4 
      for n_uic4=[51:66]
         set(uic(n_uic4),'String',K4(n_uic4-50));
         set(uic(n_uic4),'Enable','off');
      end
   case 5 
      for n_uic5=[51:66]
         set(uic(n_uic5),'String',K5(n_uic5-50));
         set(uic(n_uic5),'Enable','off');
      end
   case 6 
      for n_uic6=[51:66]
         set(uic(n_uic6),'String','-');
         set(uic(n_uic6),'Enable','off');
      end
   case 7 
      for n_uic7=[51:66]
         set(uic(n_uic7),'String',K7(n_uic7-50));
         set(uic(n_uic7),'Enable','off');
      end
   case 8 
      for n_uic8=[51:66]
         set(uic(n_uic8),'String',K8(n_uic8-50));
         set(uic(n_uic8),'Enable','off');
      end
   case 9 
      for n_uic9=[51:66]
         set(uic(n_uic9),'String',K9(n_uic9-50));
         set(uic(n_uic9),'Enable','off');
      end
   case 10 
      for n_uic10=[51:66]
         set(uic(n_uic10),'String',K10(n_uic10-50));
         set(uic(n_uic10),'Enable','on');
      end
   case 11 
      for n_uic11=[51:66]
         set(uic(n_uic11),'String',K11(n_uic11-50));
         set(uic(n_uic11),'Enable','on');
      end 
   end
   
   uiwait
   for n_uic=[41]
      B(n_uic)=get(uic(n_uic),'Value');
   end
   % чтение из окон числовых значений и проверка их на предмет того что это числа
   for n_uics=[35:37 39 51:66]
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
         if vspom~=6
            if (n_uics>50)&(n_uics<67)
               B(n_uics)=str2num(promeg);
            end
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
   
   for n_uic=[1:34 38 40 42:47]
      B(n_uic)=get(uic(n_uic),'Value');
   end
   
   
   
   if vspom==10
      K10=B(51:66);
   elseif vspom==11
      K11=B(51:66);
   end
   vspom=B(41);
   gg=get(ok,'UserData');
   gs=get(opc,'UserData');
   gh=get(help_but,'UserData');
   ge=get(edit,'UserData');
   if gh==1
      help_prosm_set;
      %win2=figure;%граф окно для "Помощи"
      set(help_but,'UserData',0);% установить для кнопки 'Help' польз данные
      set(0,'CurrentFigure',win1);% установить текущим граф окно с кнопками
   end
   gobch=gg+gs+ge;  
end
% запись в файл значений установок просмотра
close
if A1(1)>0
   save ([gl_put,'ust_pros.mat'],'B')%c:\Matlab\Toolbox\work\ust_pros.mat B; %сохранить данные из окон в файле ust_pros.mat
else
   save ([gl_put,'ust_pros1.mat'],'B')%c:\Matlab\Toolbox\work\ust_pros1.mat B; %сохранить данные из окон в файле ust_pros.mat
end

save ([gl_put,'kof_mul.mat'],'K1','K2','K3','K4','K5','K6','K7','K8','K9','K10','K11')
%disp (gobch)
if B(38)==0&F(1)==3
   F(1)=2;
   save ([gl_put,'ust_stat.mat'],'F')
end



switch gobch
case 1
   feval(gl_fun);
case 2
   win_stat_obr1;
case 3
   disp ('Должно открываться окно для редактирования коэффициентов')
end
