function [y]=stat(Nam,type)
%�������ã�ͳ��txt�ı��е��ַ������ʣ�������
%Nam���ļ����ƣ�type��Ҫͳ�Ƶ��ַ�����(c:�ַ���w:���ʣ�p:����)
%�����ʽ����  stat('mytext1','p')
filename=strcat(Nam,'.txt')                                     %���� xx.txt ���ļ���
fd=fopen(filename,'r');                                         %��ֻ����ʽ���ļ�
m=fread(fd);                                                    %���ַ�ת����Ascall�뱣����m��
Num_c=length(m);                                                %�õ�m�ĳ��ȣ����ַ���
Num_w=0;                                                        %��ʼ��
Num_p=0;
for i=1:Num_c                                                   %ѭ��c�Σ�i�ӵ�һ���ַ���ʼ
    if m(i)==32||m(i)==46||m(i)==33||m(i)==63 &&i~=Num_c        %���ַ�Ϊ�ո񡢾�š���̾�š��ʺ��Ҳ�����ĩʱ
            Num_w=Num_w+1;                                      %������+1
        end
   
    if m(i)==46||m(i)==33||m(i)==63                             %��Ϊ��š���̾�š��ʺ�ʱ
                    Num_p=Num_p+1;                              %������+1
        end
end 
switch type                                                     %���ֱ�����'c'��w����'p'ʱ
    case 'c'                                                    %����y �ַ� ���� ���� ��
        y=Num_c;
    case 'w'
        y=Num_w;
    case 'p'
        y=Num_p;
end