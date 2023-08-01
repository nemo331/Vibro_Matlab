function win_ot_garm()
% prosm_set вызов окна установок для просмотра
% Вызов функции:
%               win_ot_garm
% Используемые функци: Нет
% Входные переменные: Нет


global gl_put; % путь к гл каталогу
global gl_fun; %название головной функции
global kof;% коэф для изменения размеров упр элементов
% Чтение файла установок в массив E с 40-ка числами
load ([gl_put,'ust_ot_garm.mat']);%c:\Matlab\Toolbox\work\ust_ot_garm.mat
%disp(E);
%kof=1;
p_k_g={'Режимы-Подрежимы','Датчики и места их установки','Гармоники'};
n_t={'По оси X';' Семейство кривых ';'В разных окнах'};
%---------------------------------------------------------------------
figure;
uicontrol('Style','text','String','Окно установок для отчета по гармоникам',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);

uicontrol('Style','text','String','Выберите каналы для отчета',...
   'Position',[40/kof 60/kof 320/kof 20/kof]);

for nn=1:16
   uic(nn)=uicontrol('Style','Checkbox','Callback','uiresume','Position',...
      [(20/kof)+(20/kof)*nn 40/kof 15/kof 15/kof],...
       'Max',1,'Value',E(nn),'Enable','on');
    uicontrol('Style','text','String',nn,'Position',...
       [(20/kof)+(20/kof)*nn 20/kof 15/kof 15/kof]);
end

for nn=17:26
uic(nn)=uicontrol('Style','Checkbox','Callback','uiresume','Position',...
      [40/kof (400-25*(nn-17))/kof 15/kof 15/kof],...
       'Max',1,'Value',E(nn),'Enable','on');
       uicontrol('Style','text','String','Выберите номера гармоник для отчета',...
          'Position',[40/kof 420/kof 320/kof 20/kof]);
    end
    
for nn=27:36
uic(nn)=uicontrol('Style','Edit','String',...
   E(nn),'Position',[80/kof (400-25*(nn-27))/kof 80/kof 20/kof]);
uicontrol('Style','text','String','По',...
   'Position',[60/kof (400-25*(nn-27))/kof 20/kof 20/kof]);
uicontrol('Style','text','String','гармонике',...
          'Position',[160/kof (400-25*(nn-27))/kof 80/kof 20/kof]);
end
   
uic(37)=uicontrol('Style','Checkbox','Callback','uiresume',...
  'Position',[40/kof 150/kof 20/kof 20/kof],'Value',E(37));
       uicontrol('Style','text','String','Выводить график по гармоникам',...
          'Position',[60/kof 150/kof 300/kof 20/kof]);
       
uic(38)=uicontrol('Style','Checkbox','Callback','uiresume',...
  'Position',[40/kof 130/kof 20/kof 20/kof],'Value',E(38));
       uicontrol('Style','text','String','Создавать wks-файл отчета?',...
         'Position',[60/kof 130/kof 300/kof 20/kof]);

uic(39)=uicontrol('Style','Checkbox','Callback','uiresume',...
  'Position',[40/kof 110/kof 20/kof 20/kof],'Value',E(39));
       uicontrol('Style','text','String','Открыть wks-файл отчета в Excel',...
         'Position',[60/kof 110/kof 300/kof 20/kof]);         

uic(40)=uicontrol('Style','Edit','String',...
   E(40),'Position',[40/kof 90/kof 80/kof 20/kof]);       
uicontrol('Style','text','String','- Частота первой гармоники',...
   'Position',[120/kof 90/kof 240/kof 20/kof]);

for nnn=41:43
   uic(nnn)=uicontrol('Style','Popup','String',p_k_g,'Callback','uiresume',...
      'Position',[360/kof (400-(nnn-41)*50)/kof 240/kof 20/kof],'Value',E(nnn));
       uicontrol('Style','text','String',n_t{nnn-40},...
          'Position',[360/kof (420-(nnn-41)*50)/kof 240/kof 20/kof]);
end
    
%break;
%-----------------------------------------------------------------------

gg=0;
while (gg==0)
   for n_uic=[1:26 37:39 41:43]
      set(uic(n_uic),'Value',E(n_uic));
   end
   if E(38)==0
        set(uic(39),'Value',0);
        set(uic(39),'Enable','off');
   else
        set(uic(39),'Enable','on');
   end
     
   for n_uic=[27:36]
      set(uic(n_uic),'String',E(n_uic));
      if E(n_uic)==0
         set(uic(n_uic-10),'Value',0)
         set(uic(n_uic-10),'Enable','off');
      else
         set(uic(n_uic-10),'Enable','on');
      end 
   end
   if E(40)==0
      set(uic(40),'String',1.04);
   else
      set(uic(40),'String',E(40));
   end
   
     
     if(sum(E(1:16)))==0
        msgbox('Не выбрано ни одного канала','Сообщение');
     end
     if(sum(E(17:26)))==0
        msgbox('Не выбрано ни одной гармоники','Сообщение');
     end
     if(sum(E(37:39)))==0
        msgbox('Не выбрано ни одной формы отчета','Сообщение');
     end 
     
     if(sum(E(1:16))&sum(E(17:26))&sum(E(37:39)))==0
        set(ok,'Enable','off');
     else
        set(ok,'Enable','on');
     end

     uiwait
    % чтение из окон числовых значений и проверка их на предмет того что это числа
for n_uics=[27:36 40]
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
         if n_uics<40
            E(n_uics)=abs(str2num(promeg));% приводим к неотриц числу
         else
            E(n_uics)=abs(str2num(promeg));% приводим к неотриц числу
         end   
   else
      E(n_uics)=0;
      msgbox('В каком то окне возможно неправильно введены данные','Сообщение')
   end
end
  
   for n_uic=[1:26 37:39 41:43]
      E(n_uic)=get(uic(n_uic),'Value');
   end
   if (sum(E(41:43))~=6)|(prod(E(41:43))~=6)
      an=menu(['В окнах:',n_t{1:3},' неправильно выбраны значения. Изменить их?'],'Да','Нет');
      if an==1
         E(41)=1;
         E(42)=2;
         E(43)=3;
      end
   end
   
   gg=get(ok,'UserData');
end
% запись в файл значений установок просмотра
close
if (sum(E(41:43))~=6)|(prod(E(41:43))~=6)
   E(41)=1;
   E(42)=2;
   E(43)=3;
   msgbox(['В окнах:"',n_t{1:3},'" были неправильно выбраны значения. Они были изменены'],...
   'Сообщение');
end
save ([gl_put,'ust_ot_garm.mat'],'E');%c:\Matlab\Toolbox\work\ust_ot_garm.mat E; %сохранить данные из окон в файле ust_pros.mat
feval(gl_fun);