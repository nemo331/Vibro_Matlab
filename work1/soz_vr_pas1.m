function osh=soz_vr_pas(dia_any,name_f_pas,f_zam,vrem_f_pas,puti)

% soz_vr_pas ������� ��� �������� ���������� ����� ��������� �� ����������
% ����� �������:
%               soz_vr_pas1(dia_any,name_f_pas,f_zam)
% ��� dia_any-�����������(1) ��� ������������� ����(0)
% name_f_pas - �������� ����� ��������� (��� ����� ��������)
% f_zam - ��������� � ���������� ������ ������� ������� �������
% ������������ �������:
%                      
% ������������ ������� MATLAB:
%                            
% �������� ����������:vrem_f_pas - �������� ���������� ����� � ����������

osh=0;
%path_f_zam=puti{1,2}%'C:\Matlab\Toolbox\work3\';
path_f_vrem=puti{5,2};%���� �� ���������� ����� ���������
path_f_pas=puti{3,2};%'C:\Matlab\Toolbox\work2\'; %���� �� ����� ���������
%vrem_f_pas='vrem_pas.wks'; %�������� ���������� ����� ���������
kol_f_zam=length(f_zam); %���������� ��������� ������ �������
mat_kol_f=[1:kol_f_zam]; % ������-������ � ����������� �������� ���� ������
%name_f=lower(f_zam(1).name); %�������� ������� � ������ ����� ������
%break;
if dia_any>0
   hi = waitbar(0,'����� ���������� ������. �����...');
   por_n_f=1; %���������� ����� ����� ������� �� ������� mat_kol_f
   n_f_pasvse=name_f_pas;% ���� ������ ����� ����� �������� ����� '���'
   kol_kr=0;% ���-�� ������ while  
   while length(mat_kol_f)~=0
      %por_n_f= por_n_f+1;
      name_f=lower(f_zam(mat_kol_f(por_n_f)).name);
   %������ ����� � ���������� ������� (������ **.wks(Lotus 1-2-3))
   % � ������ �����
   
      if n_f_pasvse==0%strcmp('���',n_f_pasvse)==1
         name_fl_pas=dir([path_f_pas,'*.wks']);%������ �� ��� �������� ����� ������ ���������
         kol_f_=length(name_fl_pas);   %���������� ���-�� ���������
         kol_f_pas=1:kol_f_;
      else 
         name_fl_pas=dir([path_f_pas,'*.wks']);
         %name_fl_pas=struct('name',name_f_pas);
         kol_f_pas=name_f_pas;
      end
      waitbar(0.1)  
      for gh=kol_f_pas
       aaa = WK1READ1([path_f_pas,name_fl_pas(gh).name],0,0,[1 1 1 34]);%������ ������ ������
       kz=300;
       vvv = WK1READ1([path_f_pas,name_fl_pas(gh).name],1,0,[2 1 kz 2]);%��������������� ������ ��� ���������� ���-�� �������
       fff = vvv'; 
       kz=length(fff(1,:));
       nmn=cell2struct(fff(2,:),'name',kz);
       sovp=0;
         for sd=1:kz
          sovp=strcmp (name_f,nmn(sd).name);
          if sovp==1
             break;
          end
         end
          if sovp==1
             name_f_pas=name_fl_pas(gh).name;
             break;
          end
      end
       if sovp==0
          strochka=sprintf('��� ���������� ������ �� �����: %s',...
             name_f);
           mat_kol_f(por_n_f)=[];
           msgbox(strochka,'���������')
           %close(hi)
               
       else
       waitbar(0.4)
       sss = WK1READ1([path_f_pas,name_f_pas],1,0,[2 1 (kz+1) 34]);%������������� ������  
       %celldisp(sss(1,:))
       if kol_kr==0
          rrr=aaa;
       end
       waitbar(0.6)
       %����� ������ ����� ������ �� ��������� ������ � ������� ����� sss
       tec_por=mat_kol_f;
       
       for bds=tec_por
          f_popor=lower(f_zam(bds).name);  
          sovp=0;
          for sd=1:kz
             sovp=strcmp (f_popor,sss{sd,2});
             if sovp==1
                %�������� ������ ����� � ����� ������ �����
                rrr=[rrr;sss(sd,:)];
                poriadkov_n=find(mat_kol_f==bds);
                mat_kol_f(poriadkov_n)=[];

                break;
             end
          end
       end
       waitbar(0.9)
       kol_kr=kol_kr+1;
   end    
       %break;       
   end %����� ����� while length(mat_kol_f)~=0
    close(hi)
    %disp(rrr)
    %break;
    
    % ���������� ������� �� ��������� ����� ��� �������(��,���,���,��)
    kol_zapis=size(rrr,1);
    bbb=zeros(1,kol_zapis);
     for sdd=2:kol_zapis
        % �������� �� ������������ �������� ������� �� 
       if isnumeric(rrr{sdd,3})==1
          if rrr{sdd,3}<1|rrr{sdd,3}>10, bbb(sdd)=sdd;
          else, rrr{sdd,3}=fix(rrr{sdd,3});
          end
       elseif isstr(rrr{sdd,3})==1
          % ������������� ������ � �����
          sdf=length(rrr{sdd,3});
          promeg=rrr{sdd,3};
           prost=0;
           for jjj=1:sdf
              if isletter(promeg(jjj))==1 
                 prost=1;
              end
           end
           if prost==1
              bbb(sdd)=sdd;
           else
              rrr{sdd,3}=str2num(rrr{sdd,3});
              if rrr{sdd,3}<1|rrr{sdd,3}>10, bbb(sdd)=sdd;
              else, rrr{sdd,3}=fix(rrr{sdd,3});
              end
           end
       else
          % ���� �� ������������� ���� ������ �������� �� �������� ��� ������ 
          bbb(sdd)=sdd;
       end  
    end
    % ���������� ������ �������
    %ccc=rrr(1,:);
    for sdd=2:kol_zapis
       if bbb(sdd)>0
          rrr(bbb(sdd),:)=[];
          bbb=bbb-1;
          %ccc=[ccc;rrr(sdd,:)];
       end
    end    
    
    if (size(rrr,1))<kol_zapis
       msgbox('������� ������ �� � ����� ���������','���������')
       if (size(rrr,1))<2
          return;
       end
    end
    
    %disp(bbb)
    %disp(rrr)
    %����� ����� �� ������� ������ ����� �����������...
    kol_zapis=size(rrr,1);
    nom_ga=zeros(1,(kol_zapis-1));
    for fff=1:kol_zapis-1
       nom_ga(fff)=rrr{(fff+1),3};
    end
    ppp=zeros(1,10);
       for nppp=1:10
          ppp(nppp)=length(find(nom_ga==nppp));
       end
    max_kol_ga=find(ppp==max(ppp));
    % ...��������� ������ �������
    fff=1;
    while fff~=kol_zapis
       fff=fff+1;
       if rrr{fff,3}~=max_kol_ga(1)
          rrr(fff,:)=[];
          fff=fff-1;
          kol_zapis=kol_zapis-1;
       end       
    end
    %disp(rrr)
    
    %�������� �������� �������
    hhh=rrr(1,:);
    naz_reg={'���','���','���','���','���','���'};
    skolko=zeros(1,6);
    kotor=0;
    for por_pr=1:6
    kol_zapis=size(rrr,1);% ���-�� ������� � ��� ���� ������� ���������
    fff=1;
    while fff~=kol_zapis
       fff=fff+1;
       if ischar(rrr{fff,5})==1 % ���� ������ ��������...
          rrr{fff,5}=lower(rrr{fff,5});
          if (strcmp(rrr{fff,5},naz_reg{por_pr}))==1%...� ���� �������������
             hhh=[hhh;rrr(fff,:)];    % �������� ������
             kotor=kotor+1;           % ��������� � ������ �������
          end
       else                      % ���� �� ������ ��������
          rrr(fff,:)=[];         % �������
          fff=fff-1;
          kol_zapis=kol_zapis-1;
       end       
    end
    skolko(por_pr)=kotor;
    end
    
    %disp(skolko) 
    kol_zap1=size(hhh,1);
    %disp(hhh)
    % �������� �������� ���������� ��� ���� ������� � � ����������� ��
    % ������� ��������, �������������� ��� ���������� � ����� ����
    sdd=1;
    skolko=skolko+1;
    vuchit=0;
    for por_nem=1:6
       skolko(por_nem)=skolko(por_nem)-vuchit;% ������� ���-�� ������ � ����������� �� ���������
       kol_zapis=skolko(por_nem);
    while sdd~=kol_zapis
       sdd=sdd+1;
       %if sdd>kol_zapis, break, end
       if (isnumeric(hhh{sdd,6})==1) % ��� �������� ��������
          if (strcmp(hhh{sdd,5},'���')==1)% ���� ���� ������� ������ �� 
             hhh(sdd,:)=[];               % ����� ���������
             sdd=sdd-1;
             kol_zapis=kol_zapis-1;
             skolko(por_nem)=skolko(por_nem)-1;
             vuchit=vuchit+1;
          else                             % ����� �������� � ����� ����
             hhh{sdd,6}=fix(hhh{sdd,6});
          end
       elseif isstr(hhh{sdd,6})==1  %��� ������ �������� 
          % ������������� ������ � �����
          sdf=length(hhh{sdd,6});
          promeg=hhh{sdd,6};
           prost=0;
           for jjj=1:sdf
              if (strcmp(promeg(jjj),'0')~=1)&(strcmp(promeg(jjj),'1')~=1)&...
                    (strcmp(promeg(jjj),'2')~=1)&(strcmp(promeg(jjj),'3')~=1)&...
                    (strcmp(promeg(jjj),'4')~=1)&(strcmp(promeg(jjj),'5')~=1)&...
                    (strcmp(promeg(jjj),'6')~=1)&(strcmp(promeg(jjj),'7')~=1)&...
                    (strcmp(promeg(jjj),'8')~=1)&(strcmp(promeg(jjj),'9')~=1)&...
                    (strcmp(promeg(jjj),'.')~=1)&(strcmp(promeg(jjj),'-')~=1)
                 prost=1;
              end
           end
           if prost==1 %���� ������ ���� ������ ������ � �����
              hhh{sdd,6}=lower(hhh{sdd,6});
              if (strcmp(hhh{sdd,5},'���')==1) % ���� ���� 
                 if (strcmp(hhh{sdd,6},'min')==0)&(strcmp(hhh{sdd,6},'nom')==0)&...
                    (strcmp(hhh{sdd,6},'max')==0) % � �� ����� ������ ����������
                 hhh(sdd,:)=[]; % �� �������
                 sdd=sdd-1;
                 kol_zapis=kol_zapis-1;
                 skolko(por_nem)=skolko(por_nem)-1;
                 vuchit=vuchit+1;
                 end
              else %���� �� ����
                 if (strcmp(hhh{sdd,5},'���')~=1)&(strcmp(hhh{sdd,5},'���')~=1)&...
                       (strcmp(hhh{sdd,5},'���')~=1) % � �� ����� ������ ����������
                 hhh(sdd,:)=[];
                 sdd=sdd-1;
                 kol_zapis=kol_zapis-1;
                 skolko(por_nem)=skolko(por_nem)-1;
                 vuchit=vuchit+1;
                 end
              end
           else  % ����� ������ � ����� � ����������� �� ������� 
              if (strcmp(hhh{sdd,5},'���')==0) % ���� �� �����������
                 hhh{sdd,6}=fix(str2num(hhh{sdd,6}));% ������������ � �����
              else   % �����
                 hhh(sdd,:)=[]; % �������
                 sdd=sdd-1;
                 kol_zapis=kol_zapis-1;
                 skolko(por_nem)=skolko(por_nem)-1;
                 vuchit=vuchit+1;
              end
            end
       else
          % ���� �� ������������� ���� ������ �������� �� ������� 
          hhh(sdd,:)=[];
          sdd=sdd-1;
          kol_zapis=kol_zapis-1;
          skolko(por_nem)=skolko(por_nem)-1;
          vuchit=vuchit+1;
       end  
    end
 end
 
    %disp(hhh)
    %disp(skolko)
    kol_zapis=size(hhh,1);
    
    if kol_zap1>kol_zapis
       msgbox('������� ��������� � ����� ���������','���������')
       if kol_zapis<2
          return;
       end
    end

    %return;

    podregima=zeros(1,kol_zapis);
    ots=zeros(1,kol_zapis);
    ind=zeros(1,kol_zapis);
    % ���������� �� ����������� ���������� ��� ���� ������� 
    rrr=hhh;
    nachalo=1;
    for por_nem=[1 2 3 4 5 6]
       if por_nem==1
          nachalo=nachalo+1;
       else
          nachalo=skolko(por_nem-1)+1;
       end
       if por_nem~=2
          for kkk=nachalo:skolko(por_nem)%��������� �������� ����������
             if ischar(hhh{kkk,6})==1    %��� ���� ������� ����� ����
                break;
             else
                podregima(kkk)=hhh{kkk,6};
             end
          end
       else
          for kkk=nachalo:skolko(por_nem) %���������� ������� ����������
             if strcmp(hhh{kkk,6},'min')==1 % � ����������� �� ��������
                podregima(kkk)=1;           % ��� ����
             elseif strcmp(hhh{kkk,6},'nom')==1
                podregima(kkk)=2;
             elseif strcmp(hhh{kkk,6},'max')==1
                podregima(kkk)=3;
             else
                podregima(kkk)=0;
             end      
          end
       end
       [ots(nachalo:skolko(por_nem)),ind(nachalo:skolko(por_nem))]=...
          sort(podregima(nachalo:skolko(por_nem)));%���������� ����������
       
       for kkk=nachalo:skolko(por_nem)
          rrr(kkk,:)=hhh((ind(kkk)+(nachalo-1)),:);
       end
    end
    
    %disp(rrr)
     %   return;
    hite = waitbar(0.1,'���������� ����. ����� ���������. �����...');
    %���������� ���������� ����� ��������� � �������� � ������� �������
    wk1write1([path_f_vrem,vrem_f_pas],rrr,0,0) 
    waitbar(0.9)
    close(hite)

else
   stracta=fpas_read4(dia_any,path_f,name_f);
end
osh=1;
return;