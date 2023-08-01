function win_path1()
% win_path ����� ���� � ������ ������� � ������
% ����� �������:
%               win_path
% ������������ ������: ���
% ������� ����������: ���

global gl_put; % ���� � �� ��������
global gl_fun; %�������� �������� �������
global kof;% ���� ��� ��������� �������� ��� ���������

% ������ ����� � ������ ������� � ������ ������
puti = WK1READ1([gl_put,'path_dir.wks'],0,0,[1 1 7 2]);
%celldisp(puti)


%---------------------------------------------------------------------
figure;
uicontrol('Style','text','String','���� ����� ������� � ��������� ������',...
          'Position',[20/kof 470/kof 635/kof 30/kof],'FontSize',12);

ok = uicontrol('Style','Pushbutton','Position',...
   [580/kof 30/kof 70/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);


for nn=1:7
   uic(nn)=uicontrol('Style','Edit','Callback','uiresume','Position',...
      [320/kof (440/kof)-(40/kof)*nn 300/kof 20/kof],...
       'String',puti{nn,2},'Enable','on');
    uicontrol('Style','text','String',puti{nn,1},'Position',...
       [20/kof (440/kof)-(40/kof)*nn 300/kof 20/kof],...                
       'HorizontalAlignment','right');
end

%break;       

%-----------------------------------------------------------------------

gg=0; 
while (gg==0)
   pr=0;
   for n_uic=1:7
      set(uic(n_uic),'String',puti{n_uic,2});
     end
     
     uiwait
     
   for n_uic=1:7
      puti{n_uic,2}=get(uic(n_uic),'String');
      dl_str=length(puti{n_uic,2});
      naz_puti= puti{n_uic,2};
      if strcmp(naz_puti(dl_str),'\')~=1
         naz_puti=[naz_puti,'\'];
         puti{n_uic,2}= naz_puti;
      end
      if exist(puti{n_uic,2})~=7
         
         pr=n_uic;
         
      end
   end
   % ��������� ������� ���� ���������
   if pr~=0
      set(ok,'Enable','off');
      msgbox(['������� ',puti{pr,2},' �� ������'],'���������')
   else
      set(ok,'Enable','on');
   end
   gg=get(ok,'UserData');
end
% ������ � ���� �������� ��������� ���������
close
wk1write1([gl_put,'path_dir.wks'],puti,0,0)%��������� ������ 
feval(gl_fun);
