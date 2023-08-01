function write_n_f(katal,nazv_f)

% Просмотр файла замера вибрации
% Вызов функции:
%               write_n_f
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные:nazv_f

%nazv_f='Bryak.arj';
txt_f='proba.txt';
%katal= 'D:\A4\Arhiv\';
temp_katal= 'C:\MATLAB\toolbox\work2\temp';

dl=length(nazv_f);
rassh=nazv_f((dl-2):dl);

if (strcmp(rassh,'arj')==1)
   root_dir= cd;
   cd (temp_katal);
   dos(['arj e -v -y ',katal,nazv_f, ' *.bin']);
   cd (root_dir);
   files=dir([temp_katal,'\*.bin']);
   kol_f=length(files);
   for ppp=1:kol_f
      name_f=lower(files(ppp).name);
      dl_n_f=length(name_f);
      if (dl_n_f>11)
         name_f(7:dl_n_f)=[];
         
         for dxd=1:6
            if strcmp(name_f(dxd),'_')==1
               name_f(dxd)=' ';
            end
         end
         
         name_f=deblank(name_f);
         str1=[temp_katal,'/',txt_f];
         fil_zam=fopen (str1,'rt+');
         if fil_zam==-1
            msgbox(['Не могу открыть файл ',str1],'Сообщение')
            break;
         end
         line = fgetl(fil_zam);
         
         flag=0;
         while (ischar(line)==1)
            if (strcmp(line,name_f)==1)
               flag=1;
            end
            line = fgetl(fil_zam);
         end
         if (flag==0)
            status = fseek(fil_zam,0,'eof');
            fprintf(fil_zam,'\n%s',name_f);
            
         end
         
         fclose(fil_zam);
         
      end
      
   end
   
   
else
   return;   
end

delete([temp_katal,'\*.bin']);
return;
