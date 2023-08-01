function win_obsch()
% prosm_set вызов окна установок для просмотра
% Вызов функции:
%               prosm_set
% Используемые функци: Нет
% Входные переменные: Нет

global gl_put; % путь к гл каталогу
global gl_fun; %название головной функции
global kof;% коэф для изменения размеров упр элементов
% Чтение файла установок в массив Q с 19-тью числами
load ([gl_put,'ust_obsch.mat']);%c:\Matlab\Toolbox\work\ust_obsch.mat
%disp(Q);

%---------------------------------------------------------------------
figure;
uicontrol('Style','text','String','Окно общих установок',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);

uic(1)=uicontrol('Style','Checkbox','Position',[20/kof 440/kof 20/kof 20/kof],...
       'Max',1,'Value',Q(1),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','Отсчет времени с нуля?',...
          'Position',[40/kof 440/kof 320/kof 20/kof]); 

uic(2)=uicontrol('Style','Checkbox','Position',[20/kof 410/kof 20/kof 20/kof],...
       'Max',1,'Value',Q(2),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','Удалять пост. составляющую?',...
          'Position',[40/kof 410/kof 320/kof 20/kof]);
       
 uic(3)=uicontrol('Style','Checkbox','Position',[20/kof 380/kof 20/kof 20/kof],...
       'Max',1,'Value',Q(3),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','Разбить файл на части?',...
          'Position',[40/kof 380/kof 320/kof 20/kof]);
       
uic(4)=uicontrol('Style','Edit','String',...
       Q(4),'Position',[20/kof 360/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Кол-во отсчетов в части',...
          'Position',[100/kof 360/kof 260/kof 20/kof]);
       
uic(5)=uicontrol('Style','Edit','String',...
       Q(5),'Position',[20/kof 330/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Кол-во точек разложения в спектр',...
          'Position',[100/kof 330/kof 260/kof 20/kof]);
uic(6)=uicontrol('Style','Edit','String',...
       Q(6),'Position',[20/kof 300/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Нижняя граница фильтра',...
          'Position',[100/kof 300/kof 260/kof 20/kof]);
uic(7)=uicontrol('Style','Edit','String',...
       Q(7),'Position',[20/kof 280/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Верхняя граница фильтра',...
          'Position',[100/kof 280/kof 260/kof 20/kof]);


       

%-----------------------------------------------------------------------

gg=0;
while (gg==0)
   for n_uic=1:3
      set(uic(n_uic),'Value',Q(n_uic));
   end
   
   for n_uic=4:7
       set(uic(n_uic),'String',Q(n_uic));
    end
     
     uiwait
     
   for n_uic=1:3
      Q(n_uic)=get(uic(n_uic),'Value');
   end
   
% чтение из окон числовых значений и проверка их на предмет того что это числа
for n_uics=4:7
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
         case 4
            Q(n_uics)=abs(fix(str2num(promeg)));% приводим к целому неотриц числу
         case 5
            Q(n_uics)=abs(fix(str2num(promeg)));% приводим к целому неотриц числу
         case 6
            Q(n_uics)=abs(str2num(promeg));% приводим к неотриц числу
         case 7
            Q(n_uics)=abs(str2num(promeg));% приводим к неотриц числу
      end
   else
      Q(n_uics)=0;
      msgbox('В каком то окне возможно неправильно введены данные','Сообщение')
   end
end
   
   
   gg=get(ok,'UserData');
end
% запись в файл значений установок просмотра
close
save ([gl_put,'ust_obsch.mat'],'Q')%c:\Matlab\Toolbox\work\ust_obsch.mat Q; %сохранить данные из окон в файле ust_pros.mat
feval(gl_fun);