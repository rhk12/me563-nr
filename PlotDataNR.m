file1 = 'output.dat';
[A] = importdata(file1);

% define variables
incrm=A(:,1);
niter=A(:,2);
rnorm=A(:,3);
x=A(:,4);
f=A(:,5);
stiff=A(:,6);

%define plots
subplot(3,2,1)
plot(x,f)
title('x vs. f')
xlabel('x');
ylabel('f');

%define plots
subplot(3,2,2)
plot(incrm,f)
title('incrm vs. f')
xlabel('incrm');
ylabel('f');

%define plots
subplot(3,2,3)
plot(f,stiff)
title('f vs. stiff')
xlabel('f');
ylabel('stiff');

%define plots
subplot(3,2,4)
plot(incrm,x)
title('incrm vs. x')
xlabel('incrm');
ylabel('x');

%define plots
subplot(3,2,5)
plot(incrm,niter)
title('incrm vs.niter')
xlabel('incrm');
ylabel('niter');