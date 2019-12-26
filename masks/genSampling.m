function [minIntrVec,stat,actpctg] = genSampling(pdf,iter,tol)

%[mask,stat,N] = genSampling(pdf,iter,tol)
%
% a monte-carlo algorithm to generate a sampling pattern with 
% minimum peak interference. The number of samples will be
% sum(pdf) +- tol
%
%	pdf - probability density function to choose samples from
%	iter - number of tries
%	tol  - the deviation from the desired number of samples in samples
%
% returns:
%	mask - sampling pattern
%	stat - vector of min interferences measured each try
%	actpctg    - actual undersampling factor
%
%	(c) Michael Lustig 2007

h = waitbar(0);% waitbar���н�����ʾ��  �˳����������

pdf(find(pdf>1)) = 1;
K = sum(pdf(:));

minIntr = 1e99;
minIntrVec = zeros(size(pdf));

for n=1:iter
	tmp = zeros(size(pdf));
	while abs(sum(tmp(:)) - K) > tol
		tmp = rand(size(pdf))<pdf;
	end
	
	TMP = ifft2(tmp./pdf);
	if max(abs(TMP(2:end))) < minIntr
		minIntr = max(abs(TMP(2:end)));
		minIntrVec = tmp;
	end
	stat(n) = max(abs(TMP(2:end)));
	waitbar(n/iter,h);
end

actpctg = sum(minIntrVec(:))/prod(size(minIntrVec));

close(h);

%{
%% waitbar����   marryѧϰ
h=waitbar(x,'updated message'); ������ʾ������ hΪwaitbar���ɵľ�� x��0-1֮�䣬 0
���ȿ�ʼλ�ã������close(h)�رս�������ʾ

waitbar(x,h,'updated message'); % xΪ��ʾ�Ľ��ȣ�������0��1֮�䣻hΪ��������waitbar�ľ����updated messageΪʵʱ��ʾ����Ϣ������侭��������forѭ���� 
������ 
 steps=100;  hwait=waitbar(0,'��ȴ�>>>>>>>>'); 
for k=1:steps 
    if steps-k<=5 
        waitbar(k/steps,hwait,'�������'); %��Ϊk/steps�����������н������������ߣ����⣬������hwait�����ϵĻ�������ʾn������������ڣ�����رղ�������������֮���ֻ��ʾһ����
        pause(0.05); %��ʱһ�°� ����̫�쿴�������仯��һ���и�0.01���ܿ����仯�������ǱȽϿ�� 
    else  str=['����������',num2str(k),'%']; %������ʾ����ͼ�С�����������46%���ȱ�������
        waitbar(k/steps,hwait,str);  pause(0.05); %pause(n)�����ǳ���ֹͣn��������n����ʹ������С���������ķֱ��ʸ���ƽ̨�����������ƽ̨��������0.01��ľ��ȡ�
    end
end
close(hwait); % ע��������close������Ҳ����˵������ɺ��ô˽�������ʧ
%}
