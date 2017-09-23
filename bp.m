clc,clear;
data=xlsread('I:\��ѧ��ģ������\data13.xls');
x=data(243:691,[7 8]);
y=data(243:691,6);
[XN,XS1]=mapminmax(x);%��һ��y = (ymax-ymin)*(x-xmin)/(xmax-xmin) + ymin
[YN XS2]=mapminmax(y);%��һ��
x=x';
y=y';
net=newff(minmax(x),[80,1],{'tansig','purelin'},'traingdm');%����ѵ������
%��ǰ�����Ȩֵ����ֵ
inputWeights=net.IW{1,1};
inputbias=net.b{1};
%��ǰ�����Ȩֵ����ֵ
layerWeights=net.IW{2,1};
iayerbias=net.b{2};
%ѵ������
net.trainParam.show=50;
net.trainParam.lr=0.01;
net.trainParam.mc=0.9;
net.trainParam.epochs=400;
net.trainParam.goal=1e-3;
%����TRAINGDM�㷨ѵ��BP����
[net,tr]=train(net,x,y);
%BP����
A_train=sim(net,x);
%����������
E=y-A_train;
%�������
disp '����ѵ���������'
MSE=mse(E,net)
ms=msereg(E,net)
figure(1)
plot(y,'ro--','linewidth',2)
hold on
plot(A_train,'bs--','linewidth',2)
legend('ʵ��ֵ','���ֵ')
lat=[22.718];
lon=[114.26];
x=[lat lon];
x=x';
x=mapminmax(x);
y0=sim(net,x);
y1=mapminmax(y0)
