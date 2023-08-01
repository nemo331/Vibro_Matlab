function find_file()

% Просмотр файла замера вибрации
% Вызов функции:
%               find_file
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Входные переменные:

osn_katal= 'D:\ARHIV\';%zip-disk1\ARHIV_GA\';
%osn_katal2= 'D:\ARHIV\';
name_dir=dir([osn_katal,'*.*']);
%disp(name_dir(3))
kol_df=length(name_dir);
for por_n_f=3:kol_df
   if (name_dir(por_n_f).isdir==1)
      osn_katal2= [osn_katal,name_dir(por_n_f).name,'\'];
      name_dir2=dir([osn_katal2,'*.*']);
      kol_df2=length(name_dir2);
      for por_n_f2=3:kol_df2
         if (name_dir2(por_n_f2).isdir==1)
            osn_katal3= [osn_katal2,name_dir2(por_n_f2).name,'\'];
            name_dir3=dir([osn_katal3,'*.*']);
            kol_df3=length(name_dir3);
            for por_n_f3=3:kol_df3
               if (name_dir3(por_n_f3).isdir==1)
                  osn_katal4= [osn_katal3,name_dir3(por_n_f3).name,'\'];
                  name_dir4=dir([osn_katal4,'*.*']);
                  kol_df4=length(name_dir4);
                  for por_n_f4=3:kol_df4
                     if (name_dir4(por_n_f4).isdir==1)
                        osn_katal5= [osn_katal4,name_dir4(por_n_f4).name,'\'];
                        name_dir5=dir([osn_katal5,'*.*']);
                        kol_df5=length(name_dir5);
                        
                     else
                        nazv_f4=name_dir4(por_n_f4).name;
                        write_n_f(lower(osn_katal4),lower(nazv_f4));
                     end
                  end
                  
                  
               else
                  nazv_f3=name_dir3(por_n_f3).name;
                  write_n_f(lower(osn_katal3),lower(nazv_f3));
               end
            end
            
         else
            nazv_f2=name_dir2(por_n_f2).name;
            write_n_f(lower(osn_katal2),lower(nazv_f2));
         end
      end
      
      
   else
      nazv_f=name_dir(por_n_f).name;
      write_n_f(lower(osn_katal),lower(nazv_f));
      
   end
   
   
end

