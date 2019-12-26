%-`mask_random.m`���������������ģ�塣 genPDF.m��gengenSampling.m��mask_random.m�������̣�©2007 Michael Lustig���� ����ѡ��ģ���С�������뾶�Ͳ����ʡ�
%~~~~���ܶ��������ģ�� ���ɳ���  ���������ӳ���
clc;close all;clear all;
M=256;
N=256;
imSize=[M,N];
p=150;
pctg=0.3;  %������0.3 ��SRΪ0.3
distType=2;
radius=0.05;
disp=0;  %disp=0��1  ��ʾ�Ƿ���ʾ�ӳ���genPDF�е�ͼ

%genPDF(imSize,p,pctg,distType,radius,disp) pctg:�����ʣ�radius:���Ĳ����뾶 %p:power of polynomial.
% distType:1 or 2 for L1 or L2 distance measure
pdf = genPDF(imSize,p,pctg,distType,radius,disp); %���ɲ��������ܶȺ�����pdf��
      %(generates a pdf for a 1d or 2d random sampling pattern with polynomial variable density sampling)  
Umask = genSampling(pdf,10,60);  %���ܶ��������ģ��

%genSampling(pdf,iter,tol) 
%pdf - probability density function to choose samples from
%	iter - number of tries
%	tol  - the deviation from the desired number of samples in samples

% disp('������������������')
SR = sum(sum(Umask))/(M*N)
 
figure
imshow(Umask)

save Umask_random_110_01
