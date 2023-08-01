function prosm_set()
% prosm_set вызов окна установок для просмотра
% Вызов функции:
%               prosm_set
% Используемые функци: Нет
% Входные переменные: Нет


% Чтение файла установок в массив B с 21-им числом
load c:\Matlab\Toolbox\work\ust_pros.mat
%disp(B);
kof=1;% коэф для изменения размеров упр элементов
num_chan=(1:16); % кол-во каналов которые опрашивались
num_nab=(1:6);   % номер набора коэффициентов

%---------------------------------------------------------------------
figure;
uicontrol('Style','text','String','Окно установок для просмотра файла замера вибрации',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);
uic(1)=uicontrol('Style','Edit','String',...
       B(1),'Position',[40/kof 400/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Частота опроса АЦП',...
          'Position',[120/kof 400/kof 240/kof 20/kof]);
       
uic(2)=uicontrol('Style','Popup','String',...
    num_chan,'Callback','uiresume','Position',[40/kof 360/kof 45/kof 20/kof],'Value',B(2));
       uicontrol('Style','text','String','Кол-во каналов опроса',...
         'Position',[85/kof 360/kof 275/kof 20/kof]);
      
uic(3)=uicontrol('Style','Edit','String',...
       B(3),'Position',[40/kof 320/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Начальный отсчет просмотра',...
          'Position',[120/kof 320/kof 240/kof 20/kof]);
uic(4)=uicontrol('Style','Edit','String',...
       B(4),'Position',[40/kof 300/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Конечный отсчет просмотра',...
          'Position',[120/kof 300/kof 240/kof 20/kof]);
         
uicontrol('Style','text','String','Выберите каналы для просмотра',...
   'Position',[40/kof 60/kof 320/kof 20/kof]);
for nn=5:20
   uic(nn)=uicontrol('Style','Checkbox','Callback','uiresume','Position',...
      [(20/kof)+(20/kof)*(nn-4) 40/kof 15/kof 15/kof],...
       'Max',1,'Value',B(nn),'Enable','on');
    uicontrol('Style','text','String',(nn-4),'Position',...
       [(20/kof)+(20/kof)*(nn-4) 20/kof 15/kof 15/kof]);
end

uic(21)=uicontrol('Style','Checkbox','Position',[40/kof 260/kof 20/kof 20/kof],...
       'Max',1,'Value',B(21),'Enable','on');
       uicontrol('Style','text','String','Делать обработку скользящим средним',...
          'Position',[60/kof 260/kof 300/kof 20/kof]);
uic(22)=uicontrol('Style','Edit','String',...
       B(22),'Position',[40/kof 240/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Кол-во отсчетов для среднего',...
          'Position',[120/kof 240/kof 240/kof 20/kof]);
       
uic(23)=uicontrol('Style','Checkbox','Position',[40/kof 200/kof 20/kof 20/kof],...
       'Max',1,'Value',B(23),'Enable','on');
       uicontrol('Style','text','String','Удалять пост. составляющую сигнала',...
          'Position',[60/kof 200/kof 300/kof 20/kof]);
       
uic(24)=uicontrol('Style','Popup','String',...
    num_nab,'Callback','uiresume','Position',[40/kof 160/kof 45/kof 20/kof],'Value',B(24));
       uicontrol('Style','text','String','Номер набора коэффициентов',...
         'Position',[85/kof 160/kof 275/kof 20/kof]);
       

%-----------------------------------------------------------------------

gg=0;
while (gg==0)
   for n_uic=[2 5:20 21 23 24]
      set(uic(n_uic),'Value',B(n_uic));
     end
     
     for n_uic=[1 3 4 22]
        set(uic(n_uic),'String',B(n_uic));
     end
uiwait

   % чтение из окон числовых значений и проверка их на предмет того что это числа
for n_uics=[1 3 4 22]
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
   if prost~=1
      switch n_uics % в зависимости от номера окна делаем соотв. преобразования
         case 1
            B(n_uics)=abs(str2num(promeg));% приводим к неотриц числу
         case 3
            B(n_uics)=abs(fix(str2num(promeg)));% приводим к целому неотриц числу
         case 4
            B(n_uics)=abs(fix(str2num(promeg)));% приводим к целому неотриц числу
         case 22
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
for n_uics=3:4
   switch n_uics
      case 3
            raznica=(fix((B(n_uics+1)-B(n_uics))/2))*2+1;
            if raznica<3 
               raznica=3;
            end
            B(n_uics)=abs(B(n_uics+1)-raznica);
            if B(n_uics)==0, B(n_uics)=1;,end
      case 4
            raznica=(fix((B(n_uics)-B(n_uics-1))/2))*2+1;
            if raznica<3 
               raznica=3;
            end
            B(n_uics)=abs(B(n_uics-1)+raznica);
   end
end
% Проверка значения скользящего среднего чтобы был меньше диапазона
% просмотра
if B(22)>((B(4)-B(3))+1)/2 
   B(22)=((B(4)-B(3))+1)/2;
end

   for n_uic=[2 5:20 21 23 24]
     B(n_uic)=get(uic(n_uic),'Value');
   end

   gg=get(ok,'UserData');
end
% запись в файл значений установок просмотра
close
save c:\Matlab\Toolbox\work\ust_pros.mat B; %сохранить данные из окон в файле ust_pros.mat
flags1;