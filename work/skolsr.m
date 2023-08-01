function v2=skolsr(v,rasm,kolskol)
% Обработка по скользящему среднему
% Вызов функции:
%               skolsr
% Используемые функции:
%                      
% Используемые функции MATLAB:
%                       mean     
% Входные переменные:
% v- вектор подлежащий обработке
% kol_skol - кол-во элементов по которым находится среднее
% rasm - длина вектора без kol_skol

v2=zeros(size(v));
for tara2=1:rasm
   prom=0;
   for tara3=tara2:(kolskol+tara2)
      prom=prom+v(tara3);
   end
   %v2(tara2)=(sum(v(tara2:(tara2+kolskol))))/kolskol;
   v2(tara2)=prom/kolskol;
end   
