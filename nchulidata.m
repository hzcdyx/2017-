a=xlsread('I:\��ѧ��ģ������\fujian1.xls');
b=xlsread('I:\��ѧ��ģ������\fujian2.xls');
c=b(:,1);
d=b(:,2);
e=(1:1877);
count=zeros(1,8);
di=zeros(1877,1);
dis=zeros(1877,1);
%lat=input('������γ��');
%lon=input('�����뾭��');
la=xlsread('I:\��ѧ��ģ������\learndata.xls');
lt=xlsread('I:\��ѧ��ģ������\learndata2.xls');
pr=la(:,3);
pr2=lt(:,3);
y=[pr2;pr];
nlat=la(:,1);
nlon=la(:,2);
lat=nlat;
lon=nlon;
R=24;
for j=1:49
    count=zeros(1,8);
    count(1,6)=y(j+50,1);
    count(1,7)=lat(j,1);
    count(1,8)=lon(j,1);
for i=1:1877
    
    di(i,1)=sin(lat(j,1))*sin(c(i,1))*(lon(j,1)-d(i,1))+cos(lat(j,1))*cos(c(i,1));
    dis=acos(di)*pi/180*6371;
    if dis(i,1)<=R/5
       count(1,1)=count(1,1)+1 ;
    end
    if dis(i,1)<=R/5*2 &&dis(i,1)>R/5
       count(1,2)=count(1,2)+1 ;
    end
     if dis(i,1)<=R/5*3 &&dis(i,1)>R/5*2
       count(1,3)=count(1,3)+1 ;
     end
     if dis(i,1)<=R/5*4 &&dis(i,1)>R/5*3
       count(1,4)=count(1,4)+1 ;
     end
     if dis(i,1)<=R &&dis(i,1)>R/5*4
       count(1,5)=count(1,5)+1 ;
     end
end
    dlmwrite('I:\��ѧ��ģ������\data1.txt',count,'delimiter','\t','newline','pc','-append')
end