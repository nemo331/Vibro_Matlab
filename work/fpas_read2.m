function fpas_read();%(dia_any,path_f,name_f,name_f_pas)
% fpas_read эксперимент с меню данные вызываются из файла
% Вызов функции:
%   fpas_read
% Используемые функци: Нет
% Входные переменные: Нет

dia_any=1; %1-файлы DIAGNOST, 2-любые файлы(DSK)
path_f='c:\DIAGNOST\BIN\'; %путь до файла
name_f='losh__01.bin'; %название файла данных
name_f_pas='c:\DIAGR\soho.txt'; %название файла паспорта

structura=struct('Npp',cell(1,10),'NameFile','','NGA','','Date','','Regim','',...
   'Podregim','','P','','Q','','Ir','','Ist','','Ust','','RK','','NA','',...
   'Obor','','Tg','','Napor','','Prim','','Chan1','','Chan2','','Chan3','',...
   'Chan4','','Chan5','','Chan6','','Chan7','','Chan8','','Chan9','',...
   'Chan10','','Chan11','','Chan12','','Chan13','','Chan14','','Chan15','',...
   'Chan16','','Frequency','','Amount','','Gang','');

%structura=setfield(structura,'Npp',1)
nnn=4;
d=0;
if (dia_any==1&nnn>3)  %для DIAGNOST
   
      d=fopen (name_f_pas,'rt'); %открытие файла данных для чтения
   if d==-1,disp(strcat('Не могу открыть файл: ',name_f_pas));
     break;
   end
   %st=fscanf(d,'%c')%чтение  файла паспортов
   st='Null';
   shet=0;
   while st~=-1    %Подсчет кол-ва строк
      st=fgetl(d);
      if st==-1; break, end
      shet=shet+1;
   end
   frewind(d);
   kod_t=9;
   kod_n=10;
   kod_kav=34;
   shet=0;
   st='Null';
   while st~=-1    %Цикл по строкам 
      st=fgets(d);
      kol_sim=length(st);
      %pause;
      on=1; ot=1; kav=1; nom_pp=1; polia=0;    
      while nom_pp<kol_sim    %Цикл по строкам
         prom=' ';
         ot=1; 
         kav=1;
          while (on~=0&ot~=0) %Цикл по символам
            t=st(nom_pp);
            ot=kod_t-(double(t));
            on= kod_n-(double(t));
            kav= kod_kav-(double(t));
                if (kav~=0&ot~=0&on~=0)
                   prom=strcat(prom,t);
                end
           nom_pp=nom_pp+1;
        end
        
       polia=polia+1; 
      end

      if (shet>1), break, end
      shet=shet+1;
      %break;
   end
fclose (d);     %закрытие файла паспортов
   
%disp(shet);
%disp(strok{3,6})


else   %для DSK
   %str2=strcat(path,name_f,'0',int2str(g),'.o16');

end

