function obr(naz_f,puti)

% �������� ����� ������ ��������
% ����� �������:
%               obr
% ������������ �������:
%                      
% ������������ ������� MATLAB:
%                            
% ������� ����������:

global gl_put; % ���� � �� ��������
global gl_fun; %�������� �������� �������
%fil_f_obr=dir([path_f_zam,naz_f]);
fil_f_obr=lower(naz_f); %�������� ����� ������
%fil_pas='C:\Matlab\Toolbox\work2\������_�������2.wks';

% ������ ����� ��������� � ������ A1 � 18-��� �������
load ([gl_put,'ust1.mat']);%c:\Matlab\Toolbox\work\ust1.mat
%disp(A1);
 % ������ ����� ��������� ��� ��������� � ������ B � 42-�� �������
if A1(1)==1
   %��� ������������ �����
   path_f_zam=puti{1,2};
   load ([gl_put,'ust_pros.mat']);%c:\Matlab\Toolbox\work\ust_pros.mat 
   else
   %��� �������������� �����
   path_f_zam=puti{2,2};
   load ([gl_put,'ust_pros1.mat']);%c:\Matlab\Toolbox\work\ust_pros1.mat
end
%disp(B);
%break;  
% ������ ����� � �������������� ��� ���������� �� ���� ���
% ������� K1 K2 K3 K4 K5 K6 K7
load ([gl_put,'kof_mul.mat']);%c:\Matlab\Toolbox\work\kof_mul.mat

chast=B(35); %������� ������ ���
 
chan=0;   %���-�� ������� ������
for ddd=1:16
   if B(ddd+16)<17 % ��������,���� ����� ������ ��� ��� (17- ��� ������)
      chan=chan+1;
      kanalu(chan)=B(ddd+16);%������ (������ ������� � ������� kanalu)
   end
end

nach=B(36);
kon=B(37);
otsch=kon-nach+1;  %���-�� �������� ������(������ ���� ����� ������� ������� �� ��� ��� �������)
col=(nach:kon);  % ������ ��� ���� �����
vremia=(col-1)./chast; %������ ������ �� ��������(������)
vrem=vremia';     %������ ������ �� ��������(�������)
clear col vremia
%������ ������� x ������
%frt=[col;col;col;col;col;col;col;col;col;col;col;col;col;col;col;col];
% ������ ������������� ��� ���������� �� ���� ���
       switch B(41) % � ����������� �� ������ �������� ����� ����� ����-��� 
         case 1
            koof=K1;%������������ 0.025 � 0.25
         case 2
            koof=K2;%������������ ���-1 (��������� �����������)
         case 3
            koof=K3;%������������ ���-2(����� ����. ���������� �� ���)
         case 4
            koof=K4;%������������ ���-2 (��������� �����������)
         case 5
            koof=K5;%������������ ���-1(����� ����. ���������� �� ���)
         case 6
            koof=K6;%������������ 1 (� ����� ���)
         case 7
            koof=K7;%������������ ���������� � ���� ����
       end   
%break;          
str1=[path_f_zam,fil_f_obr];
fil_zam=fopen (str1,'rb');
if fil_zam==-1
   disp(['�� ���� ������� ���� ',str1]);
end
%���������� �������
fseek(fil_zam,2*chan*(nach-1),'bof');
% ��������� ���� ������
[mat,sch_kol]=fread(fil_zam,chan*otsch,'short');
%disp(sch_kol);
fclose(fil_zam);
%����������� �� ������������ ����� ����� � �������(sch_kol) � ���������
%���������� ��������(chan*otsch) � ����������� �������������� ��������� 
%��������
     real_otsch=(floor(sch_kol/chan));
     if real_otsch<otsch
        msgbox('�������� ���-�� �������� ������ ����� ����� ������','���������')
     end
     otsch=(floor(real_otsch/2))*2;
     %whos;
     frt=zeros(chan,otsch);
     
  uuu = waitbar(0,'���������� ������ �� ������� � ��������');
  % ���������� ������ �� ������ �� ������� � ��������
  for sl_otsch=chan:chan:(otsch*chan)
     %disp(sl_otsch);
     waitbar(sl_otsch/(otsch*chan));
     frt(:,sl_otsch/chan)=mat((sl_otsch-(chan-1)):sl_otsch); 
  end
  close(uuu)
      clear mat
      if (B(41)==3)|(B(41)==5)
         %��������������� ������(�� ��������-������ �� �������-�������)
         vrt=frt'-2048;
      else
         vrt=frt';
      end
      clear frt 
      %disp(vrt(:,2));
      %format;
      uu1 = waitbar(0,'���������� �� ������������');
      % ��������� �� ������������
      for sss=1:chan
         waitbar(sss/chan);
         vrt(:,sss)=vrt(:,sss).*koof(kanalu(sss));   
      end
      close(uu1)
      vrem((otsch+1):length(vrem))=[];
      %dddddl=length(vrem)
      % �������� ������� ������
      mass=[vrem,vrt];
      mass_skl=[vrem,vrt];
      %disp(mass(:,1:3));
      spectr=[vrem,vrt];  
      % �������� ������� ������ �� �������� ����������
      clear vremia vrt vrem
      
      
      if B(33)==1   %���� ��������� �������� � ������������ 
         B(B(34))=1;% �������� ������� ������ ��������� 
         nom_chan_otm=kanalu(B(34)); % ����� ������ ��������� 
      end
      nom_chan = (find(B(1:16)));
      nom_kanalu= find(kanalu);
      %disp (kanalu)
      dosia=0;
      for tyu=nom_chan
         dosia=dosia+1;
         probna(dosia)=find(nom_kanalu==tyu)+1;
      end
      nom_chan=probna;
 
      %break;
      if B(40)==1
      % �������� ���������� ������������ �������
      for tyu=nom_chan%2:(chan+1)
         sredina=mean(mass(:,tyu));
         mass(:,tyu)=mass(:,tyu)-sredina;
      end
      end
     
     %break;
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
     
     %������� ��������� ��������
     max_vib=(1:chan);
     min_vib=(1:chan);
     dva_vib=(1:chan);
     for tara=nom_chan%2:(chan+1)
        max_vib(tara-1)=max(mass(:,tara));    
        min_vib(tara-1)=min(mass(:,tara));
        dva_vib(tara-1)=max_vib(tara-1)-min_vib(tara-1);
     end
     
     %������������������ �������� ��������
     SKZ2A=(1:chan);
     for tara=nom_chan%2:(chan+1)
        SKZ2A(tara-1)=sqrt(sum((spectr(:,tara).^2)./2));
     end
     %��������� �������� �� ����������� �������� �� 31-���
     max_vib_skl=(1:chan);
     min_vib_skl=(1:chan);
     dva_vib_skl=(1:chan);
     if B(38)==1 %���� 1, �� ������ ��������� �� ����������� �������� 
        kol_skol=B(39);
        for tara=nom_chan%2:4%(chan+1)
           for tara2=1:(otsch-kol_skol)
              mass_skl(tara2,tara)=mean(mass(tara2:(tara2+kol_skol),tara)); 
           end
           max_vib_skl(tara-1)=max(mass_skl(:,tara));    
           min_vib_skl(tara-1)=min(mass_skl(:,tara));
           dva_vib_skl(tara-1)=max_vib_skl(tara-1)-min_vib_skl(tara-1);
        end
     else
        dva_vib_skl=dva_vib_skl.*0;
     end
     
     massa=mass(1:otsch,[1 nom_chan]);
     spectra=spectr(:,[1 nom_chan]);
     %disp(nom_chan);
     %���������� � ����� �������� ��������
     dlin_naz_f=length(fil_f_obr);
     fil_f_obr(dlin_naz_f-3:dlin_naz_f)=[];
     if B(42)==1
        poln_naz_wk_v=[path_f_zam,fil_f_obr,'v.wk1'];
        wk1write(poln_naz_wk_v,massa,0,0);
     end
     
     if B(43)==1
        if (B(41)~=3)|(B(41)~=5)
           poln_naz_wk_f=[path_f_zam,fil_f_obr,'f.wk1'];
           wk1write(poln_naz_wk_f,spectra,0,0);
        end
     end
     
     kol_ot1=ceil((otsch*40)/chast);
     kol_ot2=ceil((otsch*98)/chast);
     kol_ot3=ceil((otsch*102)/chast);
     for tyu=nom_chan%3:2:7%(chan+1)
        figure;
        if B(33)==1
           kofi=max_vib(find(kanalu== nom_chan_otm))/max_vib(tyu-1);
           mass(:,(find(kanalu==nom_chan_otm)+1))=mass(:,(find(kanalu==nom_chan_otm)+1))./kofi;
        subplot(2,1,1),...
           plot(mass(1:otsch,1),[mass(1:otsch,tyu) mass(1:otsch,(find(kanalu==nom_chan_otm)+1))]);
           mass(:,(find(kanalu==nom_chan_otm)+1))=mass(:,(find(kanalu==nom_chan_otm)+1)).*kofi;
        else
        subplot(2,1,1),...
           plot(mass(1:otsch,1),mass(1:otsch,tyu));
        end
        dl=length(fil_f_obr);
        for dxd=1:dl
           if strcmp(fil_f_obr(dxd),'_')==1
              fil_f_obr(dxd)=' ';
           end
        end
        perch=fil_f_obr(1:(dl-4));
        perch2=fil_f_obr((dl-3):dl);
        stroka=sprintf('����������������( ����� %d,����: %s%s)',...
           kanalu(tyu-1),perch,perch2);
        title(stroka);
        if B(38)==1 
           stroka2=sprintf('2����=%.2f ���  ���(2�)=%.2f ���  ���������� �������(2A)=%.2f ���  �����, ���',...
              dva_vib(tyu-1),SKZ2A(tyu-1),dva_vib_skl(tyu-1));
        else
           stroka2=sprintf('2����=%.2f ���  ���(2�)=%.2f ���  �����, ���',...
              dva_vib(tyu-1),SKZ2A(tyu-1));
        end
        
        
        xlabel(stroka2)
        ylabel('���������, ���')
        grid on;
        zoom on;
        
        %disp(spectr)
        %disp(spectr)
        if kol_ot1<otsch/2 
           subplot(2,2,3),...
              plot(spectr(1:kol_ot1,1),spectr(1:kol_ot1,tyu));
           title('������ �������� �������')
           xlabel('�������, ��')
           ylabel('���������(2�), ���')
           grid on;
           zoom on;
        end
        
        if kol_ot3<otsch/2
           subplot(2,2,4),...
              plot(spectr(kol_ot2:kol_ot3,1),spectr(kol_ot2:kol_ot3,tyu));
           title('������ �������� �������')
           xlabel('�������, ��')
           ylabel('���������(2�), ���')
           grid on;
           zoom on;
        end       
     end
     feval(gl_fun);