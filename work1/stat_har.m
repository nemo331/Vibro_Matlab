function stat_har()
% stat_har ������������� �������������� ������������� ������������� ������
% ����� �������:
%    st=stat_har()
% ������������ ������: ���
% ������� ����������: ���

n=4096;
t=(1:(n/2));    %������ �������� �������
ampl=(1:(n/2)); %������ �������� ��������
t2=(1:(n/2));    %������ �������� ������� ���������
ampl_otm=(1:(n/2)); %������ �������� ���������
st=(1:n);       %������ ��������� �� �����
spectr=(1:(n/2));
kv_spec=(1:(n/2));

path='c:\DIAGNOST\OSCILL\'; %���� �� �����
name_f='losh__'; % ��� �����
g=0;
d=0;
otm=0;
while d~=-1
   g=g+1;
   
   str1=strcat(path,name_f,'0',int2str(g),'.o02');
   str2=strcat(path,name_f,'0',int2str(g),'.o16');
   d=fopen (str1,'rt');%�������� ����� ������ ��� ������
   otm=fopen (str2,'rt');%�������� ����� ��������� ��� ������
  if d==-1|otm==-1
     disp(strcat('�� ���� ������� ����: ',str1,'���',str2));
     break;
   end

   st=fscanf(d,'%f',n);%������ ������ �� �����
   for i=2:2:n
   t(i/2)=st(i-1);
   ampl(i/2)=st(i);
   end
   fclose (d);     %�������� ����� ������
   ampl=ampl-mean(ampl);  %��������� ���������� ������������

   
   st=fscanf(otm,'%f',n);%������ ��������� ��������� �� �����
   for i=2:2:n
   t2(i/2)=st(i-1);
   ampl_otm(i/2)=st(i);
   end
   fclose (otm);     %�������� ����� ���������
   %figure;
   %plot (t(1:(n/2)),[ampl_otm(1:(n/2))' ampl(1:(n/2))']);
   %grid on;
   
   %���������� ������� �� ������ ������� � ������ �� ��������
   detect_ampl=(1:(n/2)); %������ ������������������� �������
   detect_ampl=abs(ampl);
%figure;
%plot (t(1:(n/2)),detect_ampl(1:(n/2)));
%grid on;
max_zn(g)=max(ampl) %������������ �������� 
min_zn(g)=min(ampl) %����������� ��������
srednee(g)=mean(detect_ampl)  %�������
mediana(g)=median(detect_ampl);%�������
srkv_otkl(g)=std(detect_ampl)  %�������������������� ����������
kovar(g)=cov(detect_ampl); %���������� (��� ������� - ���������)
spectr=fft(ampl)/(n/4);
t2=(1:(n/2))/(n/2)*400;
figure;
plot (t2(1:(n/4)),abs(spectr(1:(n/4))));
grid on;
axis([0 2 0 50]);
kv_spec=(abs(spectr)).^2;
srkv_ampl(g)=sqrt(sum(kv_spec./2))
sr_spectr(g)=sqrt(sum(kv_spec))
summarn(g)=sum(abs(spectr));
end
por=(1:(g-1));
figure;
plot (por(1:(g-1)),[srednee(1:(g-1))' mediana(1:(g-1))' srkv_otkl(1:(g-1))' srkv_ampl(1:(g-1))' sr_spectr(1:(g-1))']);
grid on;
