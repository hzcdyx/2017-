function main()
clc                          % ����
clear all;                  %����ڴ��Ա�ӿ������ٶ�
close all;                  %�رյ�ǰ����figureͼ��
SamNum=20;                  %������������Ϊ20
TestSamNum=20;              %������������Ҳ��20
ForcastSamNum=2;            %Ԥ����������Ϊ2
HiddenUnitNum=8;            %�м�����ڵ�����ȡ8,�ȹ�����������1��
InDim=3;                    %��������ά��Ϊ3
OutDim=2;                   %�������ά��Ϊ2
data=xlsread('I:\��ѧ��ģ������\data13.xls');
x=data(243:691,7);
y=data(243:691,6);
z=data(243:691,8);
x=x';
z=z';
y=y';
p=[x;z];  %�������ݾ���
t=[y];           %Ŀ�����ݾ���
[SamIn,minp,maxp,tn,mint,maxt]=premnmx(p,t); %ԭʼ�����ԣ�������������ʼ��
rand('state',sum(100*clock))   %����ϵͳʱ�����Ӳ��������         
NoiseVar=0.01;                    %����ǿ��Ϊ0.01�����������Ŀ����Ϊ�˷�ֹ���������ϣ�
Noise=NoiseVar*randn(2,SamNum);   %��������
SamOut=tn + Noise;                   %��������ӵ����������

TestSamIn=SamIn;                           %����ȡ�������������������ͬ��Ϊ��������ƫ��
TestSamOut=SamOut;                         %Ҳȡ������������������ͬ

MaxEpochs=50000;                              %���ѵ������Ϊ50000
lr=0.035;                                       %ѧϰ����Ϊ0.035
E0=0.65*10^(-3);                              %Ŀ�����Ϊ0.65*10^(-3)
W1=0.5*rand(HiddenUnitNum,InDim)-0.1;   %��ʼ���������������֮���Ȩֵ
B1=0.5*rand(HiddenUnitNum,1)-0.1;       %��ʼ���������������֮�����ֵ
W2=0.5*rand(OutDim,HiddenUnitNum)-0.1; %��ʼ���������������֮���Ȩֵ              
B2=0.5*rand(OutDim,1)-0.1;                %��ʼ���������������֮�����ֵ

ErrHistory=[];                              %���м����Ԥ��ռ���ڴ�
for i=1:MaxEpochs
    
    HiddenOut=logsig(W1*SamIn+repmat(B1,1,SamNum)); % �������������
    NetworkOut=W2*HiddenOut+repmat(B2,1,SamNum);    % ������������
    Error=SamOut-NetworkOut;                       % ʵ��������������֮��
    SSE=sumsqr(Error)                               %�������������ƽ���ͣ�

    ErrHistory=[ErrHistory SSE];

    if SSE<E0,break, end      %����ﵽ���Ҫ��������ѧϰѭ��
    
    % ����������BP��������ĵĳ���
    % ������Ȩֵ����ֵ�����������������ݶ��½�ԭ��������ÿһ����̬������
    Delta2=Error;
    Delta1=W2'*Delta2.*HiddenOut.*(1-HiddenOut);    
    dW2=Delta2*HiddenOut';
    dB2=Delta2*ones(SamNum,1);
    dW1=Delta1*SamIn';
    dB1=Delta1*ones(SamNum,1);
    %���������������֮���Ȩֵ����ֵ��������
    W2=W2+lr*dW2;
    B2=B2+lr*dB2;
    %���������������֮���Ȩֵ����ֵ��������
    W1=W1+lr*dW1;
    B1=B1+lr*dB1;
end
HiddenOut=logsig(W1*SamIn+repmat(B1,1,TestSamNum)); % ������������ս��
NetworkOut=W2*HiddenOut+repmat(B2,1,TestSamNum);    % �����������ս��
a=postmnmx(NetworkOut,mint,maxt);               % ��ԭ���������Ľ��
x=1990:2009;                                        % ʱ����̶�
newk=a(1,:);                                        % ��������۸�
figure ;
subplot(2,1,1);plot(x,newk,'r-o')    %��ֵ��·�������Ա�ͼ��
legend('�������������','ʵ�ʿ�����');
xlabel('���');ylabel('������/����');
% ����ѵ���õ������������pnew����Ԥ��ʱ��ҲӦ����Ӧ�Ĵ���
lat1=input('������γ��');
lon1=input('�����뾭��');
pnew=[lat1 lon1];                     %2010���2011���������ݣ�
pnewn=tramnmx(pnew,minp,maxp);         %����ԭʼ�������ݵĹ�һ�������������ݽ��й�һ����
HiddenOut=logsig(W1*pnewn+repmat(B1,1,ForcastSamNum)); % ���������Ԥ����
anewn=W2*HiddenOut+repmat(B2,1,ForcastSamNum);           % ��������Ԥ����

%������Ԥ��õ������ݻ�ԭΪԭʼ����������
anew=postmnmx(anewn,mint,maxt)         
