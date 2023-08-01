function soz_otch_garm(ggg,A1,chast,chan,otsch,n_f_pp,vr_ot,path_f_vrem,B);

% soz_otch_garm ������������� ������� ������� ������� ���� ���� ������ �� ����������
% ����� �������:
%               soz_f_otch(ggg,path_f_zam,A1,chast,chan,otsch,n_f_pp);
% ������������ �������:
%                      
% ������������ ������� MATLAB:
%                            
% ������� ����������: ggg-������ ����� � ����������� �������
%  ggg - ������ ��� ������� ����� ������ �� ���������� ����� ���������
%  A1 - ������ � ����������� �� �� ����
%  chast - ������� ������ ���
%  chan - ���-�� ������� ������
%  otsch - ���������� �������� ��� ������ ������ 
%  n_f_pp - ����� ����� �� �������
%  vr_ot - �������� ����� ���������� ������
%  path_f_vrem -���� �� �������� � ���������� �������

global gl_put; % ���� � �� ��������
% ������ ����� ��������� � ������ D � 21-�� ������
load ([gl_put,'ust_ot_garm.mat']) 
%disp(E);
%disp(ggg)14


naz_f_zam2=ggg{1,2};
        for dxd=1:(length(naz_f_zam2));
           if strcmp(naz_f_zam2(dxd),'_')==1
              naz_f_zam2(dxd)=' ';
           end
        end
        
%celldisp (ggg);
hi = waitbar(0,['������ � ����� �� ���������� (���� ',naz_f_zam2,'). �����...']);

%������������ �������� mat-����� ��� �������� ������� � ������� mass(8192x17)
dlin_naz_f=length(ggg{1,2});
naz_mat_f=ggg{1,2};
naz_mat_f(dlin_naz_f-3:dlin_naz_f)=[];
poln_naz_mat_f=[path_f_vrem,naz_mat_f,'.mat'];
load (poln_naz_mat_f)
%disp(mass) 
waitbar(0.1)

switch A1(1)
case 1
   kanalu=(1:16);
case 2
   kanalu=B(16+1):B(16+chan);%(1:chan);
end

 

   nom_chan = (find(E(1:16)));
      dosia=0;
      for tyu=nom_chan
         dosia=dosia+1;
         probna(dosia)=find(kanalu==tyu)+1;
      end
      nom_chan=probna;
      
      if isnumeric(ggg{1,14})~=1
         pr_obor=str2num(ggg{1,14});
      else
         pr_obor=ggg{1,14};
      end
      
      if isempty(pr_obor)~=1
         if (pr_obor>0)&(pr_obor<200)
            pr_obor=pr_obor/100;
         else
            pr_obor=1;
         end
      else 
         pr_obor=1;
      end
     
% ����� ��������� ������� ��������
nom_garm = find(E(17:26));
nom_garm2= find(E(17:26));
for pop1=1:(length(nom_garm))
   nom_garm(pop1)=E(26+nom_garm(pop1))*pr_obor;
   nom_garm2(pop1)=E(26+nom_garm2(pop1));
end

% �������� 2-������� ������ ��� ��������� ��������(������-����, �������-������)
garmon=zeros(length(nom_garm),length(nom_chan)+1);
% � ������ �������  ������� ������� ��������
  garmon(:,1)=nom_garm'*E(40);

%break;     
%kol_chan=size(mass,2)-1;% ���������� ������� � ������� mass
% �������� ���������� ������������ �������
      for tyu=nom_chan%2:(chan+1)
         sredina=mean(mass(:,tyu));
         mass(:,tyu)=mass(:,tyu)-sredina;
      end
      %disp(chast); 
      %disp(otsch);
      %disp(chan);
mass_skl=mass;
spectr=mass;
waitbar(0.3)

%���������� � ��� �����
     for tyu=nom_chan%2:(chan+1)
        spectr(:,tyu)=abs(fft(mass(:,tyu))/(otsch/2));
        spectr(:,tyu)=spectr(:,tyu).*2;
     end
     %t2=(0:((otsch-1)/2))/(otsch/2)*(chast/2);
     t2=(0:((otsch-1)/2))/(otsch/chast);
     %disp(t2');
     spectr(1:(otsch/2),1)=t2';
     spectr((otsch/2+1):otsch,:)=[];
waitbar(0.4)

%���������� ��� ���� �������� ������� ������� � ������� �� ���������
   for pop1=1:(length(nom_garm))
      nom_garm(pop1)=find(spectr(:,1)>garmon(pop1,1)-(chast/(2*otsch))&...
         spectr(:,1)<garmon(pop1,1)+(chast/(2*otsch)));
      %nom_garm(pop1)=spectr(nom_garm(pop1),1);
   end
%���������� ��� ���� �������� �������� �������� ��� ���� �������
   dosia=1;   
for tyu=nom_chan
   dosia=dosia+1;
   garmon(:,dosia)=spectr(nom_garm,tyu);
end
waitbar(0.5)
% �������� ������ ������ � ��� ����� �������� ����: � ������ �������- �������
% ��������, �� ������ �������� ���������, � ������ - ������ �� ��������� � �.�. ��� ��� 
% �������(������� ���� ������ � ����� ������ �������)
vrem_tab=zeros(length(nom_garm),length(nom_chan)*2+1);
%������� � ������ ������� �������� � �������� ��������
for tara=1:(length(nom_chan)+1)
   %���������� �� ���� ������ ����� �������
   garmon(:,tara)=(round(garmon(:,tara)*100))/100;
   if tara<3
      vrem_tab(:,tara)=garmon(:,tara);
   else
      vrem_tab(:,(tara-1)*2)=garmon(:,tara);
   end
end

%break;
waitbar(0.6)
% ���������� ������ � ���������� �������
 dosia=1;
 for tara=nom_chan
    dosia=dosia+2;
    for pop1=1:(length(nom_garm))
       
       % ��������: ������ ������� ��� ���
       %proba=lower(ggg{1,16+tara})
       if isempty(ggg{1,16+tara})==0
          
       if strncmpi(lower(strjust(ggg{1,16+tara},'left')),'��',2)==1
          %����������� ������ ��� ������ �������
          if vrem_tab(pop1,1)<=(4*1.04*pr_obor)
             if vrem_tab(pop1,dosia-1)>80,vrem_tab(pop1,dosia)=2;
             else
                vrem_tab(pop1,dosia)=3;
             end
          elseif vrem_tab(pop1,1)>=(48*1.04*pr_obor)
             if vrem_tab(pop1,dosia-1)>30,vrem_tab(pop1,dosia)=2;
             else
                vrem_tab(pop1,dosia)=3;
             end
          else
             vrem_tab(pop1,dosia)=0;
          end
          
       elseif strncmpi(strjust(ggg{1,16+tara},'left'),'-',1)==0&...
             strncmpi(ggg{1,16+tara},' ',1)==0
          
          %����������� ������ ��� ��� �����
          if vrem_tab(pop1,dosia-1)<(-45.65*log(vrem_tab(pop1,1))+195)
             vrem_tab(pop1,dosia)=2;
          else
             if (-45.65*log(vrem_tab(pop1,1))+195)<0
                vrem_tab(pop1,dosia)=5;
             else
                vrem_tab(pop1,dosia)=1;
             end
          end
          
          if vrem_tab(pop1,dosia-1)<(-34.00*log(vrem_tab(pop1,1))+150),vrem_tab(pop1,dosia)=3;, end
          if vrem_tab(pop1,dosia-1)<(-23.129*log(vrem_tab(pop1,1))+100),vrem_tab(pop1,dosia)=4;, end
          if vrem_tab(pop1,dosia-1)<(-16.403*log(vrem_tab(pop1,1))+53),vrem_tab(pop1,dosia)=5;, end
          
       else
          vrem_tab(pop1,dosia)=0;
       end  
       else
          vrem_tab(pop1,dosia)=0;
       end
    end
 end
 waitbar(0.8)
 %disp (vrem_tab);
 
 naz_f_vr_garm=[path_f_vrem,vr_ot];

   if n_f_pp==1
      vr_garm=zeros(1,(length(nom_chan)*2)+1);
      vr_garm=vr_garm.*0;
      for hotche=2:2:(length(vr_garm))
         vr_garm(1,hotche)=(nom_chan(hotche/2))-1;
         vr_garm(1,hotche+1)=(nom_chan(hotche/2))-1;
      end
   else
      load (naz_f_vr_garm)
   end
   
   waitbar(1)
      vr_garm=[vr_garm;vrem_tab];
      save (naz_f_vr_garm, 'vr_garm')

close(hi)