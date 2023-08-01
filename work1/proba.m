function proba()
% proba эксперимент с синусоидальным сигналом
% Вызов функции:
%    proba
% Используемые функци: Нет
% Входные переменные: Нет

f1=1.04;
dsd=f1*1.5625;
n=8192;
Fs=426;
bodel=gcd(n,Fs);
a=50;
%break;
%Fs=Fs/bodel
t=(1:n)/Fs;
%break;
spectr=(1:n);
%s1=t*Fs;
s1=a*sin(2*pi*t*(f1*1));
s2=a*sin(2*pi*t*(f1*2));
s3=a*sin(2*pi*t*(f1*3));
s4=a*sin(2*pi*t*(f1*4));
s5=a*sin(2*pi*t*(f1*8));
s6=a*sin(2*pi*t*(f1*12));
s7=a*sin(2*pi*t*(f1*16));
s8=a*sin(2*pi*t*(f1*20));
s9=a*sin(2*pi*t*(f1*32));
s10=a*sin(2*pi*t*(f1*48));
s11=a*sin(2*pi*t*(f1*96));
s=s1;%+s2+s3+s4+s5+s6+s7+s8+s9+s10+s11;
figure;
plot(t(1:n),s(1:n))
grid on;
spectr=fft(s)/((n)/2);
t2=(0:((n-1)/2))/(n/2)*(Fs/2);
figure;
plot(t2(1:(n/2)),abs(spectr(1:(n/2))))
grid on;
zoom on;
s_detect=abs(s);
figure;
plot(t(1:n),s_detect(1:n))
grid on;
max_zn=max(s); %максимальное значение 
min_zn=min(s); %минимальное значение
srednee=mean(s_detect);  %среднее
mediana=median(s_detect);%медиана
srkv_otkl=std(s_detect);  %среднеквадратическое отклонение
dest_zn=a/sqrt(2);   %действующее значение амплитуды вибрации
dest_zn2=sqrt(mean(s_detect.^2));
disp(dest_zn2);
kv_spec=(abs(spectr)).^2;
srkv_ampl=sqrt(sum(kv_spec./2))
disp(srkv_ampl);
sr_spectr=sqrt(sum(kv_spec));
disp(sr_spectr);
summarn=sum(abs(spectr));
   









