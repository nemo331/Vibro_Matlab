function num_r=findnr(podr,sterka)
%FINDNR находит номер €чейки в массиве €чеек совпадающей со строкой
%¬ызов функции:
%  num_r=findnr(podr,sterka)
%  ,где podr-это одномерный массив €чеек
%       sterka-это строка.
%»спользуемые функции: length, strcmp.

chislo=length(podr);
      for ddd=1:chislo
          num_r=strcmp(podr{ddd},sterka);
          if num_r==1 
             num_r=ddd;
             break;
          end
       end 
