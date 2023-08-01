function flags1()%[kot,path_f,zam]=flags();
% flags вызов окна установок
% Вызов функции:
%               flags
% Используемые функци: Нет
% Входные переменные: Нет

global gl_put; % путь к гл каталогу
global kof;% коэф для изменения размеров упр элементов

% Чтение файла с путями доступа к файлам данных
puti = WK1READ1([gl_put,'path_dir.wks'],0,0,[1 1 7 2]);

%чтение файла установок в массив A1 
load ([gl_put,'ust1.mat']);%c:\Matlab\Toolbox\work\ust1.mat;
A=A1;
%disp(A)
%vir
%A(18)=A(18)+1;
%A(18)=0;
if A(18)>50000
   msgbox('Срок вашей лицензии истёк...','Привет!')
   return;
   %exit;
end

nf_zam=A2;
nom_file=max(nf_zam);
nf_pas=A3;
nom_file_pas=max(nf_pas);
%чтение имен файлов замеров из опр каталога в массив ячеек
path_f=puti{1,2};%Для стандартн файлов
path_f2=puti{2,2};%Для нестандартн файлов
switch A(1)
case 1 
   name_fl_zam=struct2cell(dir(strcat(path_f,'*.bin')));
   nom_file1=length(dir(strcat(path_f,'*.bin')));
   if isempty(name_fl_zam)==1
      name_fl_zam{1,1}='пусто';
   end
case 2
   name_fl_zam=struct2cell(dir(strcat(path_f,'*.biv')));
   nom_file1=length(dir(strcat(path_f,'*.biv')));
   if isempty(name_fl_zam)==1
      name_fl_zam{1,1}='пусто';
   end
case 3
   name_fl_zam=struct2cell(dir(strcat(path_f2,'*.dat')));
   nom_file1=length(dir(strcat(path_f2,'*.dat')));
   if isempty(name_fl_zam)==1
      name_fl_zam{1,1}='пусто';
   end
end
if nom_file>nom_file1
   if nom_file1==0
      nom_file=nom_file1+1;
      nf_zam=nom_file;
   else
      nom_file=nom_file1;
      nf_zam=nom_file;
   end
end


%чтение имен файлов с паспортами из опр каталога в массив ячеек
%doerty=dir([puti{3,2},'*.wks'])
name_fl_pas=struct2cell(dir([puti{3,2},'*.wks']));
nom_file_pas1=length(dir([puti{3,2},'*.wks']));
if isempty(name_fl_pas)==1
   name_fl_pas{1,1}='пусто';
end
if nom_file_pas>nom_file_pas1
   if nom_file_pas1==0
      nom_file_pas=nom_file_pas1+1;
      nf_pas=nom_file_pas;
   else
      nom_file_pas=nom_file_pas1;
      nf_pas=nom_file_pas;
   end
end


put_exl=puti{7,2};%Для excel
oc={'.bin','.biv','.dat'};
%-----------------------------------------------------------------------
figure;
ex = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','Выход','UserData',0);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 100/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[2])',...
   'String','Обработка','UserData',0);

pasp = uicontrol('Style','Pushbutton','Position',...
   [580/kof 170/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[3])',...
   'String','Паспорт','UserData',0);

puttt = uicontrol('Style','Pushbutton','Position',...
   [580/kof 240/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[15])',...
   'String','Каталоги','UserData',0);

      
prosm = uicontrol('Style','Pushbutton','Position',...
   [165/kof 420/kof 135/kof 20/kof],'Callback','uiresume,set(gco,''UserData'',[4])',...
   'String','Опции просмотра','UserData',0);

excl = uicontrol('Style','Pushbutton','Position',...
   [580/kof 310/kof 70/kof 50/kof],'Callback','uiresume,set(gco,''UserData'',[16])',...
   'String','Excel','UserData',0);


uicontrol('Style','text','String','Окно установок для обработки данных по вибрации',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

uic(1)=uicontrol('Style','Popup','String',oc,'Position',[20/kof 445/kof 60/kof 20/kof],...
       'Value',A(1),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','Выберите тип файла для обработки',...
          'Position',[80/kof 445/kof 240/kof 20/kof]);

filu= uicontrol('Style','listbox','String',name_fl_zam(1,:),'ListboxTop',1,...
  'Position',[400/kof 200/kof 160/kof 180/kof],'Max',2,'Value',1);
       uicontrol('Style','text','String','Выберите файлы для обработки',...
          'Position',[400/kof 380/kof 160/kof 30/kof]);
       
flu_pas=[{'все'},name_fl_pas(1,:)];       
filu_pas= uicontrol('Style','listbox','String',flu_pas,'ListboxTop',2,...
  'Position',[400/kof 20/kof 160/kof 150/kof],'Max',2,'Value',1);
       uicontrol('Style','text','String','Выберите файлы паспортов',...
          'Position',[400/kof 170/kof 160/kof 30/kof]);
       
 uic(2)=uicontrol('Style','Checkbox','Position',[20/kof 420/kof 20/kof 20/kof],...
       'Max',1,'Value',A(2),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','Просмотр файла',...
          'Position',[40/kof 420/kof 125/kof 20/kof]);
       
uic(3)=uicontrol('Style','Checkbox','Position',[20/kof 390/kof 20/kof 20/kof],...
       'Max',1,'Value',A(3),'Callback','uiresume','Enable','on','Visible','off');
       uicontrol('Style','text','String','Отчет по небалансу ротора',...
          'Position',[40/kof 390/kof 260/kof 20/kof],'Visible','off');       

uic(4)=uicontrol('Style','Checkbox','Position',[20/kof 365/kof 20/kof 20/kof],...
       'Max',1,'Value',A(4),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','Отчет по общей вибрации',...
          'Position',[40/kof 365/kof 260/kof 20/kof]); 
       
uic(5)=uicontrol('Style','Checkbox','Position',[20/kof 340/kof 20/kof 20/kof],...
       'Max',1,'Value',A(5),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','Отчет по гармоникам',...
          'Position',[40/kof 340/kof 260/kof 20/kof]);       

              
 for sled=1:3      
       but(sled) = uicontrol('Style','Pushbutton','Position',...
       [300/kof (415-sled*25)/kof 60/kof 20/kof],...
       'String','Опции','UserData',0);
 end
 
 set(but(1),'Callback','uiresume,set(gco,''UserData'',[5])');
 set(but(1),'Visible','off');
 set(but(2),'Callback','uiresume,set(gco,''UserData'',[6])');
 set(but(3),'Callback','uiresume,set(gco,''UserData'',[7])');
  
 
gv=0; gg=0; gd=0; gp=0; gk=0; ge=0;
gbut(1:10)=0;
gobsch=0;

while (gobsch==0)
   
   switch A(1)
case 1 
   name_fl_zam=struct2cell(dir(strcat(path_f,'*.bin')));
   nom_file1=length(dir(strcat(path_f,'*.bin')));
   if isempty(name_fl_zam)==1
      name_fl_zam{1,1}='пусто';
   end
case 2
   name_fl_zam=struct2cell(dir(strcat(path_f,'*.biv')));
   nom_file1=length(dir(strcat(path_f,'*.biv')));
   if isempty(name_fl_zam)==1
      name_fl_zam{1,1}='пусто';
   end   
case 3
   name_fl_zam=struct2cell(dir(strcat(path_f2,'*.dat')));
   nom_file1=length(dir(strcat(path_f2,'*.dat')));
   if isempty(name_fl_zam)==1
      name_fl_zam{1,1}='пусто';
   end
end
      
   if nom_file>nom_file1
      if nom_file1==0
         set(filu,'Value',nom_file1+1);
      else
         set(filu,'Value',nom_file1);
      end
   else
      set(filu,'Value',nf_zam);
   end
   
   name_fl_pas=struct2cell(dir([puti{3,2},'*.wks']));
   nom_file_pas1=length(dir([puti{3,2},'*.wks']));
   if isempty(name_fl_pas)==1
      name_fl_pas{1,1}='пусто';
   end
   if nom_file_pas>nom_file_pas1
      if nom_file_pas1==0
         nom_file_pas=nom_file_pas1+1;
         nf_pas=nom_file_pas;
      else
         nom_file_pas=nom_file_pas1;
         nf_pas=nom_file_pas;
      end
   end
  
   
   %
   flu_pas=[{'все'},name_fl_pas(1,:)];
   set(filu_pas,'String',flu_pas);
   set(filu_pas,'Value',nf_pas+1);
   
   for n_uic=1:5
      set(uic(n_uic),'Value',A(n_uic));
   end
    
   %disp(name_fl_pas(1,1))  
   if (A(1)==3|A(2)==1|(strcmp(name_fl_zam(1,1),'пусто'))==1|(strcmp(name_fl_pas(1,1),'пусто'))==1) 
      set(filu_pas,'Enable','off');
      set(pasp,'Enable','off');
   else 
      set(filu_pas,'Enable','on');
      set(pasp,'Enable','on');
   end
   
   if A(2)==1
      set(prosm,'Enable','on');
      for yyy=3:5
         %set(uic(yyy),'Value',0);
         set(uic(yyy),'Enable','off');
      end
   else
      set(prosm,'Enable','off');
      for yyy=3:5
         set(uic(yyy),'Enable','on');
      end
   end
   for yyy=3:5
      if A(yyy)==1&A(2)==0
         set(but(yyy-2),'Enable','on');
      else
         set(but(yyy-2),'Enable','off');
      end
   end
   
     if(sum(A(2:5)))==0
        set(ok,'Enable','off');
     else
        set(ok,'Enable','on');
     end

   uiwait%%%%
   
for n_uic=1:5
   A(n_uic)=get(uic(n_uic),'Value');
end
 
switch A(1)
   case 1   
      name_fl_zam=struct2cell(dir(strcat(path_f,'*.bin')));
         set(ok,'Enable','on');
         set(pasp,'Enable','on');
      if isempty(name_fl_zam)==1
         name_fl_zam{1,1}='пусто';
         set(ok,'Enable','off');
         set(pasp,'Enable','off');
      end
      set(filu,'String',name_fl_zam(1,:));
      %set(filu,'ListboxTop',1);
   case 2   
   name_fl_zam=struct2cell(dir(strcat(path_f,'*.biv')));
         set(ok,'Enable','on');
         set(pasp,'Enable','on');
      if isempty(name_fl_zam)==1
         name_fl_zam{1,1}='пусто';
         set(ok,'Enable','off');
         set(pasp,'Enable','off');
      end
      set(filu,'String',name_fl_zam(1,:));   
   case 3
      name_fl_zam=struct2cell(dir(strcat(path_f2,'*.dat')));
         set(ok,'Enable','on');
         set(pasp,'Enable','on');
      if isempty(name_fl_zam)==1
         name_fl_zam{1,1}='пусто';
         set(ok,'Enable','off');
         set(pasp,'Enable','off');
      end
      set(filu,'String',name_fl_zam(1,:));
      %set(filu,'ListboxTop',1);
   end

  
nf_zam=get(filu,'Value');
nom_file=max(nf_zam);
nf_pas=get(filu_pas,'Value')-1;
nom_file_pas=max(nf_pas);

gv=get(ex,'UserData');
gp=get(prosm,'UserData');
gd=get(pasp,'UserData');
gg=get(ok,'UserData');
gk=get(puttt,'UserData');
ge=get(excl,'UserData');

   if ge>0
      %put_exl='D:\PROGRA~1\MICROS~1\OFFICE\';
      if(nf_pas(1)==0)|(strcmp(name_fl_pas{1,nf_pas(1)},'пусто')==1)
         dos([put_exl,'excel.exe &']);
      else
         dos([put_exl,'excel.exe ',puti{3,2},name_fl_pas{1,nf_pas(1)},' &']);
      end
      ge=0;
      set(excl,'UserData',0);
   end


   for sovt=1:3
      gbut(sovt)=get(but(sovt),'UserData');
   end
   gobsch=sum(gbut(:))+gv+gp+gd+gg+gk;
end
kolvo=length(nf_zam)+1;
f_zam=cell2struct(name_fl_zam(1,nf_zam),'name',kolvo);%Структура с названиями файлов замеров которые выбраны
zam=f_zam(1).name;

if(nf_pas(1)==0) 
   %nf_pas=1;
   %pas='все';
   pas=0;
else
   %f_pas=cell2struct(name_fl_pas(1,nf_pas(1)),'name',2);
   %pas=f_pas.name;
   pas=nf_pas;
end


kot=A(1);


% запись в файл значений установок
close
A2=nf_zam;
A3=nf_pas;
A(19)=nom_file;
A(20)=nom_file_pas;
A1=A;
save ([gl_put,'ust1.mat'],'A1','A2','A3');%c:\Matlab\Toolbox\work\ust1.mat A1; %сохранить данные из окон в файле ust1.mat 
%Правка других файлов установок в зависимости установлен флаг
%"сделать нижеследующие установки общими" или нет
if A(12)==1
   load ([gl_put,'ust_ot_neb.mat']);%c:\Matlab\Toolbox\work\ust_ot_neb.mat;
   load ([gl_put,'ust_ot_vib.mat']);%c:\Matlab\Toolbox\work\ust_ot_vib.mat;
   %По пост составляющей
   %D()=Q(2);
   
   save ([gl_put,'ust_ot_neb.mat'],'C');%c:\Matlab\Toolbox\work\ust_ot_neb.mat C;
   save ([gl_put,'ust_ot_vib.mat'],'D');%c:\Matlab\Toolbox\work\ust_ot_vib.mat D;
end

switch gobsch
  case 2
   % если была нажата кнопка 'O.K.'...  
     if A(2)==1
        %выполняется просмотр файла данных...
        obr1(f_zam,puti); 
     else
        %или обработка.
        soz_otch1(kot,pas,f_zam,puti);
        %msgbox('Программа обработки еще не написана!');
     end
   case 3
      % если была нажата кнопка 'Паспорт' выполняется функция pasport3[x].m 
      passport31(kot,pas,zam,puti);
   case 4
      % если была нажата кнопка 'Опции просмотра' выполняется функция prosm_set[x]
      prosm_set1;
   case 5
      %вызов опций по отчету по небалансу
      win_ot_neb1;
   case 6
      %вызов опций по Отчету по общей вибрации
      win_ot_vib1;
   case 7
      %вызов опций по Отчету по гармоникам
      win_ot_garm1;
   case 8
      %вызов опций по Графикам движения подшипников
   case 9
       %вызов опций по Выводить графики виброграмм?
   case 10
      %вызов опций по Выводить графики спектров?
   case 11
      %вызов опций по Выводить графики фильтр. сигналов?
   case 12
      %вызов опций по Делать балансировку ротора?
   case 13
      %вызов опций по Комбинаторной зависимости
   case 14
      %вызов опций по Общие опции
      win_obsch1;
   case 15
      %вызов окна с путями доступа к файлам
      feval('win_path1');
   end









