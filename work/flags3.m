function flags1()%[kot,path_f,zam]=flags();
% flags ����� ���� ���������
% ����� �������:
%               flags
% ������������ ������: ���
% ������� ����������: ���

%������ ����� ��������� � ������ A c 13-��� �������
   load c:\Matlab\Toolbox\work\ust.mat;
%������ ���� ������ ������� �� ��� �������� � ������ �����
   path_f='C:\Matlab\Toolbox\work3\';
   if A(1)==1
      name_fl_zam=struct2cell(dir(strcat(path_f,'*.bin')));
      if isempty(name_fl_zam)==1
          name_fl_zam{1,1}='�����';
      end
   else
      name_fl_zam=struct2cell(dir(strcat(path_f,'*.dat')));
      if isempty(name_fl_zam)==1
         name_fl_zam{1,1}='�����';
      end
   end

%������ ���� ������ � ���������� �� ��� �������� � ������ ����� 
name_fl_pas=struct2cell(dir('C:\Matlab\Toolbox\work2\*.wks'));
%-----------------------------------------------------------------------
figure;
ex = uicontrol('Style','Pushbutton','Position',...
   [580 30 70 50], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','�����','UserData',0);

ok = uicontrol('Style','Pushbutton','Position',...
   [580 100 70 50], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','���������','UserData',0);

pasp = uicontrol('Style','Pushbutton','Position',...
   [580 170 70 50], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','�������','UserData',0);
      
prosm = uicontrol('Style','Pushbutton','Position',...
   [165 340 135 20],'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','����� ���������','UserData',0);


uicontrol('Style','text','String','���� ��������� ��� ��������� ������ �� ��������',...
          'Position',[20 470 635 30],'FontSize',12);


uic(1)=uicontrol('Style','Checkbox','Position',[20 370 20 20],...
       'Max',1,'Value',A(1),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','������������ ����������� ����',...
          'Position',[40 370 260 20]);



filu= uicontrol('Style','listbox','String',name_fl_zam(1,:),'ListboxTop',1,...
  'Position',[320 200 130 180],'Max',2,'Value',1);
       uicontrol('Style','text','String','�������� ����� ��� ���������',...
          'Position',[320 380 130 30]);
       
flu_pas=[{'���'},name_fl_pas(1,:)];       
filu_pas= uicontrol('Style','listbox','String',flu_pas,'ListboxTop',2,...
  'Position',[320 20 220 150],'Max',2,'Value',1);
       uicontrol('Style','text','String','�������� ����� ���������',...
          'Position',[320 170 220 30]);
       
 uic(2)=uicontrol('Style','Checkbox','Position',[20 340 20 20],...
       'Max',1,'Value',A(2),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','�������� �����',...
          'Position',[40 340 125 20]);
       
uic(3)=uicontrol('Style','Checkbox','Position',[20 310 20 20],...
       'Max',1,'Value',A(3),'Enable','on');
       uicontrol('Style','text','String','������ ������� � ����?',...
          'Position',[40 310 260 20]);       

uic(4)=uicontrol('Style','Checkbox','Position',[20 280 20 20],...
       'Max',1,'Value',A(4),'Enable','on');
       uicontrol('Style','text','String','�������� �������� �������� � ����',...
          'Position',[40 280 260 20]); 
       
uic(5)=uicontrol('Style','Checkbox','Position',[20 250 20 20],...
       'Max',1,'Value',A(5),'Enable','on');
       uicontrol('Style','text','String','����������� ���� ������',...
          'Position',[40 250 260 20]);       

uic(6)=uicontrol('Style','Checkbox','Position',[20 220 20 20],...
       'Max',1,'Value',A(6),'Enable','on');
       uicontrol('Style','text','String','������� ����. ������������?',...
          'Position',[40 220 260 20]);
            
uic(7)=uicontrol('Style','Checkbox','Position',[20 180 20 20],...
       'Max',1,'Value',A(7),'Enable','on');
       uicontrol('Style','text','String','������� ���� �� �����?',...
          'Position',[40 180 260 20]);
uic(8)=uicontrol('Style','Edit','String',...
       A(8),'Position',[20 160 80 20]);
       uicontrol('Style','text','String','���-�� �������� � �����',...
          'Position',[100 160 200 20]);
       
uic(9)=uicontrol('Style','Checkbox','Position',[20 120 20 20],...
       'Max',1,'Value',A(9),'Enable','on');
       uicontrol('Style','text','String','������ ���������� � ��� �����?',...
          'Position',[40 120 260 20]);
uic(10)=uicontrol('Style','Edit','String',...
       A(10),'Position',[20 100 80 20]);
       uicontrol('Style','text','String','���-�� ����� ����������',...
          'Position',[100 100 200 20]);
    
uic(11)=uicontrol('Style','Checkbox','Position',[20 60 20 20],...
       'Max',1,'Value',A(11),'Enable','on');
       uicontrol('Style','text','String','������������� ������?',...
          'Position',[40 60 260 20]);
uic(12)=uicontrol('Style','Edit','String',...
       A(12),'Position',[20 40 80 20]);
       uicontrol('Style','text','String','������ ������� �������',...
          'Position',[100 40 200 20]);
uic(13)=uicontrol('Style','Edit','String',...
       A(13),'Position',[20 20 80 20]);
       uicontrol('Style','text','String','������� ������� �������',...
          'Position',[100 20 200 20]);

gv=0;
gg=0;
gd=0;
gp=0;
while (gg==0&gd==0&gp==0&gv==0)
     set(filu,'Value',1);
   
     for n_uic=[1 2 3 4 5 6 7 9 11]
       set(uic(n_uic),'Value',A(n_uic));
     end
     
     for n_uics=[8 10 12 13]
        set(uic(n_uics),'String',A(n_uics));
     end

   if (A(1)==0|A(2)==1|(strcmp(name_fl_zam(1,1),'�����'))==1) 
      set(filu_pas,'Enable','off');
      set(pasp,'Enable','off');
   else 
      set(filu_pas,'Enable','on');
      set(pasp,'Enable','on');
   end
   
   if A(2)==1
      set(prosm,'Enable','on');
      set(uic(9),'Enable','off');
      set(uic(10),'Enable','off');
      set(uic(9),'Value',1);
      for yyy=[4 5 7 11]
         set(uic(yyy),'Enable','off');
         set(uic(yyy),'Value',0);
      end
   else
      set(prosm,'Enable','off');
      set(uic(9),'Enable','on');
      set(uic(10),'Enable','on');
      for yyy=[4 5 7 11]
         set(uic(yyy),'Enable','on');
         %set(uic(yyy),'Value',1);
      end
   end
        
   uiwait
   
for n_uic=[1 2 3 4 5 6 7 9 11]
   A(n_uic)=get(uic(n_uic),'Value');
end
if A(1)==1
   name_fl_zam=struct2cell(dir(strcat(path_f,'*.bin')));
         set(ok,'Enable','on');
         set(pasp,'Enable','on');
      if isempty(name_fl_zam)==1
         name_fl_zam{1,1}='�����';
         set(ok,'Enable','off');
         set(pasp,'Enable','off');
      end
      set(filu,'String',name_fl_zam(1,:));
      %set(filu,'ListboxTop',1);
   else
      name_fl_zam=struct2cell(dir(strcat(path_f,'*.dat')));
         set(ok,'Enable','on');
         set(pasp,'Enable','on');
      if isempty(name_fl_zam)==1
         name_fl_zam{1,1}='�����';
         set(ok,'Enable','off');
         set(pasp,'Enable','off');
      end
      set(filu,'String',name_fl_zam(1,:));
      %set(filu,'ListboxTop',1);
   end

   
% ������ �� ���� �������� �������� � �������� �� �� ������� ���� ��� ��� �����
for n_uics=[8 10 12 13]
   promeg=get(uic(n_uics),'String');
   sdf=length(promeg);
   prost=0;
   if isempty(promeg)~=0 % ���� ����� ������ �������� ������� ����� ����
         prost=1;
   end
   for jjj=1:sdf
      if isletter(promeg(jjj))~=0 % ���� ������ �������� ������ �������� ������� ����� ����
         prost=1;
      end
   end
   if prost~=1
      A(n_uics)=abs(fix(str2num(promeg)));% ����� �������� � ������ ������� �����
   else
      A(n_uics)=0;
      msgbox('� ����� �� ���� �������� ����������� ������� ������','���������')
   end
end

nf_zam=get(filu,'Value');

nf_pas=get(filu_pas,'Value')-1;

gv=get(ex,'UserData');
gp=get(prosm,'UserData');
gd=get(pasp,'UserData');
gg=get(ok,'UserData');
end
kolvo=length(nf_zam)+1;
f_zam=cell2struct(name_fl_zam(1,nf_zam),'name',kolvo);%��������� � ���������� ������ ������� ������� �������
zam=f_zam(1).name;

if(nf_pas==0) 
   nf_pas=1;
   pas='���';
else
   f_pas=cell2struct(name_fl_pas(1,nf_pas(1)),'name',2);
   pas=f_pas.name; 
end

kot=A(1);

% ������ � ���� �������� ���������
close
save c:\Matlab\Toolbox\work\ust.mat A; %��������� ������ �� ���� � ����� ust.mat 
if gd~=0
   % ���� ���� ������ ������ '�������' ����������� ������� pasport3[x].m 
   passport31(kot,pas,zam);
end

if gg~=0
   % ���� ���� ������ ������ 'O.K.'...  
   if A(2)==1
      %����������� �������� ����� ������...
      obr1(zam); 
   else
      %��� ���������.
      msgbox('��������� ��������� ��� �� ��������!');
   end
end

if gp~=0
   % ���� ���� ������ ������ '����� ���������' ����������� ������� prosm_set[x]
   prosm_set1;
end









