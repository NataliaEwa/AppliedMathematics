function Zad6(x0,n)

a=4;
x(1)=x0;
y=x(1)^2-a; % funkcja podana w zadaniu, spe�nia za�o�enia dla metody Newtona tzn. dwukrotnie r�niczkowalna i y'(4)!=0
pochodna=2*x(1); % pochodna funkcji y
format long

for i=1:n % n iteracji
    x(i+1)=x(i)-y(i)/pochodna(i); % r�wnanie na liczenie kolejnych przybli�e� x
    y(i+1)=x(i+1)^2-a;  % zapisywanie kolejnych miejsc w wektorze funkcji y i y'
    pochodna(i+1)=2*x(i+1);
end

x1=[-5:0.01:5];
y1=x1.^2-a;
y2=zeros(1,length(x1));

plot(x1,y1,'r',x1,y2,'g')
legend('y=x_1^2-4','y=0',4)

for i=1:n-2
    e1(i)=x(i)-x(n); %odleg�o�ci kolejnych przybli�e� x od x(n) 
    e2(i)=x(i+1)-x(n);
end
x

cftool(-log(e1),-log(e2))% p1 - empiryczny rz�d metody
%mo�e delikatnie odbiega� od teoretycznego przez niedok�adno�� cftool'aend
