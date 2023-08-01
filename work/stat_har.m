function stat_har()
% stat_har определенение статистических характеристик вибрационного замера
% Вызов функции:
%    st=stat_har()
% Используемые функци: Нет
% Входные переменные: Нет

n=4096;
t=(1:(n/2));    %массив значений времени
ampl=(1:(n/2)); %массив значений амплитуд
t2=(1:(n/2));    %массив значений времени отметчика
ampl_otm=(1:(n/2)); %массив значений отметчика
st=(1:n);       %массив считанный из файла
spectr=(1:(n/2));
kv_spec=(1:(n/2));

path='c:\DIAGNOST\OSCILL\'; %путь до файла
name_f='losh__'; % имя файла
g=0;
d=0;
otm=0;
while d~=-1
   g=g+1;
   
   str1=strcat(path,name_f,'0',int2str(g),'.o02');
   str2=strcat(path,name_f,'0',int2str(g),'.o16');
   d=fopen (str1,'rt');%открытие файла данных для чтения
   otm=fopen (str2,'rt');%открытие файла отметчика для чтения
  if d==-1|otm==-1
     disp(strcat('Не могу открыть файл: ',str1,'или',str2));
     break;
   end

   st=fscanf(d,'%f',n);%чтение данных из файла
   for i=2:2:n
   t(i/2)=st(i-1);
   ampl(i/2)=st(i);
   end
   fclose (d);     %закрытие файла данных
   ampl=ampl-mean(ampl);  %вычитание постоянной составляющей

   
   st=fscanf(otm,'%f',n);%чтение импульсов отметчика из файла
   for i=2:2:n
   t2(i/2)=st(i-1);
   ampl_otm(i/2)=st(i);
   end
   fclose (otm);     %закрытие файла отметчика
   %figure;
   %plot (t(1:(n/2)),[ampl_otm(1:(n/2))' ampl(1:(n/2))']);
   %grid on;
   
   %разделение массива на массив времени и данных по вибрации
   detect_ampl=(1:(n/2)); %массив продетектированного сигнала
   detect_ampl=abs(ampl);
%figure;
%plot (t(1:(n/2)),detect_ampl(1:(n/2)));
%grid on;
max_zn(g)=max(ampl) %максимальное значение 
min_zn(g)=min(ampl) %минимальное значение
srednee(g)=mean(detect_ampl)  %среднее
mediana(g)=median(detect_ampl);%медиана
srkv_otkl(g)=std(detect_ampl)  %среднеквадратическое откленение
kovar(g)=cov(detect_ampl); %ковариация (для вектора - дисперсия)
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
