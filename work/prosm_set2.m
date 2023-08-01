function prosm_set()
% prosm_set ����� ���� ��������� ��� ���������
% ����� �������:
%               prosm_set
% ������������ ������: ���
% ������� ����������: ���


global gl_put; % ���� � �� ��������
global kof;% ���� ��� ��������� �������� ��� ���������
% ������ ����� ��������� � ������ B 
load ([gl_put,'ust1.mat']);%c:\Matlab\Toolbox\work\ust1.mat
%disp(A1);
if A1(1)==1
   %��� ������������ �����
   load ([gl_put,'ust_pros.mat']);%c:\Matlab\Toolbox\work\ust_pros.mat 
   else
   %��� �������������� �����
   load ([gl_put,'ust_pros1.mat']);%c:\Matlab\Toolbox\work\ust_pros1.mat
end
%disp(B);

%kof=1;
num_chan={1:16,'���'}; % ���-�� ������� ������� ������������
num_otm=(1:16);
num_otm2=(1:16);
%num_otm3=(1:16);
num_nab=(1:6);   % ����� ������ �������������

%---------------------------------------------------------------------
win1=figure;
uicontrol('Style','text','String','���� ��������� ��� ��������� ����� ������ ��������',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);

help_but = uicontrol('Style','Pushbutton','Position',...
   [580/kof 100/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','Help','UserData',0);


%uicontrol('Style','text','String','�������� ������ ��� ���������',...
   %'Position',[40/kof 60/kof 320/kof 20/kof]);
for nn=1:16
   uic(nn)=uicontrol('Style','Checkbox','Callback','uiresume','Position',...
      [480/kof (420-25*(nn-1))/kof 15/kof 15/kof],...
       'Max',1,'Value',B(nn),'Enable','on');
    %uicontrol('Style','text','String',(nn),'Position',...
       %[(20/kof)+(20/kof)*(nn) 20/kof 15/kof 15/kof]);
end
       
uicontrol('Style','text','String','������� ������',...
   'Position',[280/kof 440/kof 150/kof 20/kof]); 
uicontrol('Style','text','String','�����',...
   'Position',[420/kof 440/kof 60/kof 20/kof]);
uicontrol('Style','text','String','��������',...
          'Position',[480/kof 440/kof 80/kof 20/kof]);

for zzz=17:32      
uic(zzz)=uicontrol('Style','Popup','String',...
    num_chan,'Callback','uiresume','Position',[420/kof (420-25*(zzz-17))/kof 60/kof 20/kof],'Value',B(zzz));
       uicontrol('Style','text','String',zzz-16,...
          'Position',[400/kof (415-25*(zzz-17))/kof 20/kof 25/kof]);
end



uic(33)=uicontrol('Style','Checkbox','Position',[40/kof 120/kof 20/kof 20/kof],...
       'Max',1,'Value',B(33),'Enable','on');
       uicontrol('Style','text','String','��������� �������� � ������������?',...
          'Position',[60/kof 120/kof 300/kof 20/kof]);

uic(34)=uicontrol('Style','Popup','String',...
   num_otm,'Callback','uiresume','Position',[40/kof 90/kof 45/kof 20/kof],...
   'Value',B(34));
       uicontrol('Style','text','String','������� ������ ���������',...
          'Position',[85/kof 90/kof 275/kof 20/kof]);
       
uic(35)=uicontrol('Style','Edit','String',...
       B(35),'Position',[40/kof 380/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','������� ������ ���',...
          'Position',[120/kof 380/kof 240/kof 20/kof]);


uic(36)=uicontrol('Style','Edit','String',...
       B(36),'Position',[40/kof 320/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','��������� ������ ���������',...
          'Position',[120/kof 320/kof 240/kof 20/kof]);
uic(37)=uicontrol('Style','Edit','String',...
       B(37),'Position',[40/kof 300/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','�������� ������ ���������',...
          'Position',[120/kof 300/kof 240/kof 20/kof]);
         


uic(38)=uicontrol('Style','Checkbox','Position',[40/kof 260/kof 20/kof 20/kof],...
       'Max',1,'Value',B(38),'Enable','on');
       uicontrol('Style','text','String','������ ��������� ���������� �������',...
          'Position',[60/kof 260/kof 300/kof 20/kof]);
uic(39)=uicontrol('Style','Edit','String',...
       B(39),'Position',[40/kof 240/kof 80/kof 20/kof]);
       uicontrol('Style','text','String','���-�� �������� ��� ��������',...
          'Position',[120/kof 240/kof 240/kof 20/kof]);
       
uic(40)=uicontrol('Style','Checkbox','Position',[40/kof 200/kof 20/kof 20/kof],...
       'Max',1,'Value',B(40),'Enable','on');
       uicontrol('Style','text','String','������� ����. ������������ �������',...
          'Position',[60/kof 200/kof 300/kof 20/kof]);
       
uic(41)=uicontrol('Style','Popup','String',...
    num_nab,'Callback','uiresume','Position',[40/kof 160/kof 45/kof 20/kof],'Value',B(41));
       uicontrol('Style','text','String','����� ������ �������������',...
         'Position',[85/kof 160/kof 275/kof 20/kof]);
       

%-----------------------------------------------------------------------

gg=0;
gh=0;
while (gg==0)
      for n_uic=[1:34 38 40 41]
      set(uic(n_uic),'Value',B(n_uic));
     end
     
     for n_uic=[35:37 39]
        set(uic(n_uic),'String',B(n_uic));
     end
     if B(17)==17 %��� ������ ������� ������
        B(17)=1;
        set(uic(17),'Value',1);        
     end
         por_net=100; %����� ������� ������ � �������� ���������� '���' 
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
     num_otm2=sort(find(num_otm)); %������� ������� � ��������� �� �����������
     dl_vec=length(num_otm2);
     set(uic(34),'String',num_otm2)
     if B(34)>dl_vec   % ���� ����� ������ ������ ���������� ��  
        B(34)=num_otm2(dl_vec); % ��������� ��� �� ���������� 
        set(uic(34),'Value',B(34)); %����������
     end
  
    if(sum(B(1:16))&B(35))==0 %���� �� ������ �� ���� ����� � �������=0
        set(ok,'Enable','off'); % �� ������ ok ����������
     else
        set(ok,'Enable','on');
     end

     
uiwait

   % ������ �� ���� �������� �������� � �������� �� �� ������� ���� ��� ��� �����
for n_uics=[35:37 39]
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
      switch n_uics % � ����������� �� ������ ���� ������ �����. ��������������
         case 35
            B(n_uics)=abs(str2num(promeg));% �������� � ������� �����
         case 36
            B(n_uics)=abs(fix(str2num(promeg)));% �������� � ������ ������� �����
         case 37
            B(n_uics)=abs(fix(str2num(promeg)));% �������� � ������ ������� �����
         case 39
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
% �������� �������� ����������� �������� ����� ��� ������ ���������
% ���������
if B(39)>((B(37)-B(36))+1)/2 
   B(39)=((B(37)-B(36))+1)/2;
end

   for n_uic=[1:34 38 40 41]
     B(n_uic)=get(uic(n_uic),'Value');
   end

gg=get(ok,'UserData');
gh=get(help_but,'UserData');
   if gh==1
      help_prosm_set;
      %win2=figure;%���� ���� ��� "������"
      set(help_but,'UserData',0);% ���������� ��� ������ 'Help' ����� ������
      set(0,'CurrentFigure',win1);% ���������� ������� ���� ���� � ��������
   end
   
end
% ������ � ���� �������� ��������� ���������
close
if A1(1)==1
   save ([gl_put,'ust_pros.mat'],'B')%c:\Matlab\Toolbox\work\ust_pros.mat B; %��������� ������ �� ���� � ����� ust_pros.mat
else
   save ([gl_put,'ust_pros1.mat'],'B')%c:\Matlab\Toolbox\work\ust_pros1.mat B; %��������� ������ �� ���� � ����� ust_pros.mat
end

flags1;