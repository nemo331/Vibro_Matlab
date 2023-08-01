function dima()
% 4x/x+2

%ff=1:1000

x=-10.00:0.01:10.00;
y=-10.00:0.01:10.00;

y=((x.^3-2)./(3.*x)).^0.5;

%for gh=1:length(x)
 %  y(gh)=log(x(gh))+1;
%end
%sprintf('%5.5f',y)
%fprintf(1,'Hello, World\n' );
plot (x,y)
%grid on;
%zoom on;