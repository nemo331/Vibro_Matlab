function osh=soz_vr_pas(dia_any,name_f_pas,f_zam,vrem_f_pas,puti)

% soz_vr_pas функция для создания временного файла паспортов из постоянных
% Вызов функции:
%               soz_vr_pas1(dia_any,name_f_pas,f_zam)
% где dia_any-стандартный(1) или нестандартный файл(0)
% name_f_pas - название файла паспортов (или файла паспорта)
% f_zam - структура с названиями файлов замеров которые выбраны
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                            
% Выходные переменные:vrem_f_pas - название временного файла с паспортами

osh=0;
%path_f_zam=puti{1,2}%'C:\Matlab\Toolbox\work3\';
path_f_vrem=puti{5,2};%путь до временного файла паспортов
path_f_pas=puti{3,2};%'C:\Matlab\Toolbox\work2\'; %путь до файла паспортов
%vrem_f_pas='vrem_pas.wks'; %название временного файла паспортов
kol_f_zam=length(f_zam); %количество выбранных файлов замеров
mat_kol_f=[1:kol_f_zam]; % вектор-строка с порядковыми номерами выбр файлов
%name_f=lower(f_zam(1).name); %название первого в списке файла данных
%break;
if dia_any>0
   hi = waitbar(0,'Поиск паспортных данных. Ждите...');
   por_n_f=1; %порядковый номер файла берется из матрицы mat_kol_f
   n_f_pasvse=name_f_pas;% если вместо имени файла паспорта стоит 'все'
   kol_kr=0;% кол-во циклов while  
   while length(mat_kol_f)~=0
      %por_n_f= por_n_f+1;
      name_f=lower(f_zam(mat_kol_f(por_n_f)).name);
   %Чтение файла с паспортами замеров (формат **.wks(Lotus 1-2-3))
   % в массив ячеек
   
      if n_f_pasvse==0%strcmp('все',n_f_pasvse)==1
         name_fl_pas=dir([path_f_pas,'*.wks']);%Чтение из опр каталога имена файлов паспортов
         kol_f_=length(name_fl_pas);   %Определяем кол-во паспортов
         kol_f_pas=1:kol_f_;
      else 
         name_fl_pas=dir([path_f_pas,'*.wks']);
         %name_fl_pas=struct('name',name_f_pas);
         kol_f_pas=name_f_pas;
      end
      waitbar(0.1)  
      for gh=kol_f_pas
       aaa = WK1READ1([path_f_pas,name_fl_pas(gh).name],0,0,[1 1 1 34]);%Чтение первой строки
       kz=300;
       vvv = WK1READ1([path_f_pas,name_fl_pas(gh).name],1,0,[2 1 kz 2]);%Предварительное чтение для нахождения кол-ва записей
       fff = vvv'; 
       kz=length(fff(1,:));
       nmn=cell2struct(fff(2,:),'name',kz);
       sovp=0;
         for sd=1:kz
          sovp=strcmp (name_f,nmn(sd).name);
          if sovp==1
             break;
          end
         end
          if sovp==1
             name_f_pas=name_fl_pas(gh).name;
             break;
          end
      end
       if sovp==0
          strochka=sprintf('Нет паспортных данных по файлу: %s',...
             name_f);
           mat_kol_f(por_n_f)=[];
           msgbox(strochka,'Сообщение')
           %close(hi)
               
       else
       waitbar(0.4)
       sss = WK1READ1([path_f_pas,name_f_pas],1,0,[2 1 (kz+1) 34]);%Окончательное чтение  
       %celldisp(sss(1,:))
       if kol_kr==0
          rrr=aaa;
       end
       waitbar(0.6)
       %Поиск нужных строк данных по названиям файлов в массиве ячеек sss
       tec_por=mat_kol_f;
       
       for bds=tec_por
          f_popor=lower(f_zam(bds).name);  
          sovp=0;
          for sd=1:kz
             sovp=strcmp (f_popor,sss{sd,2});
             if sovp==1
                %добавить строку ячеек в новый массив ячеек
                rrr=[rrr;sss(sd,:)];
                poriadkov_n=find(mat_kol_f==bds);
                mat_kol_f(poriadkov_n)=[];

                break;
             end
          end
       end
       waitbar(0.9)
       kol_kr=kol_kr+1;
   end    
       %break;       
   end %конец цикла while length(mat_kol_f)~=0
    close(hi)
    %disp(rrr)
    %break;
    
    % сортировка записей во временном файле для графика(хх,воз,ген,ск)
    kol_zapis=size(rrr,1);
    bbb=zeros(1,kol_zapis);
     for sdd=2:kol_zapis
        % проверка на соответствие значения номерам ГА 
       if isnumeric(rrr{sdd,3})==1
          if rrr{sdd,3}<1|rrr{sdd,3}>10, bbb(sdd)=sdd;
          else, rrr{sdd,3}=fix(rrr{sdd,3});
          end
       elseif isstr(rrr{sdd,3})==1
          % преобразовать строку в число
          sdf=length(rrr{sdd,3});
          promeg=rrr{sdd,3};
           prost=0;
           for jjj=1:sdf
              if isletter(promeg(jjj))==1 
                 prost=1;
              end
           end
           if prost==1
              bbb(sdd)=sdd;
           else
              rrr{sdd,3}=str2num(rrr{sdd,3});
              if rrr{sdd,3}<1|rrr{sdd,3}>10, bbb(sdd)=sdd;
              else, rrr{sdd,3}=fix(rrr{sdd,3});
              end
           end
       else
          % если не соответствует двум первым условиям то отметить эту строку 
          bbb(sdd)=sdd;
       end  
    end
    % отмеченные строки удалить
    %ccc=rrr(1,:);
    for sdd=2:kol_zapis
       if bbb(sdd)>0
          rrr(bbb(sdd),:)=[];
          bbb=bbb-1;
          %ccc=[ccc;rrr(sdd,:)];
       end
    end    
    
    if (size(rrr,1))<kol_zapis
       msgbox('Проверь номера ГА в файле паспортов','Сообщение')
       if (size(rrr,1))<2
          return;
       end
    end
    
    %disp(bbb)
    %disp(rrr)
    %найти номер га который больше всего встречается...
    kol_zapis=size(rrr,1);
    nom_ga=zeros(1,(kol_zapis-1));
    for fff=1:kol_zapis-1
       nom_ga(fff)=rrr{(fff+1),3};
    end
    ppp=zeros(1,10);
       for nppp=1:10
          ppp(nppp)=length(find(nom_ga==nppp));
       end
    max_kol_ga=find(ppp==max(ppp));
    % ...остальные строки удалить
    fff=1;
    while fff~=kol_zapis
       fff=fff+1;
       if rrr{fff,3}~=max_kol_ga(1)
          rrr(fff,:)=[];
          fff=fff-1;
          kol_zapis=kol_zapis-1;
       end       
    end
    %disp(rrr)
    
    %проверка названий режимов
    hhh=rrr(1,:);
    naz_reg={'рхх','воз','ген','рск','ост','выб'};
    skolko=zeros(1,6);
    kotor=0;
    for por_pr=1:6
    kol_zapis=size(rrr,1);% кол-во записей в исх врем массиве паспортов
    fff=1;
    while fff~=kol_zapis
       fff=fff+1;
       if ischar(rrr{fff,5})==1 % если строка символов...
          rrr{fff,5}=lower(rrr{fff,5});
          if (strcmp(rrr{fff,5},naz_reg{por_pr}))==1%...и если соответствует
             hhh=[hhh;rrr(fff,:)];    % названию режима
             kotor=kotor+1;           % сохранить в другом массиве
          end
       else                      % если не строка символов
          rrr(fff,:)=[];         % удалить
          fff=fff-1;
          kol_zapis=kol_zapis-1;
       end       
    end
    skolko(por_pr)=kotor;
    end
    
    %disp(skolko) 
    kol_zap1=size(hhh,1);
    %disp(hhh)
    % проверка названий подрежимов для всех режимов и в зависимости от
    % условий удаление, преобразование или сохранение в неизм виде
    sdd=1;
    skolko=skolko+1;
    vuchit=0;
    for por_nem=1:6
       skolko(por_nem)=skolko(por_nem)-vuchit;% коррект кол-ва подреж в зависимости от удаленных
       kol_zapis=skolko(por_nem);
    while sdd~=kol_zapis
       sdd=sdd+1;
       %if sdd>kol_zapis, break, end
       if (isnumeric(hhh{sdd,6})==1) % для числовых значений
          if (strcmp(hhh{sdd,5},'воз')==1)% если возб удалить строку из 
             hhh(sdd,:)=[];               % файла паспортов
             sdd=sdd-1;
             kol_zapis=kol_zapis-1;
             skolko(por_nem)=skolko(por_nem)-1;
             vuchit=vuchit+1;
          else                             % иначе оставить в неизм виде
             hhh{sdd,6}=fix(hhh{sdd,6});
          end
       elseif isstr(hhh{sdd,6})==1  %для строки символов 
          % преобразовать строку в число
          sdf=length(hhh{sdd,6});
          promeg=hhh{sdd,6};
           prost=0;
           for jjj=1:sdf
              if (strcmp(promeg(jjj),'0')~=1)&(strcmp(promeg(jjj),'1')~=1)&...
                    (strcmp(promeg(jjj),'2')~=1)&(strcmp(promeg(jjj),'3')~=1)&...
                    (strcmp(promeg(jjj),'4')~=1)&(strcmp(promeg(jjj),'5')~=1)&...
                    (strcmp(promeg(jjj),'6')~=1)&(strcmp(promeg(jjj),'7')~=1)&...
                    (strcmp(promeg(jjj),'8')~=1)&(strcmp(promeg(jjj),'9')~=1)&...
                    (strcmp(promeg(jjj),'.')~=1)&(strcmp(promeg(jjj),'-')~=1)
                 prost=1;
              end
           end
           if prost==1 %если строку симв нельзя преобр в число
              hhh{sdd,6}=lower(hhh{sdd,6});
              if (strcmp(hhh{sdd,5},'воз')==1) % если возб 
                 if (strcmp(hhh{sdd,6},'min')==0)&(strcmp(hhh{sdd,6},'nom')==0)&...
                    (strcmp(hhh{sdd,6},'max')==0) % и не соотв данным подрежимам
                 hhh(sdd,:)=[]; % то удалить
                 sdd=sdd-1;
                 kol_zapis=kol_zapis-1;
                 skolko(por_nem)=skolko(por_nem)-1;
                 vuchit=vuchit+1;
                 end
              else %если не возб
                 if (strcmp(hhh{sdd,5},'ост')~=1)&(strcmp(hhh{sdd,5},'выб')~=1)&...
                       (strcmp(hhh{sdd,5},'рск')~=1) % и не соотв данным подрежимам
                 hhh(sdd,:)=[];
                 sdd=sdd-1;
                 kol_zapis=kol_zapis-1;
                 skolko(por_nem)=skolko(por_nem)-1;
                 vuchit=vuchit+1;
                 end
              end
           else  % иначе преобр в число в зависимости от условий 
              if (strcmp(hhh{sdd,5},'воз')==0) % если не возбуждение
                 hhh{sdd,6}=fix(str2num(hhh{sdd,6}));% преобразоать в число
              else   % иначе
                 hhh(sdd,:)=[]; % удалить
                 sdd=sdd-1;
                 kol_zapis=kol_zapis-1;
                 skolko(por_nem)=skolko(por_nem)-1;
                 vuchit=vuchit+1;
              end
            end
       else
          % если не соответствует двум первым условиям то удалить 
          hhh(sdd,:)=[];
          sdd=sdd-1;
          kol_zapis=kol_zapis-1;
          skolko(por_nem)=skolko(por_nem)-1;
          vuchit=vuchit+1;
       end  
    end
 end
 
    %disp(hhh)
    %disp(skolko)
    kol_zapis=size(hhh,1);
    
    if kol_zap1>kol_zapis
       msgbox('Проверь подрежимы в файле паспортов','Сообщение')
       if kol_zapis<2
          return;
       end
    end

    %return;

    podregima=zeros(1,kol_zapis);
    ots=zeros(1,kol_zapis);
    ind=zeros(1,kol_zapis);
    % сортировка по возрастанию подрежимов для всех режимов 
    rrr=hhh;
    nachalo=1;
    for por_nem=[1 2 3 4 5 6]
       if por_nem==1
          nachalo=nachalo+1;
       else
          nachalo=skolko(por_nem-1)+1;
       end
       if por_nem~=2
          for kkk=nachalo:skolko(por_nem)%выделение названий подрежимов
             if ischar(hhh{kkk,6})==1    %для всех режимов кроме возб
                break;
             else
                podregima(kkk)=hhh{kkk,6};
             end
          end
       else
          for kkk=nachalo:skolko(por_nem) %назначение номеров подрежимов
             if strcmp(hhh{kkk,6},'min')==1 % в зависимости от названий
                podregima(kkk)=1;           % для возб
             elseif strcmp(hhh{kkk,6},'nom')==1
                podregima(kkk)=2;
             elseif strcmp(hhh{kkk,6},'max')==1
                podregima(kkk)=3;
             else
                podregima(kkk)=0;
             end      
          end
       end
       [ots(nachalo:skolko(por_nem)),ind(nachalo:skolko(por_nem))]=...
          sort(podregima(nachalo:skolko(por_nem)));%собственно сортировка
       
       for kkk=nachalo:skolko(por_nem)
          rrr(kkk,:)=hhh((ind(kkk)+(nachalo-1)),:);
       end
    end
    
    %disp(rrr)
     %   return;
    hite = waitbar(0.1,'Сохранение врем. файла паспортов. Ждите...');
    %сохранение временного файла паспортов в каталоге с файлами замеров
    wk1write1([path_f_vrem,vrem_f_pas],rrr,0,0) 
    waitbar(0.9)
    close(hite)

else
   stracta=fpas_read4(dia_any,path_f,name_f);
end
osh=1;
return;