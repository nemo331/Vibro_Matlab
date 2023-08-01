function win_stat_obr()
% prosm_set ����� ���� ��������� ��� ���������
% ����� �������:
%               win_stat_obr
% ������������ ������: ���
% ������� ����������: ���


global gl_put; % ���� � �� ��������
global gl_fun; %�������� �������� �������
global kof;% ���� ��� ��������� �������� ��� ���������
% ������ ����� ��������� � ������ F � 20-��� �������
load ([gl_put,'ust_stat.mat']);%c:\Matlab\Toolbox\work\ust_ot_vib.mat
%disp(F);
load ([gl_put,'ust1.mat']);
if A1(1)==1
   %��� ������������ �����
   load ([gl_put,'ust_pros.mat']);
   else
   %��� �������������� �����
   load ([gl_put,'ust_pros1.mat']);
end
%disp(B);
if B(38)==1
   oc={'�� ��������  ','�� ������������������� ��������','�� ���������� ��������'};
else
   oc={'�� ��������  ','�� ������������������� ��������'};
   F(1)=2;
end

graf={'�� ������������ ��������','�� �������� ��������','�� ������������� ��������'};
%break;
%---------------------------------------------------------------------
figure;
uicontrol('Style','text','String','���� ��������� ��� ��������������� �������',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);

uic(1)=uicontrol('Style','Popup','String',...
    oc,'Position',[40/kof 400/kof 320/kof 20/kof],'Value',F(1));
       uicontrol('Style','text','String','��� ��������� ��� �������',...
          'Position',[40/kof 420/kof 320/kof 20/kof]);
       
uic(2)=uicontrol('Style','Popup','String',...
    graf,'Position',[40/kof 340/kof 320/kof 20/kof],'Value',F(2));
       uicontrol('Style','text','String','����� �����',...
          'Position',[40/kof 360/kof 320/kof 20/kof]);

 
uic(3)=uicontrol('Style','Checkbox','Position',[40/kof 300/kof 20/kof 20/kof],...
       'Max',1,'Value',F(3),'Callback','uiresume','Enable','on');
       uicontrol('Style','text','String','������ � ������ ������������ ����������',...
          'Position',[60/kof 300/kof 300/kof 20/kof]);
       
uic(4)=uicontrol('Style','Checkbox','Position',[40/kof 240/kof 20/kof 20/kof],...
       'Max',1,'Value',F(4),'Enable','on');
       uicontrol('Style','text','String','���� � ������� ����. ������� (������.wks)',...
          'Position',[60/kof 240/kof 300/kof 20/kof]);
       
uic(5)=uicontrol('Style','Edit','String',...
       F(5),'Position',[40/kof 280/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','����������� ����������',...
          'Position',[120/kof 280/kof 240/kof 20/kof]);
       
uic(6)=uicontrol('Style','Checkbox','Position',[40/kof 200/kof 20/kof 20/kof],...
       'Max',1,'Value',F(6),'Enable','on');
       uicontrol('Style','text','String','������ �� ��������������� �������',...
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
   if isempty(promeg)~=0 % ���� ����� ������ �������� ������� ����� ����
         prost=1;
   end
   for jjj=1:sdf
      if isletter(promeg(jjj))~=0 % ���� ������ �������� ������ �������� ������� ����� ����
         prost=1;
      end
   end
   if prost==0
         if n_uics==5
            F(n_uics)=abs(str2num(promeg));% �������� � ������� �����
         else
            F(n_uics)=abs(str2num(promeg));% �������� � ������� �����
         end   
   else
      F(n_uics)=0;
      msgbox('� ����� �� ���� �������� ����������� ������� ������','���������')
   end
end

   gg=get(ok,'UserData');
end
% ������ � ���� �������� ��������� ���������
close
save ([gl_put,'ust_stat.mat'],'F');%c:\Matlab\Toolbox\work\ust_ot_vib.mat D; %��������� ������ �� ���� � ����� ust_pros.mat
prosm_set1;