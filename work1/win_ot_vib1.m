function win_ot_vib()
% prosm_set ����� ���� ��������� ��� ���������
% ����� �������:
%               win_ot_vib
% ������������ ������: ���
% ������� ����������: ���


global gl_put; % ���� � �� ��������
global gl_fun; %�������� �������� �������
global kof;% ���� ��� ��������� �������� ��� ���������
% ������ ����� ��������� � ������ D � 20-��� �������
load ([gl_put,'ust_ot_vib.mat']);%c:\Matlab\Toolbox\work\ust_ot_vib.mat
%disp(D);
oc={'�� ������������������� ��������','�� ���������� ��������','�� ��������  '};
graf={'�� ������������������� ��������','�� ���������� ��������','�� ��������  '};
osX={'������-���������','�������,����� ���������'};
%---------------------------------------------------------------------
figure;
uicontrol('Style','text','String','���� ��������� ��� ������ �� ������ ����� ��������',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);

uic(17)=uicontrol('Style','Popup','String',...
    oc,'Position',[40/kof 400/kof 320/kof 20/kof],'Value',D(17));
       uicontrol('Style','text','String','������ � ������',...
          'Position',[40/kof 420/kof 320/kof 20/kof]);
           
uic(19)=uicontrol('Style','Checkbox','Callback','uiresume',...
  'Position',[40/kof 320/kof 20/kof 20/kof],'Value',D(19));
       uicontrol('Style','text','String','�������� ������ ����� ��������',...
          'Position',[60/kof 320/kof 300/kof 20/kof]);
       
uic(20)=uicontrol('Style','Checkbox','Callback','uiresume',...
  'Position',[40/kof 140/kof 20/kof 20/kof],'Value',D(20));
       uicontrol('Style','text','String','������� wks-���� ������ � Excel',...
         'Position',[60/kof 140/kof 300/kof 20/kof]);

uic(21)=uicontrol('Style','Checkbox','Callback','uiresume',...
  'Position',[40/kof 180/kof 20/kof 20/kof],'Value',D(21));
       uicontrol('Style','text','String','��������� wks-���� ������?',...
          'Position',[60/kof 180/kof 300/kof 20/kof]);
uic(22)=uicontrol('Style','Popup','String',...
    osX,'Position',[40/kof 280/kof 320/kof 20/kof],'Value',D(22));
       uicontrol('Style','text','String','�� ��� X �������: ',...
          'Position',[40/kof 300/kof 320/kof 20/kof]);

         
uicontrol('Style','text','String','�������� ������ ��� ���������',...
   'Position',[40/kof 60/kof 320/kof 20/kof]);
for nn=1:16
   uic(nn)=uicontrol('Style','Checkbox','Callback','uiresume','Position',...
      [(20/kof)+(20/kof)*nn 40/kof 15/kof 15/kof],...
       'Max',1,'Value',D(nn),'Enable','on');
    uicontrol('Style','text','String',nn,'Position',...
       [(20/kof)+(20/kof)*nn 20/kof 15/kof 15/kof]);
end

       

%-----------------------------------------------------------------------

gg=0;
while (gg==0)
   for n_uic=[1:17 19 20 21 22]
      set(uic(n_uic),'Value',D(n_uic));
     end
     if D(21)==0
        set(uic(20),'Value',0);
        set(uic(20),'Enable','off');
     else
        set(uic(20),'Enable','on');
     end
     
     if(sum(D(1:16)))==0
        msgbox('�� ������� �� ������ ������','���������');
     end
     
     if(sum(D(19:21)))==0
        msgbox('�� ������� �� ����� ����� ������','���������');
     end 
     
     if(sum(D(1:16))&sum(D(19:21)))==0
        set(ok,'Enable','off');
     else
        set(ok,'Enable','on');
     end

     uiwait
     
   for n_uic=[1:17 19 20 21 22]
      D(n_uic)=get(uic(n_uic),'Value');
   end

   gg=get(ok,'UserData');
end
% ������ � ���� �������� ��������� ���������
close
save ([gl_put,'ust_ot_vib.mat'],'D');%c:\Matlab\Toolbox\work\ust_ot_vib.mat D; %��������� ������ �� ���� � ����� ust_pros.mat
feval(gl_fun);