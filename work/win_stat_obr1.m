function win_stat_obr()
% prosm_set вызов окна установок для просмотра
% Вызов функции:
%               win_stat_obr
% Используемые функци: Нет
% Входные переменные: Нет


global gl_put; % путь к гл каталогу
global gl_fun; %название головной функции
global kof;% коэф для изменения размеров упр элементов
% Чтение файла установок в массив F с 20-тью числами
load ([gl_put,'ust_stat.mat']);%c:\Matlab\Toolbox\work\ust_ot_vib.mat
%disp(F);
load ([gl_put,'ust1.mat']);
if A1(1)==1
   %для стандартного файла
   load ([gl_put,'ust_pros.mat']);
   else
   %для нестандартного файла
   load ([gl_put,'ust_pros1.mat']);
end
%disp(B);
if B(38)==1
   oc={'по пиковому  ','по среднеквадратичному значению','по сколзящему среднему'};
else
   oc={'по пиковому  ','по среднеквадратичному значению'};
   F(1)=2;
end

graf={'по минимальному значению','по среднему значению','по максимальному значению'};
%break;
%---------------------------------------------------------------------
figure;
uicontrol('Style','text','String','Окно установок для статистического анализа',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);

uic(1)=uicontrol('Style','Popup','String',...
    oc,'Position',[40/kof 400/kof 320/kof 20/kof],'Value',F(1));
       uicontrol('Style','text','String','Тип амплитуды для анализа',...
          'Position',[40/kof 420/kof 320/kof 20/kof]);
       
uic(2)=uicontrol('Style','Popup','String',...
    graf,'Position',[40/kof 340/kof 320/kof 20/kof],'Value',F(2));
       uicontrol('Style','text','String','Выбор файла',...
          'Position',[40/kof 360/kof 320/kof 20/kof]);

 
uic(3)=uicontrol('Style','Checkbox','Position',[40/kof 300/kof 20/kof 20/kof],...
       'Max',1,'Value',F(3),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','Анализ с учетом стандартного отклонения',...
          'Position',[60/kof 300/kof 300/kof 20/kof]);
       
uic(4)=uicontrol('Style','Checkbox','Position',[40/kof 240/kof 20/kof 20/kof],...
       'Max',1,'Value',F(4),'Enable','on');
       uicontrol('Style','text','String','Файл с отчетом стат. анализа (Формат.wks)',...
          'Position',[60/kof 240/kof 300/kof 20/kof]);
       
uic(5)=uicontrol('Style','Edit','String',...
       F(5),'Position',[40/kof 280/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','Стандартное отклонение',...
          'Position',[120/kof 280/kof 240/kof 20/kof]);
       
uic(6)=uicontrol('Style','Checkbox','Position',[40/kof 200/kof 20/kof 20/kof],...
       'Max',1,'Value',F(6),'Enable','on');
       uicontrol('Style','text','String','График по статистическому анализу',...
          'Position',[60/kof 200/kof 300/kof 20/kof]);
  %break;     

%-----------------------------------------------------------------------

gg=0;
while (gg==0)
   for n_uic=[1:4,6]
      set(uic(n_uic),'Value',F(n_uic));
   end
   if F(5)==0
      set(uic(5),'String',2);
   else
      set(uic(5),'String',F(5));
   end
   
   if F(3)==0
      set(uic(5),'Enable','off');
   else
      set(uic(5),'Enable','on');
   end
       
     uiwait
     
   for n_uic=[1:4,6]
      F(n_uic)=get(uic(n_uic),'Value');
   end
   
   for n_uics=[5]
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
         if n_uics==5
            F(n_uics)=abs(str2num(promeg));% приводим к неотриц числу
         else
            F(n_uics)=abs(str2num(promeg));% приводим к неотриц числу
         end   
   else
      F(n_uics)=0;
      msgbox('В каком то окне возможно неправильно введены данные','Сообщение')
   end
end

   gg=get(ok,'UserData');
end
% запись в файл значений установок просмотра
close
save ([gl_put,'ust_stat.mat'],'F');%c:\Matlab\Toolbox\work\ust_ot_vib.mat D; %сохранить данные из окон в файле ust_pros.mat
prosm_set1;