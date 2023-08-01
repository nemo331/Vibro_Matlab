function B = obr_biv(fil_f_obr,puti,B)

% 
% Вызов функции:
%               obr_biv
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные:


global gl_put; % путь к гл каталогу
B(68) = 1;
%puti = WK1READ1([gl_put,'path_dir.wks'],0,0,[1 1 7 2]);
path_f_zam=puti{1,2};
str1=[path_f_zam,fil_f_obr];
fil_zam=fopen (str1,'rb');
if fil_zam==-1
   msgbox(['Не могу открыть файл ',str1],'Сообщение')
   break;
end

% Прочитать файл замера
kod_char=(fread(fil_zam,8,'char'))';
str_kod = sprintf('%s',kod_char);
if (strcmp (str_kod,'vibracia'))==0
   fclose(fil_zam);
   B(68) = 0;
   return;
end   

name_f1=(fread(fil_zam,8,'char'))';
regim_opr = fread(fil_zam,1,'int8');
kol_filov = fread(fil_zam,1,'int16');
adres = fread(fil_zam,1,'int16');
Chastota = fread(fil_zam,1,'float32'); 
ch_kan = (fread(fil_zam,16,'char'))';
Number = fread(fil_zam,1,'int16');     
zap_otm = fread(fil_zam,1,'int8');    
nom_kan_otm = fread(fil_zam,1,'int16');%
num_nab = fread(fil_zam,1,'int16');
min_porog = fread(fil_zam,1,'float32');
max_porog = fread(fil_zam,1,'float32');
ch_deg = fread(fil_zam,16,'char');
sekund =fread(fil_zam,1,'long');
dob_k_filu = (fread(fil_zam,52,'char'))';

%msgbox(['Первые символы -',str_kod],'Сообщение')
%disp(sch_kol);
fclose(fil_zam);

B(35)= Chastota;
if B(37)> Number
   B(37)=Number;
end
if B(67)==0
   B(37)=Number;
end

if B(36)> B(37)- 99
   B(36) = B(37)-99;
end

B(41)= num_nab;



for pnk = 1:16
 switch  ch_kan(pnk)% в зависимости от номера выбираем соотв набор коэф-тов 
         case 48
            B(pnk+16)= 1;
            B(67)=B(67)+1;
         case 49
            B(pnk+16)= 2;
            B(67)=B(67)+1;
         case 50
            B(pnk+16)= 3;
            B(67)=B(67)+1;
         case 51
            B(pnk+16)= 4;
            B(67)=B(67)+1;
         case 52
            B(pnk+16)= 5;
            B(67)=B(67)+1;
         case 53
            B(pnk+16)= 6;
            B(67)=B(67)+1;
         case 54
            B(pnk+16)= 7;
            B(67)=B(67)+1;
         case 55
            B(pnk+16)= 8;
            B(67)=B(67)+1;
         case 56
            B(pnk+16)= 9;
            B(67)=B(67)+1;
         case 57
            B(pnk+16)= 10;
            B(67)=B(67)+1;
         case 97
            B(pnk+16)= 11;
            B(67)=B(67)+1;
         case 98
            B(pnk+16)= 12;
            B(67)=B(67)+1;
         case 99
            B(pnk+16)= 13;
            B(67)=B(67)+1;
         case 100
            B(pnk+16)= 14;
            B(67)=B(67)+1;
         case 101
            B(pnk+16)= 15;
            B(67)=B(67)+1;
         case 102
            B(pnk+16)= 16;
            B(67)=B(67)+1;
         otherwise   
            B(pnk+16)= 17;
            B(pnk)= 0;
         end 
         if B(pnk+16)==(nom_kan_otm + 1)
            B(34)= pnk;
         end
         
end
%save ([gl_put,'ust_pros.mat'],'B')