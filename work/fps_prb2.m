
function fps_prb1%(dia_any,path_f,name_f,name_f_pas)
% fps_prb1 чтение файла паспорта 
% Вызов функции:
%   structura=fpas_read4(dia_any,path_f,name_f,name_f_pas)
% Используемые функци: Нет
% Входные переменные: Нет

   
      %d=fopen (name_f_pas,'rt'); %открытие файла данных для чтения
   %if d==-1,disp(strcat('Не могу открыть файл: ',name_f_pas));
   % break;
   %A = wk1read1(name_f_pas,0,0,[1 1 1 33]);
   %B= wk1read1(name_f_pas,1,0,[2 1 2 33]);
   %C=[A;B]
   %celldisp(A(1,1));
  
   %st=fscanf(d,'%c')%чтение  файла паспортов
   %c=A(1,1); %693961
   %d=struct('dates',cell(11,1))
   
   %dd=cell2struct(A,'dat',2)
   %dlin=length(A(:,1))
   %for nnn=1:11
   %   d(nnn,1).dates=datestr((dd(nnn).dat+693961),2);
   %   disp(d(nnn,1).dates)
   %end
   %wk1write1(name_f_pas,A,0,0)
   %A=cell(10);
   %d = '12/31/1899'
   %rty=datenum(d(1,1).dates)-693961
   %f=datevec(s)
   %str = datestr(s,2)
   %cd
   %B=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
   A1=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
   A2=[1]
   A3=[1]
   save C:\Matlab\Toolbox\work\ust1.mat  A1 A2 A3
   clear A1 A2
   %load C:\Matlab\Toolbox\work\ust_ot~3.mat 
   %disp(C);
   %disp(D);
   %disp(E);
   %h = waitbar(0,'Please wait...');
        %for i=1:10,
            % computation here %
            %waitbar(i/10)
        %end
        