function prosm_set()
% prosm_set ����� ���� ��������� ��� ���������
% ����� �������:
%               prosm_set
% ������������ ������: ���
% ������� ����������: ���


% ������ ����� ��������� � ������ B � 21-�� ������
load c:\Matlab\Toolbox\work\ust_pros.mat
%disp(B);
kof=1;% ���� ��� ��������� �������� ��� ���������
num_chan=(1:16); % ���-�� ������� ������� ������������
num_nab=(1:6);   % ����� ������ �������������

%---------------------------------------------------------------------
figure;
uicontrol('Style','text','String','���� ��������� ��� ��������� ����� ������ ��������',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);
uic(1)=uicontrol('Style','Edit','String',...
       B(1),'Position',[40/kof 400/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','������� ������ ���',...
          'Position',[120/kof 400/kof 240/kof 20/kof]);
       
uic(2)=uicontrol('Style','Popup','String',...
    num_chan,'Callback','uiresume','Position',[40/kof 360/kof 45/kof 20/kof],'Value',B(2));
       uicontrol('Style','text','String','���-�� ������� ������',...
         'Position',[85/kof 360/kof 275/kof 20/kof]);
      
uic(3)=uicontrol('Style','Edit','String',...
       B(3),'Position',[40/kof 320/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','��������� ������ ���������',...
          'Position',[120/kof 320/kof 240/kof 20/kof]);
uic(4)=uicontrol('Style','Edit','String',...
       B(4),'Position',[40/kof 300/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','�������� ������ ���������',...
          'Position',[120/kof 300/kof 240/kof 20/kof]);
         
uicontrol('Style','text','String','�������� ������ ��� ���������',...
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
       uicontrol('Style','text','String','������ ��������� ���������� �������',...
          'Position',[60/kof 260/kof 300/kof 20/kof]);
uic(22)=uicontrol('Style','Edit','String',...
       B(22),'Position',[40/kof 240/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','���-�� �������� ��� ��������',...
          'Position',[120/kof 240/kof 240/kof 20/kof]);
       
uic(23)=uicontrol('Style','Checkbox','Position',[40/kof 200/kof 20/kof 20/kof],...
       'Max',1,'Value',B(23),'Enable','on');
       uicontrol('Style','text','String','������� ����. ������������ �������',...
          'Position',[60/kof 200/kof 300/kof 20/kof]);
       
uic(24)=uicontrol('Style','Popup','String',...
    num_nab,'Callback','uiresume','Position',[40/kof 160/kof 45/kof 20/kof],'Value',B(24));
       uicontrol('Style','text','String','����� ������ �������������',...
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

   % ������ �� ���� �������� �������� � �������� �� �� ������� ���� ��� ��� �����
for n_uics=[1 3 4 22]
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
      switch n_uics % � ����������� �� ������ ���� ������ �����. ��������������
         case 1
            B(n_uics)=abs(str2num(promeg));% �������� � ������� �����
         case 3
            B(n_uics)=abs(fix(str2num(promeg)));% �������� � ������ ������� �����
         case 4
            B(n_uics)=abs(fix(str2num(promeg)));% �������� � ������ ������� �����
         case 22
            B(n_uics)=abs(fix(str2num(promeg)));% �������� � ������ ������� �����
      end
   else
      B(n_uics)=0;
      msgbox('� ����� �� ���� �������� ����������� ������� ������','���������')
   end
end
%�������� � ����������� ��������� ����� ������ � ��� ����� �������� ��
% ������������ �.�.���(�� 1 �� 12 ��� �� 2 �� 13) ���� �� ����� 
%����������� ������ ������ ��������
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
% �������� �������� ����������� �������� ����� ��� ������ ���������
% ���������
if B(22)>((B(4)-B(3))+1)/2 
   B(22)=((B(4)-B(3))+1)/2;
end

   for n_uic=[2 5:20 21 23 24]
     B(n_uic)=get(uic(n_uic),'Value');
   end

   gg=get(ok,'UserData');
end
% ������ � ���� �������� ��������� ���������
close
save c:\Matlab\Toolbox\work\ust_pros.mat B; %��������� ������ �� ���� � ����� ust_pros.mat
flags1;