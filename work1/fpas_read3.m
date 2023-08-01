function structura=fpas_read3(dia_any,path_f,name_f,name_f_pas)
% fpas_read эксперимент с меню данные вызываются из файла
% Вызов функции:
%   fpas_read
% Используемые функци: Нет
% Входные переменные: Нет

%dia_any=1; %1-файлы DIAGNOST, 2-любые файлы(DSK)
%path_f='d:\DIAGNOST\BIN\'; %путь до файла
%name_f='losh__01.bin'; %название файла данных
%name_f_pas='d:\DIAGR\soho.txt'; %название файла паспорта


nnn=nargin;
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
   structura=struct('Npp',cell(1,shet),'NameFile','','NGA','','Date','','Regim','',...
   'Podregim','','P','','Q','','Ir','','Ist','','Ust','','RK','','NA','',...
   'Obor','','Tg','','Napor','','Prim','','Chan1','','Chan2','','Chan3','',...
   'Chan4','','Chan5','','Chan6','','Chan7','','Chan8','','Chan9','',...
   'Chan10','','Chan11','','Chan12','','Chan13','','Chan14','','Chan15','',...
   'Chan16','','Frequency','','Amount','','Gang','');

   frewind(d);
   
   shet2=0;
   st='Null';
   while  shet2<shet           %st~=-1    %Цикл по строкам 
      [st,lo]=fgets(d);
      ss=find(st==9|st==10);
      kol_pol=length(ss);
      %pause;
      on=1; ot=1; kav=1; nom_pp=1; polia=1; tec=1;    
      while polia<=kol_pol  %Цикл по строкам
          prom='';
         
          [prom,co,er,ne]=sscanf(st(tec:ss(polia)),'%s',10);
          tec=ss(polia);
          dl_sl=length(prom);
        
        if(dl_sl==0), prom='';
        else  
           if(prom(1)==34), prom(1)=' ';, end
           if(prom(dl_sl)==34), prom(dl_sl)=' ';, end
           prom=sscanf(prom,'%s',1);
        end
        %disp(shet2);
           switch (polia)
               case 1, structura(1,shet2+1).Npp=prom;
               case 2, structura(1,shet2+1).NameFile=prom;
               case 3, structura(1,shet2+1).NGA=prom;
               case 4, structura(1,shet2+1).Date=prom;
               case 5, structura(1,shet2+1).Regim=prom;
               case 6, structura(1,shet2+1).Podregim=prom;
               case 7, structura(1,shet2+1).P=prom;
               case 8, structura(1,shet2+1).Q=prom;
               case 9, structura(1,shet2+1).Ir=prom;
               case 10, structura(1,shet2+1).Ist=prom;
               case 11, structura(1,shet2+1).Ust=prom;
               case 12, structura(1,shet2+1).RK=prom;
               case 13, structura(1,shet2+1).NA=prom;
               case 14, structura(1,shet2+1).Obor=prom;
               case 15, structura(1,shet2+1).Tg=prom;
               case 16, structura(1,shet2+1).Napor=prom;
               case 17, structura(1,shet2+1).Prim=prom;
               case 18, structura(1,shet2+1).Chan1=prom;
               case 19, structura(1,shet2+1).Chan2=prom;
               case 20, structura(1,shet2+1).Chan3=prom;
               case 21, structura(1,shet2+1).Chan4=prom;
               case 22, structura(1,shet2+1).Chan5=prom;
               case 23, structura(1,shet2+1).Chan6=prom;
               case 24, structura(1,shet2+1).Chan7=prom;
               case 25, structura(1,shet2+1).Chan8=prom;
               case 26, structura(1,shet2+1).Chan9=prom;
               case 27, structura(1,shet2+1).Chan10=prom;
               case 28, structura(1,shet2+1).Chan11=prom;
               case 29, structura(1,shet2+1).Chan12=prom;
               case 30, structura(1,shet2+1).Chan13=prom;
               case 31, structura(1,shet2+1).Chan14=prom;
               case 32, structura(1,shet2+1).Chan15=prom;
               case 33, structura(1,shet2+1).Chan16=prom;
                 
               otherwise, break
           end
        %disp(structura(1,shet2+1).Npp);
        polia=polia+1;
     end
     %structura(1,shet2+1).Chan16='отметчик';
     structura(1,shet2+1).Frequency=400;
     structura(1,shet2+1).Amount=8192;
     structura(1,shet2+1).Gang=1;
     shet2=shet2+1;
      
   end
fclose (d);     %закрытие файла паспортов
   
%disp(shet);
%disp(strok{3,6})


else   %для DSK
   %str2=strcat(path,name_f,'0',int2str(g),'.o16');

end

