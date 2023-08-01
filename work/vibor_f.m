function probn = vibor_f(f_zam,puti)

% Просмотр файла замера вибрации
% Вызов функции:
%               vibor_f
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные:

global gl_put; % путь к гл каталогу
kol_f_zam=length(f_zam);
path_f_zam=puti{1,2};
vibor = zeros(1,kol_f_zam);
p_biv=0;
for npp=1:kol_f_zam
   fil_f_obr=lower(f_zam(npp).name);
   str1=[path_f_zam,fil_f_obr];
   fil_zam=fopen (str1,'rb');
   if fil_zam==-1
      msgbox(['Не могу открыть файл ',str1],'Сообщение')
      break;
   end
   
   % Прочитать файл замера
   kod_char=(fread(fil_zam,8,'char'))';
   str_kod = sprintf('%s',kod_char);
   if (strcmp (str_kod,'vibracia'))==1
      p_biv=p_biv+1;
      vibor(npp)=1;
      if(p_biv==1)
         name_f1=(fread(fil_zam,8,'char'))';
         regim_opr = fread(fil_zam,1,'int8');
         kol_filov = fread(fil_zam,1,'int16');
         adres = fread(fil_zam,1,'int16');
         Chastota = fread(fil_zam,1,'float32'); 
         ch_kan = (fread(fil_zam,16,'char'))';
         Number = fread(fil_zam,1,'int16');     
         zap_otm = fread(fil_zam,1,'int8');    
         nom_kan_otm = fread(fil_zam,1,'int16');
         num_nab = fread(fil_zam,1,'int16');
         min_porog = fread(fil_zam,1,'float32');
         max_porog = fread(fil_zam,1,'float32');
         ch_deg = fread(fil_zam,16,'char');
         sekund =fread(fil_zam,1,'long');
         dob_k_filu = (fread(fil_zam,52,'char'))';
         vibor(npp)=1;
      else
         name_f2=(fread(fil_zam,8,'char'))';
         regim_opr2 = fread(fil_zam,1,'int8');
         kol_filov2 = fread(fil_zam,1,'int16');
         adres2 = fread(fil_zam,1,'int16');
         Chastota2 = fread(fil_zam,1,'float32'); %
         if (Chastota~=Chastota2) Chastota2=0; end
         ch_kan2 = (fread(fil_zam,16,'char'))';
         vibor(npp)= (strcmp(sprintf('%s',ch_kan),sprintf('%s',ch_kan2)))*Chastota2;
         Number2 = fread(fil_zam,1,'int16');
         if(Number ~= Number2 )
            Number2=0;
         end
         vibor(npp)= Number2*vibor(npp);
         zap_otm2 = fread(fil_zam,1,'int8');    
         nom_kan_otm2 = fread(fil_zam,1,'int16');
         num_nab2 = fread(fil_zam,1,'int16');%
         if (num_nab~=num_nab2)
            num_nab2=0;
         end
         vibor(npp)= num_nab2*vibor(npp);
         min_porog2 = fread(fil_zam,1,'float32');
         max_porog2 = fread(fil_zam,1,'float32');
         ch_deg2 = fread(fil_zam,16,'char');
         sekund2 =fread(fil_zam,1,'long');
         dob_k_filu2 = (fread(fil_zam,52,'char'))'; 
         if(vibor(npp)>0)
            vibor(npp)= 1;
         end
      end
      
   end 
   fclose(fil_zam);
end
ex_n=0;
flag =0;
for npp=1:kol_f_zam
   if vibor(npp)==1
      ex_n=ex_n+1;
      if ex_n == 1
         probn=f_zam(npp);
      else
         probn=[probn;f_zam(npp)];
      end   
   else
      flag = 1;
   end
end

if (flag==1)
   msgbox(['Некоторые файлы удалены из обработки из-за несоответствия первому'],'Сообщение')
end

