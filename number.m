lat=input('������γ��');
lon=input('�����뾭��');
b=xlsread('I:\��ѧ��ģ������\fujian2.xls');
c=b(:,1);
d=b(:,2);
R=24;
di=zeros(1877,1);
dis=zeros(1877,1);
count=zeros(1,5);
for i=1:1877
    di(i,1)=sin(lat)*sin(c(i,1))*(lon-d(i,1))+cos(lat)*cos(c(i,1));
    dis=acos(di)*pi/180*6371;
    if dis(i,1)<=R/5
       count(1,1)=count(1,1)+1;
    end
    if dis(i,1)<=R/5*2 &&dis(i,1)>R/5
      count(1,2)=count(1,2)+1;
    end
     if dis(i,1)<=R/5*3 &&dis(i,1)>R/5*2
       count(1,3)=count(1,3)+1;
     end
     if dis(i,1)<=R/5*4 &&dis(i,1)>R/5*3
       count(1,4)=count(1,4)+1 ;
     end
     if dis(i,1)<=R &&dis(i,1)>R/5*4
       count(1,5)=count(1,5)+1 ;
     end
      dlmwrite('I:\��ѧ��ģ������\������\count123.txt',count,'delimiter','\t','newline','pc','-append')
end


