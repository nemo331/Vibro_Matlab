function soz_f_otch(ggg,path_f_zam,A1,chast,chan,otsch,n_f_pp,vr_ot,path_f_vrem,B);

% soz_f_otch окончательная функция которая создает врем файл отчета
% Вызов функции:
%               soz_f_otch(ggg,path_f_zam,A1,chast,chan,otsch,n_f_pp);
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные: ggg-массив ячеек с паспортными данными
%  path_f_zam -путь до файлов с данными
%  A1 - массив с установками из гл окна
%  chast - частота опроса АЦП
%  chan - кол-во каналов опроса
%  otsch - количество отсчетов для одного канала 
%  n_f_pp - номер файла по порядку
%  vr_ot - название файла временного отчета

global gl_put; % путь к гл каталогу
% Чтение файла установок в массив D с 21-им числом
load ([gl_put,'ust_ot_vib.mat'])%c:\Matlab\Toolbox\work\ust_ot_vib.mat 
%disp(D);

naz_f_zam2=ggg{1,2};
        for dxd=1:(length(naz_f_zam2));
           if strcmp(naz_f_zam2(dxd),'_')==1
              naz_f_zam2(dxd)=' ';
           end
        end

hi = waitbar(0,['Запись в отчет по файлу ',naz_f_zam2,'. Ждите...']);

%формирование названия mat-файла для загрузки массива с данными mass(8192x17)
dlin_naz_f=length(ggg{1,2});
naz_mat_f=ggg{1,2};
naz_mat_f(dlin_naz_f-3:dlin_naz_f)=[];
poln_naz_mat_f=[path_f_vrem,naz_mat_f,'.mat'];
load (poln_naz_mat_f)
%disp(mass) 
waitbar(0.2)

switch A1(1)
case 1
   kanalu=(1:16);
case 2
   kanalu=B(16+1):B(16+chan);%(1:chan);
end

   
   nom_chan = (find(D(1:16)));
   %nom_chan2= nom_chan;
   
   dosia=0;
   for tyu=nom_chan
      dosia=dosia+1;
      promegt=find(kanalu==tyu)+1;
      if isempty(promegt)~=1
         probna(dosia)=promegt;
      else
         dosia=dosia-1;
      end        
   end
   dosia=0;
   for tyu=kanalu
      dosia=dosia+1;
      promegg= find(nom_chan==tyu);
      if isempty(promegg)~=1
         nom_chan2(dosia)= promegg;
         nom_chan2(dosia)= nom_chan(nom_chan2(dosia));
      else
         dosia=dosia-1;
      end
      
   end
   
   nom_chan=probna;
      
      %nom_chan2 = nom_chan;

%kol_chan=size(mass,2)-1;% количество каналов в массиве mass
% Удаление постоянной составляющей сигнала
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

%Разложение в ряд фурье
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
     
     
%Двойная амплитуда вибрации
     max_vib=(1:chan+1);
     min_vib=(1:chan+1);
     dva_vib=(1:chan+1);
     for tara=nom_chan%2:(chan+1)
        max_vib(tara)=max(mass(:,tara));    
        min_vib(tara)=min(mass(:,tara));
        dva_vib(tara)=max_vib(tara)-min_vib(tara);
     end
waitbar(0.5)

     if D(17)==1 % по среднеквадратичному значению
        SKZ2A=(1:chan+1);
        for tara=nom_chan%2:(chan+1)
           SKZ2A(tara)=sqrt(sum((spectr(:,tara).^2)./2));
        end
     end
     
     if D(17)==2 % по скользящему среднему значению
        %Амплитуда вибрации по скользящему среднему по 31-ому
     max_vib_skl=(1:chan+1);
     min_vib_skl=(1:chan+1);
     dva_vib_skl=(1:chan+1);
      
     kol_skol=31;
     rasm=otsch-kol_skol;
     
        for tara=nom_chan%2:(chan+1)
           %for tara2=1:(otsch-kol_skol)
            %  mass_skl(tara2,tara)=mean(mass(tara2:(tara2+kol_skol),tara)); 
           %end
           mass_skl(:,tara)=skolsr(mass(:,tara),rasm,kol_skol);
           %mass_skl(end-kol_skol:end,tara)=0;
           
           max_vib_skl(tara)=max(mass_skl(:,tara));    
           min_vib_skl(tara)=min(mass_skl(:,tara));
           dva_vib_skl(tara)=max_vib_skl(tara)-min_vib_skl(tara);
        end
     
     end
     
    waitbar(0.6)
 
%Оцениваем вибрацию
   oc_znach=(1:chan+1);
   switch D(17)
      case 1
      oc_znach=SKZ2A;
      case 2
      oc_znach=dva_vib_skl;
      case 3
      oc_znach=dva_vib;
   end
      waitbar(0.7)

   ocenka=(1:chan+1);
   ocenka=ocenka.*0;
   for tara=nom_chan
      %округление до двух знаков после запятой
      oc_znach(tara)=(round(oc_znach(tara)*100))/100;
      if isempty(ggg{1,16+tara})==0
      if strncmpi(lower(strjust(ggg{1,16+tara},'left')),'сс',2)==1
         if oc_znach(tara)>80
            ocenka(tara)=2;%оценка "неудовлетворительно"
         else
            ocenka(tara)=3;%оценка "удовлетворительно"
         end
         
      elseif strncmpi(strjust(ggg{1,16+tara},'left'),'-',1)==0&...
             strncmpi(ggg{1,16+tara},' ',1)==0
         if oc_znach(tara)>180
            ocenka(tara)=1;%оценка "недопустимо"
         elseif oc_znach(tara)>140
            ocenka(tara)=2;%оценка "неудовлетворительно"
         elseif oc_znach(tara)>100
            ocenka(tara)=3;%оценка "удовлетворительно"
         elseif oc_znach(tara)>50
            ocenka(tara)=4;%оценка "хорошо"
         elseif oc_znach(tara)<=50
            ocenka(tara)=5;%оценка "отлично"
         end
      else
         ocenka(tara)=0;
      end
      else
         ocenka(tara)=0;
      end
      
   end
   
   %disp(nom_chan);
   %disp(ocenka);
   waitbar(0.8)

   %Формируем массив для временного файла отчета
   udv_mas=(1:(length(nom_chan)*2));
   udv_mas=udv_mas.*0;
   for hotche=2:2:(length(udv_mas))
      udv_mas(hotche-1)=oc_znach(nom_chan(hotche/2));
      udv_mas(hotche)=ocenka(nom_chan(hotche/2));
   end
   waitbar(0.9)
   naz_f_vr_mass=[path_f_vrem,vr_ot];

   if n_f_pp==1
      vr_mass=(1:(length(nom_chan)*2));
      vr_mass=vr_mass.*0;
      for hotche=2:2:(length(vr_mass))
         vr_mass(hotche-1)=(nom_chan2(hotche/2));
         vr_mass(hotche)=(nom_chan2(hotche/2));
      end
      %disp(vr_mass)
   else
      load (naz_f_vr_mass)
   end
   
   waitbar(1)
      vr_mass=[vr_mass;udv_mas];
      save (naz_f_vr_mass, 'vr_mass')
  close(hi)