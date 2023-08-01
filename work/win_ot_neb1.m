function win_ot_neb()
% prosm_set ����� ���� ��������� ��� ���������
% ����� �������:
%               prosm_set
% ������������ ������: ���
% ������� ����������: ���


global gl_put; % ���� � �� ��������
global gl_fun; %�������� �������� �������
global kof;% ���� ��� ��������� �������� ��� ���������
% ������ ����� ��������� � ������ C � 19-��� �������
load ([gl_put,'ust_ot_neb.mat'])%c:\Matlab\Toolbox\work\ust_ot_neb.mat
%disp(C);

%---------------------------------------------------------------------
figure;
uicontrol('Style','text','String','���� ��������� ��� ������ �� ���������',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);
uic(17)=uicontrol('Style','Checkbox','Position',[40/kof 400/kof 20/kof 20/kof],...
       'Max',1,'Value',C(17),'Enable','on');
       uicontrol('Style','text','String','�������� �� ����� ��������',...
          'Position',[60/kof 400/kof 300/kof 20/kof]);
       
uic(18)=uicontrol('Style','Checkbox',...
  'Position',[40/kof 360/kof 20/kof 20/kof],'Value',C(18));
       uicontrol('Style','text','String','�������� �� 1-�� ���������',...
         'Position',[60/kof 360/kof 300/kof 20/kof]);
      
uic(19)=uicontrol('Style','Checkbox',...
  'Position',[40/kof 320/kof 20/kof 20/kof],'Value',C(19));
       uicontrol('Style','text','String','��������-��� ������� ��������',...
         'Position',[60/kof 320/kof 300/kof 20/kof]);
uic(20)=uicontrol('Style','Checkbox',...
  'Position',[40/kof 280/kof 20/kof 20/kof],'Value',C(20));
       uicontrol('Style','text','String','��������� txt-���� ������?',...
         'Position',[60/kof 280/kof 300/kof 20/kof]);
         
uicontrol('Style','text','String','�������� ������ ��� ���������',...
   'Position',[40/kof 60/kof 320/kof 20/kof]);
for nn=1:16
   uic(nn)=uicontrol('Style','Checkbox','Callback','uiresume','Position',...
      [(20/kof)+(20/kof)*nn 40/kof 15/kof 15/kof],...
       'Max',1,'Value',C(nn),'Enable','on');
    uicontrol('Style','text','String',nn,'Position',...
       [(20/kof)+(20/kof)*nn 20/kof 15/kof 15/kof]);
end

       

%-----------------------------------------------------------------------

gg=0;
while (gg==0)
   for n_uic=1:20
      set(uic(n_uic),'Value',C(n_uic));
     end
     
     uiwait
     
   for n_uic=1:20
      C(n_uic)=get(uic(n_uic),'Value');
   end

   gg=get(ok,'UserData');
end
% ������ � ���� �������� ��������� ���������
close
save ([gl_put,'ust_ot_neb.mat'],'C');%c:\Matlab\Toolbox\work\ust_ot_neb.mat C; %��������� ������ �� ���� � ����� ust_pros.mat
feval(gl_fun);