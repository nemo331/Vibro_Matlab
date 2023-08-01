function passport3(dia_any,name_f_pas,naz_f)
% passport3 ����������� � ���� ������ ���������� �� �����
% ����� �������:
%               passport3
% ������������ �������:
%                      wk1read1,,wk1write1,findnr
% ������������ ������� MATLAB:
%                            wk1read
% ������� ����������: dia_any, path_f, name_f  

%dia_any=1; %1-����� DIAGNOST, 2-����� �����(DSK)
%path_f='�:\DIAGNOST\BIN\'; %���� �� �����
name_f=lower(naz_f);
%name_f='lamp__04.bin'; %�������� ����� ������
if dia_any==1
   %name_f_pas='d:\DIAGR\soho.txt';
   hi = waitbar(1,'�����...');
   %name_f_pas='c:\MATLAB\toolbox\work2\������_�������2.wks';
   %������ ����� � ���������� ������� (������ **.wks(Lotus 1-2-3))
   % � ������ �����
   aaa = WK1READ1(name_f_pas,0,0,[1 1 1 33]);%������ ������ ������
   kz=300;
   vvv = WK1READ(name_f_pas,1,0,[2 1 kz 1]);%��������������� ������ ��� ���������� ���-�� �������
   fff = vvv'; 
   kz=length(fff(1,:));
   sss = WK1READ1(name_f_pas,1,0,[2 1 (kz+1) 33]);%������������� ������  
   ccc=sss'; % ���������������� ������� �����
   % �������������� ����� �� ������� ��� � ��������� �������� ������� ���������� ����
   % � ����: �����/�����/��� � �������� �� � ��������� ddd
   dlin=length(ccc(4,:));
   dd=cell2struct(ccc(4,:),'dat',dlin);
   ddd=struct('dates',cell(1,dlin));
   for ndl=1:dlin
      % �������������� � ������������� MATLAB �� ������������� Lotus (+693960)
      % ����� ��������� ������ ��������������� ���� � ������ � ��������� ddd
      if isempty(dd(ndl).dat)~=0
         ddd(1,ndl).dates=' ';
      else
         ddd(1,ndl).dates=(datestr((dd(ndl).dat+693960),1));
      end
   end
   %stracta=fpas_read4(dia_any,path_f,name_f,name_f_pas);
   close(hi)
else
   stracta=fpas_read4(dia_any,path_f,name_f);
end

for nwr=dlin:-1:1
   naz_file=cell2struct(ccc(2,nwr),'fl',2);
   if strcmp(name_f,naz_file.fl)~=0
      zn_osn=nwr; %����� �������� � ���� �������� �����
      break
   else
      zn_osn=1;
   end
end

kof=1;% ���� ��� ������������� �������� ����� ��������� (������, ���� � �.�. �� �����)
%ccc=struct2cell(stracta);
naz_reg={'���','���','���','���','���','���',' '}; % �������� �������
num_ga={1:10,' '}; % ������ ���������  
%zn_osn=1; %����� �������� � ���� �������� �����
nab=(1:5);%����� ������������� ��� ���������� �� ���� ���

% ������������ ���� � ������� ���������� �� �����
ok = uicontrol('Style','Pushbutton','Position',...
   [600/kof 30/kof 50/kof 50/kof], 'Callback','uiresume,set(gco,''UserData'',[1])',...
   'String','O.K.','UserData',0);
 osn = uicontrol('Style','Popup','String',...
    ccc(2,:),'Position',[140/kof 450/kof 130/kof 20/kof],'Callback','uiresume',...
    'Value',zn_osn);
       uicontrol('Style','text','String','�������� �����',...
          'Position',[140/kof 470/kof 130/kof 15/kof]);
       %set(osn,'String',ccc(1,:))
       osn2=uicontrol('Style','Popup','String',ccc(1,:),'Position',...
          [20/kof 450/kof 100/kof 20/kof],'Callback','uiresume','Value',zn_osn);
       uicontrol('Style','text','String','���������� �����',...
          'Position',[20/kof 470/kof 100/kof 30/kof]);
     % ga=find(num_ga==str2num(ccc{3,zn_osn}))%stracta(zn_osn).NGA)) 
 NGA=uicontrol('Style','Popup','String',...
    num_ga,'Position',[290/kof 450/kof 45/kof 20/kof],'Value',ccc{3,zn_osn});
       uicontrol('Style','text','String','N��',...
         'Position',[290/kof 470/kof 45/kof 15/kof]);
      
 Date=uicontrol('Style','Edit','String',...
    ddd(1,zn_osn).dates,'Position',[350/kof 450/kof 95/kof 20/kof]);
       uicontrol('Style','text','String','����',...
          'Position',[350/kof 470/kof 95/kof 15/kof]);
       
       Regim=uicontrol('Style','Popup','String',naz_reg,'Position',...
          [455/kof 450/kof 60/kof 20/kof],'Value',findnr(naz_reg,ccc{5,zn_osn}));
       uicontrol('Style','text','String','�����',...
          'Position',[455/kof 470/kof 60/kof 15/kof]);
       
 Podregim=uicontrol('Style','Edit','String',...
    ccc{6,zn_osn},'Position',[525/kof 450/kof 65/kof 20/kof]);
       uicontrol('Style','text','String','��������',...
          'Position',[525/kof 470/kof 65/kof 15/kof]);
       
 Nabor=uicontrol('Style','Popup','String',...
    nab,'Position',[600/kof 450/kof 50/kof 20/kof],'Value',1);
       uicontrol('Style','text','String','�����',...
          'Position',[600/kof 470/kof 50/kof 15/kof]);

       
 frec = uicontrol('Style','edit','String',400,'Position',...
          [20/kof 380/kof 100/kof 20/kof],'Enable','off');
    uicontrol('Style','text','String','������� ������',...
       'Position',[20/kof 400/kof 100/kof 30/kof]);


otch= uicontrol('Style','edit','String',8192,...
  'Position',[140/kof 380/kof 100/kof 20/kof],'Enable','off');
       uicontrol('Style','text','String','���-�� ��������',...
          'Position',[140/kof 400/kof 100/kof 30/kof]);
       
uicontrol('Style','text','String','�����,              ����� ,N ���',...
          'Position',[20/kof 340/kof 200/kof 20/kof]); 
for nn=1:16
   if isempty(ccc{(nn+17),zn_osn})~=1, vval=1;
   else, vval=-1;
   end
   ChanC(nn)=uicontrol('Style','Checkbox','Position',[20/kof (342/kof)-(20/kof)*nn 15/kof 15/kof],...
       'Max',vval,'Value',vval,'Enable','off');
Chan(nn)=uicontrol('Style','Edit','String',...
    ccc{(nn+17),zn_osn},'Position',[75/kof (340/kof)-(20/kof)*nn 200/kof 20/kof]);
uicontrol('Style','text','String',nn,'Position',[35/kof (340/kof)-(20/kof)*nn 40/kof 20/kof]);
end


uicontrol('Style','text','String','������������� ���������',...
   'Position',[280/kof 400/kof 180/kof 30/kof]);
uicontrol('Style','text','String','������ ���������',...
   'Position',[470/kof 400/kof 180/kof 30/kof]);

for n=1:10
   if n<=5
   Param(n)=uicontrol('Style','Edit','String',...
   ccc{(n+6),zn_osn},'Position',[360/kof (400/kof)-(20/kof)*n 100/kof 20/kof]);
   else
   Param(n)=uicontrol('Style','Edit','String',...
   ccc{(n+6),zn_osn},'Position',[550/kof (500/kof)-(20/kof)*n 100/kof 20/kof]);
   end
end

uicontrol('Style','text','String','P,���','Position',[280/kof 380/kof 80/kof 20/kof]);
uicontrol('Style','text','String','Q,����','Position',[280/kof 360/kof 80/kof 20/kof]);
uicontrol('Style','text','String','I�,��','Position',[280/kof 340/kof 80/kof 20/kof]);
uicontrol('Style','text','String','I��,��','Position',[280/kof 320/kof 80/kof 20/kof]);
uicontrol('Style','text','String','U��,��','Position',[280/kof 300/kof 80/kof 20/kof]);
uicontrol('Style','text','String','��,�','Position',[470/kof 380/kof 80/kof 20/kof]);
uicontrol('Style','text','String','��,���','Position',[470/kof 360/kof 80/kof 20/kof]);
uicontrol('Style','text','String','�������,%','Position',[470/kof 340/kof 80/kof 20/kof]);
uicontrol('Style','text','String','t�,�C','Position',[470/kof 320/kof 80/kof 20/kof]);
uicontrol('Style','text','String','�����,�','Position',[470/kof 300/kof 80/kof 20/kof]);

uicontrol('Style','text','String','����������','Position',[280/kof 270/kof 300/kof 20/kof]);
Remark=uicontrol('Style','edit','String',ccc{17,zn_osn},'Max',100,...
   'Position',[280/kof 20/kof 300/kof 250/kof],'HorizontalAlignment','left');


gg=0;    
while gg==0 % ��������� ���� ���� �� ������ ������ 'O.K.'
      
   vosn = get(osn,'Value');
   vosn2=get(osn2,'Value');
   if zn_osn~=vosn, zn_osn=vosn;
   else, zn_osn=vosn2;
   end
% ��������� � ����� ����� �������� ��������������� ����������� ����� ������ (zn_osn)   
set(osn,'Value',zn_osn);
set(osn2,'Value',zn_osn);
if isspace(ccc{3,zn_osn})~=0, set(NGA,'Value',11);
else, set(NGA,'Value',ccc{3,zn_osn});
end
set(Date,'String',ddd(1,zn_osn).dates);
set(Regim,'Value',findnr(naz_reg,ccc{5,zn_osn}));
set(Podregim,'String',ccc{6,zn_osn});
set(Nabor,'Value',1);

for nnnn=1:16
   set(Chan(nnnn),'String',ccc{(nnnn+17),zn_osn});
end

for nvn=1:10
   set(Param(nvn),'String',ccc{(nvn+6),zn_osn});
end
set(Remark,'String',ccc{17,zn_osn});

uiwait
%��������� �� ���� ����� �������� � ������ �� � ������ �����
pr_zn=get(NGA,'Value');
if pr_zn==11, ccc{3,zn_osn}=' ';
else, ccc{3,zn_osn}=pr_zn;
end
ddd(1,zn_osn).dates=get(Date,'String');
if (isempty(ddd(1,zn_osn).dates)~=0 | isspace(ddd(1,zn_osn).dates)~=0),ccc{4,zn_osn}=1;
else, ccc{4,zn_osn}=datenum(ddd(1,zn_osn).dates)-693960;
end
pr_zn2=get(Regim,'Value');
if  pr_zn2==0 ,pr_zn2=7;
end

reg_struc=cell2struct(naz_reg(pr_zn2),'freg',2);
ccc{5,zn_osn}=reg_struc.freg;
ccc{6,zn_osn}=get(Podregim,'String');
%ccc{36,zn_osn}=get(Nabor,'Value');

for eeee=1:16
   ccc{(eeee+17),zn_osn}=get(Chan(eeee),'String');
end

for eee=1:10
   ccc{(eee+6),zn_osn}=get(Param(eee),'String');
end
ccc{17,zn_osn}=get(Remark,'String');

gg=get(ok,'UserData');
end

close
hite = waitbar(1,'�����...');
sss=ccc'; % ���������������� ������� �����
rrr=[aaa;sss]; % ����������� ������ ������ ����� � ���������� ��������
wk1write1(name_f_pas,rrr,0,0)
close(hite)
flags1;







