function soz_gr_garm(hhh,path_f_vrem,A1,vr_ot,path_f_otch,put_exl);

% soz_gr_garm ������������� ������� ������� ������� ���� ���� �� ���������� ������
% ����� �������:
%               soz_gr_garm(hhh,path_f_zam,A1,vr_ot);
% ������������ �������:
%                      
% ������������ ������� MATLAB:
%                            
% ������� ����������: hhh-������ ����� � ����������� �������
%  path_f_vrem -���� �� ������ � �������
%  A1 - ������ � ����������� �� �� ����
%  vr_ot - �������� ����� ���������� ������

global gl_put; % ���� � �� ��������
% ��������� ���� ���� ������ ������ vr_mass
load ([path_f_vrem,vr_ot])
% ������ ����� ��������� � ������ E
load ([gl_put,'ust_ot_garm.mat']) 
%disp(E);

% ����� ��������� ������� ��������
nom_garm2= find(E(17:26));
for pop1=1:(length(nom_garm2))
   nom_garm2(pop1)=E(26+nom_garm2(pop1));
end


lx=size(hhh,1)-1;% ���-�� ������� � ����� ���������
ggg=hhh(2:(lx+1),:);
x=(1:lx);
%ly=size(vr_garm,1); % ���-�� ������� �� �� ����� ������
%wy=size(vr_garm,2);% ���-�� �������� �� �� ����� ������
%y=vr_garm(2:lx,1:2:wy);

% ���-�� �������� 
kol_garm = sum(E(17:26));

% ��������� ������ �� ����� �� ���������� �.�. � ������ ����� ������ 
% ��� ����� ���� ���� ����������

vr_podr=zeros(size(vr_garm));
vr_podr(1,:)=vr_garm(1,:);
por_str=1;
for n_garm=1:kol_garm
   for n_pod=1:lx
      por_str=por_str+1;
      vr_podr(por_str,:)=vr_garm((n_pod-1)*kol_garm+n_garm+1,:);
   end
end
%break;
% �������� ������ ����� ��� ���������� ����� �� ����� (���� ������)
pod_gar=cell(length(vr_podr(:,1))+kol_garm,length(vr_podr(1,:)));


for n_garm=0:kol_garm-1
   for n_pod=1:lx
      if isnumeric(ggg{n_pod,6})==1
         promeg=num2str(ggg{n_pod,6});
      else
         promeg=ggg{n_pod,6};
      end
      promeg2=ggg{n_pod,5};
      if strcmp(promeg2,'���')==1
         promeg2='��';
      elseif strcmp(promeg2,'���')==1
         promeg2='����';
      elseif strcmp(promeg2,'���')==1
         promeg2='���';   
      elseif strcmp(promeg2,'���')==1
         promeg2='��';
      elseif strcmp(promeg2,'���')==1
         promeg2='�����';
      elseif strcmp(promeg2,'���')==1
         promeg2='�����';
      else
         promeg2=' ';
      end
      
      pod_gar{(n_pod+n_garm*(lx+1))+2,1}=[promeg2,'-',promeg];
   end
end
n_pp=0;
% ��������� � ������ ����� ������ �� �������� � ������ 
for n_garm=0:kol_garm-1 %���� �� ����������
   %pod_gar{n_garm*(lx+1)+2,2}=[num2str(vr_podr(n_garm*lx+2,1)),'��']
   pod_gar{n_garm*(lx+1)+2,1}=[num2str(nom_garm2(n_garm+1)),' ���������'];
   n_pp=1;
   flg=1;
   for n_pod=1:lx %���� �� ����������
      for ghj=2:length(vr_podr(1,:)) %���� �� �������
         if (n_pod==1)
            if flg==1
               pod_gar{(n_pod+n_garm*(lx+1))+1,ghj}=n_pp;
               n_pp=n_pp+1;
               flg=-1;
            end
            flg=flg+1;
         end
         pod_gar{(n_pod+n_garm*(lx+1))+2,ghj}=vr_podr(n_pod+n_garm*lx+1,ghj);
      end
   end
end

% ���������� ������ ������ � ������� ��������� ��������
for ghj=2:2:length(vr_podr(1,:))
   pod_gar{1,ghj}=ggg{1,vr_podr(1,ghj)+17};
end


%������������� �������� ������ � ����������
for ghj=3:2:length(vr_podr(1,:)) %�������
   for por_str=3:length(vr_podr(:,1))+kol_garm % ������
      if isempty(pod_gar{por_str,ghj})~=1
         switch pod_gar{por_str,ghj}
         case 1
            pod_gar{por_str,ghj}='�����.';
         case 2
            pod_gar{por_str,ghj}='����.';
         case 3
            pod_gar{por_str,ghj}='��.';
         case 4
            pod_gar{por_str,ghj}='���.';
         case 5
            pod_gar{por_str,ghj}='���.';
         otherwise
            pod_gar{por_str,ghj}='';
         end  
      end
   end
end

%disp (pod_gar);
%break;

%break;
if E(37)==1
   tip_lin={'m-','m:','r-','r:','b-','b:','k-','k:', 'g-','g:',...
   'm-o','m:o','r-o','r:o','b-o','b:o','k-o','k:o', 'g-o','g:o',...
   'm-x','m:x','r-x','r:x','b-x','b:x','k-x','k:x', 'g-x','g:x'};
   ly=size(vr_podr,1); % ���-�� ����� �� �� ����� ������
   wy=size(vr_podr,2);% ���-�� �������� �� �� ����� ������
   wy2=(wy-1)/2; % ���-�� ������� ������
   ly2=(ly-1)/kol_garm; %���-�� ����������(������)
   nomer_kan=vr_podr(1,2:2:wy);% ������ �������
   
   kan_mest=cell(1,wy2);
   pop=0;
   for nn_pop=nomer_kan
      pop=pop+1;
      kan_mest{pop}=ggg{1,17+(nn_pop)};
   end
   %disp(vr_podr)
   y=vr_podr(2:ly,2:2:wy);
   
   if E(42)==1
      % �������� ������� ����� � ��������-����������� 
      % ��� �������
      
      kolsim=zeros(1,length(pod_gar(3:ly2+2,1)));
      for tnz=x
         %disp(ggg{1,17+(nomer_kan(tnz))});
         kolsim(tnz)=length(pod_gar{tnz+2,1});
      end
      maksim=max(kolsim);
      for tnz=x
         if tnz==1
            str_mass=[pod_gar{tnz+2,1},...
                  blanks(maksim-kolsim(tnz))];
         else
            str_mass2=[pod_gar{tnz+2,1},...
                  blanks(maksim-kolsim(tnz))];
            str_mass=[str_mass;str_mass2];
         end
      end
   end

   if E(42)==2
      % �������� ������� ����� � ������� ��������� � �������� �������� 
      % ��� �������
      kolsim=zeros(1,length(nomer_kan));
      for tnz=1:(wy-1)/2
         %disp(ggg{1,17+(nomer_kan(tnz))});
         kolsim(tnz)=length(ggg{1,17+(nomer_kan(tnz))});
      end
      maksim=max(kolsim);
      for tnz=1:(wy/2)
         if tnz==1
            str_mass=[ggg{1,17+(nomer_kan(tnz))},...
                  blanks(maksim-kolsim(tnz))];
         else
            str_mass2=[ggg{1,17+(nomer_kan(tnz))},...
                  blanks(maksim-kolsim(tnz))];
            str_mass=[str_mass;str_mass2];
         end
      end
   end
   
   if E(42)==3
      %y3=(1:kol_garm);
      for te=1:kol_garm   
         %str_mass1=num2str(vr_podr((te-1)*ly2+2,1));
         str_mass1=num2str(nom_garm2(te));
         if te==1
            maksim=length(str_mass1);
         else
            kolsim=length(str_mass1);
            if maksim<kolsim
               maksim=kolsim;
            end
         end
      end
      for te=1:kol_garm   
         %str_mass1=num2str(vr_podr((te-1)*ly2+2,1));
         str_mass1=num2str(nom_garm2(te));
         kolsim=length(str_mass1);
         str_mass2=[str_mass1,' ���������',blanks(maksim-kolsim)];
         if te==1
            str_mass=str_mass2;
         else
            str_mass=[str_mass;str_mass2];
         end
      end
   end
   
   %break;
   %-----------------------------------------------------------------------------------
   if E(43)==3 % � ����� ���������
      for n_garm=1:kol_garm
         figure;
         if E(41)==1 % �� ��� X ���������
            hold on
            for tnz=1:(wy-1)/2
               plot(x,y((n_garm-1)*lx+1:n_garm*lx,tnz),tip_lin{tnz});   
            end
            hold off
            %break;
            xlabel('������ ������ �� ,�� - � %, ��� - � ���')
            set(gca,'XTick',1:lx);
            set(gca,'XTickLabel',pod_gar(3:end),'Fontsize',8);
            %legend(str_mass,0);
         else if E(41)==2 % �� ��� X ������� � ����� �� ��������� 
               hold on
               for tnz=1:ly2
                  plot(1:wy2,y(tnz+(ly2*(n_garm-1)),:),tip_lin{tnz});   
               end
               hold off
               xlabel('������� � ����� ���������')
               
               set(gca,'XTick',1:wy2);
               set(gca,'XTickLabel',kan_mest,'Fontsize',8);
               
            end
         end
         title(['������ ',num2str(nom_garm2(n_garm)),' ���������'])
         ylabel('������� ��������� �������� �������� ��������� 2A���, ���')
         legend(str_mass,0);        
         grid on;
      end
   end
   %-----------------------------------------------------------------------------------
   if E(43)==2 % � ����� ������� � ����� ���������
      for n_chan=1:wy2
         figure;
         if E(41)==1 % �� ��� X ���������
            hold on
            for tnz=1:kol_garm
               plot(x,y(((tnz-1)*ly2+1):(tnz*ly2),n_chan),tip_lin{tnz});   
            end
            hold off
            %break;
            xlabel('������ ������ �� ,�� - � %, ��� - � ���')
            set(gca,'XTick',1:lx);
            set(gca,'XTickLabel',pod_gar(3:end),'Fontsize',8);
            grid on;
         else if E(41)==3 % �� ��� X ��������� 
               hold on
               y2=(1:kol_garm);
               y3=y2;
               for tnz=1:ly2
                  for te=1:kol_garm
                     y2(te)=y((te-1)*ly2+tnz,n_chan);
                     if tnz==1
                        %y3(te)=vr_podr((te-1)*ly2+2,1);
                        y3(te)=nom_garm2(te);
                     end
                  end
                  plot(1:kol_garm,y2,tip_lin{tnz});   
               end
               hold off
               xlabel('���������')
               
               set(gca,'XTick',1:kol_garm);
               set(gca,'XTickLabel',y3(1:end),'Fontsize',8);
               
            end
         end
         title(['������� �� �������: ',kan_mest{n_chan}])
         ylabel('������� ��������� �������� �������� ��������� 2A���, ���')
         legend(str_mass,0);
         grid on;
      end
   end
   %-----------------------------------------------------------------------------------
   if E(43)==1 % � ����� ������-���������
      for n_podr=x
         figure;
         if E(41)==2 % �� ��� X ������� � �����
            hold on
            for tnz=1:kol_garm
                  plot(1:wy2,y((tnz-1)*ly2+n_podr,:),tip_lin{tnz});   
            end
            hold off
            %break;
            xlabel('������� � ����� ���������')
            set(gca,'XTick',1:wy2);
            set(gca,'XTickLabel',kan_mest,'Fontsize',8);
            grid on;
         else if E(41)==3 % �� ��� X ��������� 
               hold on
               y2=(1:kol_garm);
               y3=y2;
               for tnz=1:wy2
                  for te=1:kol_garm
                     y2(te)=y((te-1)*ly2+n_podr,tnz);
                     if tnz==1
                        %y3(te)=vr_podr((te-1)*ly2+2,1);
                        y3(te)=nom_garm2(te);
                     end
                  end
                  plot(1:kol_garm,y2,tip_lin{tnz});   
               end
               hold off
               xlabel('���������')
               
               set(gca,'XTick',1:kol_garm);
               set(gca,'XTickLabel',y3(1:end),'Fontsize',8);
               
            end
         end
         title(['������� �� ������: ',pod_gar{n_podr+2,1}])
         ylabel('������� ��������� �������� �������� ��������� 2A���, ���')
         legend(str_mass,0);
         grid on;
      end
   end
end

if E(38)==1
   perv_str_iach=cell(1,size(pod_gar,2));%���� ���������
   perv_str_iach{2}=['�� N',(num2str(ggg{1,3}))];
   perv_str_iach{3}='2� ������������� ������������ ��������';
   pod_gar=[perv_str_iach;pod_gar];
   % ��������� ���
   kol_dat =size(ggg(:,4),1);
   dmax=0;
   dmin=1000000;
   for kkkk=1:kol_dat
      if isnumeric(ggg{kkkk,4})==1
         if ggg{kkkk,4}>dmax
            dmax=ggg{kkkk,4};
         end
         if ggg{kkkk,4}<dmin
            dmin=ggg{kkkk,4};
         end
      end
   end
   
   if dmax==0
      dmax=0;
   end
   if dmin==1000000
      dmin=0;
   end
   if (dmin~=0)&(dmax~=0)
      pod_gar{1,(size(pod_gar,2)-2)}='����:';
      pod_gar{1,(size(pod_gar,2)-1)}=dmin;
      if dmin~=dmax
         pod_gar{1,(size(pod_gar,2))}=dmax;
      end
   end
   naz_wks=ggg{1,2};
   dlin_naz_f=length(naz_wks);
   naz_wks(dlin_naz_f-6:dlin_naz_f)=[];
   wk1write1([path_f_otch,naz_wks,'_of.wks'],pod_gar,0,0)
   
   % ������� ��������� ����
   if E(39)==1
      dos([put_exl,'excel.exe ',path_f_otch,naz_wks,'_of.wks',' ',path_f_otch,'empty2.xls',' &']);
   end
end


