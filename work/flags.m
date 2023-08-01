function flags1()%[kot,path_f,zam]=flags();
% flags ����� ���� ���������
% ����� �������:
%               flags
% ������������ ������: ���
% ������� ����������: ���

global gl_put; % ���� � �� ��������
global kof;% ���� ��� ��������� �������� ��� ���������

% ������ ����� � ������ ������� � ������ ������
puti = WK1READ1([gl_put,'path_dir.wks'],0,0,[1 1 6 2]);

%������ ����� ��������� � ������ A1 
load ([gl_put,'ust1.mat']);%c:\Matlab\Toolbox\work\ust1.mat;
   A=A1;
%������ ���� ������ ������� �� ��� �������� � ������ �����
   path_f=puti{1,2};%��� ��������� ������
   path_f2=puti{2,2};%��� ����������� ������
   if A(1)==1
      name_fl_zam=struct2cell(dir(strcat(path_f,'*.bin')));
      if isempty(name_fl_zam)==1
          name_fl_zam{1,1}='�����';
      end
   else
      name_fl_zam=struct2cell(dir(strcat(path_f2,'*.dat')));
      if isempty(name_fl_zam)==1
         name_fl_zam{1,1}='�����';
      end
   end

%������ ���� ������ � ���������� �� ��� �������� � ������ ����� 
name_fl_pas=struct2cell(dir([puti{3,2},'*.wks']));
if isempty(name_fl_pas)==1
         name_fl_pas{1,1}='�����';
end

%-----------------------------------------------------------------------
figure;
ex = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','�����','UserData',0);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 100/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[2])',...
   'String','���������','UserData',0);

pasp = uicontrol('Style','Pushbutton','Position',...
   [580/kof 170/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[3])',...
   'String','�������','UserData',0);

puttt = uicontrol('Style','Pushbutton','Position',...
   [580/kof 240/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[15])',...
   'String','��������','UserData',0);

      
prosm = uicontrol('Style','Pushbutton','Position',...
   [165/kof 420/kof 135/kof 20/kof],'Callback','uiresume,set(gco,''UserData'',[4])',...
   'String','����� ���������','UserData',0);

uicontrol('Style','text','String','���� ��������� ��� ��������� ������ �� ��������',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

uic(1)=uicontrol('Style','Checkbox','Position',[20/kof 445/kof 20/kof 20/kof],...
       'Max',1,'Value',A(1),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','������������ ����������� ����',...
          'Position',[40/kof 445/kof 260/kof 20/kof]);

filu= uicontrol('Style','listbox','String',name_fl_zam(1,:),'ListboxTop',1,...
  'Position',[400/kof 200/kof 160/kof 180/kof],'Max',2,'Value',1);
       uicontrol('Style','text','String','�������� ����� ��� ���������',...
          'Position',[400/kof 380/kof 160/kof 30/kof]);
       
flu_pas=[{'���'},name_fl_pas(1,:)];       
filu_pas= uicontrol('Style','listbox','String',flu_pas,'ListboxTop',2,...
  'Position',[400/kof 20/kof 160/kof 150/kof],'Max',2,'Value',1);
       uicontrol('Style','text','String','�������� ����� ���������',...
          'Position',[400/kof 170/kof 160/kof 30/kof]);
       
 uic(2)=uicontrol('Style','Checkbox','Position',[20/kof 420/kof 20/kof 20/kof],...
       'Max',1,'Value',A(2),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','�������� �����',...
          'Position',[40/kof 420/kof 125/kof 20/kof]);
       
uic(3)=uicontrol('Style','Checkbox','Position',[20/kof 390/kof 20/kof 20/kof],...
       'Max',1,'Value',A(3),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','����� �� ��������� ������',...
          'Position',[40/kof 390/kof 260/kof 20/kof]);       

uic(4)=uicontrol('Style','Checkbox','Position',[20/kof 365/kof 20/kof 20/kof],...
       'Max',1,'Value',A(4),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','����� �� ����� ��������',...
          'Position',[40/kof 365/kof 260/kof 20/kof]); 
       
uic(5)=uicontrol('Style','Checkbox','Position',[20/kof 340/kof 20/kof 20/kof],...
       'Max',1,'Value',A(5),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','����� �� ����������',...
          'Position',[40/kof 340/kof 260/kof 20/kof]);       

uic(6)=uicontrol('Style','Checkbox','Position',[20/kof 315/kof 20/kof 20/kof],...
       'Max',1,'Value',A(6),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','������� �������� �����������',...
          'Position',[40/kof 315/kof 260/kof 20/kof]);
            
uic(7)=uicontrol('Style','Checkbox','Position',[20/kof 290/kof 20/kof 20/kof],...
       'Max',1,'Value',A(7),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','�������� ������� ����������?',...
          'Position',[40/kof 290/kof 260/kof 20/kof]);
       
uic(8)=uicontrol('Style','Checkbox','Position',[20/kof 265/kof 20/kof 20/kof],...
       'Max',1,'Value',A(8),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','�������� ������� ��������?',...
          'Position',[40/kof 265/kof 260/kof 20/kof]);
    
uic(9)=uicontrol('Style','Checkbox','Position',[20/kof 240/kof 20/kof 20/kof],...
       'Max',1,'Value',A(9),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','�������� ������� ������. ��������?',...
          'Position',[40/kof 240/kof 260/kof 20/kof]);
uic(10)=uicontrol('Style','Checkbox','Position',[20/kof 215/kof 20/kof 20/kof],...
       'Max',1,'Value',A(10),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','������ ������������ ������?',...
          'Position',[40/kof 215/kof 260/kof 20/kof]);
              
 uic(11)=uicontrol('Style','Checkbox','Position',[20/kof 190/kof 20/kof 20/kof],...
       'Max',1,'Value',A(11),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','������������� �����������',...
          'Position',[40/kof 190/kof 260/kof 20/kof]);
       
 uic(12)=uicontrol('Style','Checkbox','Position',[20/kof 155/kof 20/kof 20/kof],...
       'Max',1,'Value',A(12),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','���������� ����� �����',...
          'Position',[40/kof 155/kof 180/kof 20/kof]);

              
 for sled=1:9      
       but(sled) = uicontrol('Style','Pushbutton','Position',...
       [300/kof (415-sled*25)/kof 60/kof 20/kof],...
       'String','�����','UserData',0);
 end
 but(10) = uicontrol('Style','Pushbutton','Position',...
       [220/kof 155/kof 140/kof 20/kof],...
       'String','����� �����','UserData',0);

 set(but(1),'Callback','uiresume,set(gco,''UserData'',[5])');
 set(but(2),'Callback','uiresume,set(gco,''UserData'',[6])');
 set(but(3),'Callback','uiresume,set(gco,''UserData'',[7])');
 set(but(4),'Callback','uiresume,set(gco,''UserData'',[8])');
 set(but(5),'Callback','uiresume,set(gco,''UserData'',[9])');
 set(but(6),'Callback','uiresume,set(gco,''UserData'',[10])');
 set(but(7),'Callback','uiresume,set(gco,''UserData'',[11])');
 set(but(8),'Callback','uiresume,set(gco,''UserData'',[12])');
 set(but(9),'Callback','uiresume,set(gco,''UserData'',[13])');
 set(but(10),'Callback','uiresume,set(gco,''UserData'',[14])');
 
 %�������� ������ ������� ���������� ���� �� �������� ��������������� 
 % �������
 for sled=4:9      
       set(but(sled),'Enable','off');
 end

%break;

gv=0; gg=0; gd=0; gp=0; gk=0;
gbut(1:10)=0;
gobsch=0;

while (gobsch==0)
     set(filu,'Value',1);
   
     for n_uic=1:12
       set(uic(n_uic),'Value',A(n_uic));
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
      for yyy=3:12
         %set(uic(yyy),'Value',0);
         set(uic(yyy),'Enable','off');
      end
   else
      set(prosm,'Enable','off');
      for yyy=3:12
         set(uic(yyy),'Enable','on');
      end
   end
   for yyy=3:12
      if A(yyy)==1&A(2)==0
         set(but(yyy-2),'Enable','on');
      else
         set(but(yyy-2),'Enable','off');
      end
   end
   
   %�������� ������ � ������  ������� ���������� ���� �� �������� ��������������� 
 % �������
 for sled=6:11      
    set(but(sled-2),'Enable','off');
    set(uic(sled),'Enable','off');
 end
 
   uiwait
   
for n_uic=1:12
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
      name_fl_zam=struct2cell(dir(strcat(path_f2,'*.dat')));
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

  
nf_zam=get(filu,'Value');

nf_pas=get(filu_pas,'Value')-1;

gv=get(ex,'UserData');
gp=get(prosm,'UserData');
gd=get(pasp,'UserData');
gg=get(ok,'UserData');
gk=get(puttt,'UserData');

   for sovt=1:10
      gbut(sovt)=get(but(sovt),'UserData');
   end
   gobsch=sum(gbut(:))+gv+gp+gd+gg+gk;
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
A1=A;
save ([gl_put,'ust1.mat'],'A1');%c:\Matlab\Toolbox\work\ust1.mat A1; %��������� ������ �� ���� � ����� ust1.mat 
%������ ������ ������ ��������� � ����������� ���������� ����
%"������� ������������� ��������� ������" ��� ���
if A(12)==1
   load ([gl_put,'ust_ot_neb.mat']);%c:\Matlab\Toolbox\work\ust_ot_neb.mat;
   load ([gl_put,'ust_ot_vib.mat']);%c:\Matlab\Toolbox\work\ust_ot_vib.mat;
   %�� ���� ������������
   %D()=Q(2);
   
   save ([gl_put,'ust_ot_neb.mat'],'C');%c:\Matlab\Toolbox\work\ust_ot_neb.mat C;
   save ([gl_put,'ust_ot_vib.mat'],'D');%c:\Matlab\Toolbox\work\ust_ot_vib.mat D;
end

switch gobsch
  case 2
   % ���� ���� ������ ������ 'O.K.'...  
     if A(2)==1
        %����������� �������� ����� ������...
        obr1(zam,puti); 
     else
        %��� ���������.
        soz_otch1(kot,pas,f_zam,puti);
        %msgbox('��������� ��������� ��� �� ��������!');
     end
   case 3
      % ���� ���� ������ ������ '�������' ����������� ������� pasport3[x].m 
      passport31(kot,pas,zam,puti);
   case 4
      % ���� ���� ������ ������ '����� ���������' ����������� ������� prosm_set[x]
      prosm_set1;
   case 5
      %����� ����� �� ������ �� ���������
      win_ot_neb1;
   case 6
      %����� ����� �� ������ �� ����� ��������
      win_ot_vib1;
   case 7
      %����� ����� �� ������ �� ����������
      win_ot_garm1;
   case 8
      %����� ����� �� �������� �������� �����������
   case 9
       %����� ����� �� �������� ������� ����������?
   case 10
      %����� ����� �� �������� ������� ��������?
   case 11
      %����� ����� �� �������� ������� ������. ��������?
   case 12
      %����� ����� �� ������ ������������ ������?
   case 13
      %����� ����� �� ������������� �����������
   case 14
      %����� ����� �� ����� �����
      win_obsch1;
   case 15
      %����� ���� � ������ ������� � ������
      feval('win_path1');
   end









