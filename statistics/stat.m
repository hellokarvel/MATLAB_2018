function [y]=stat(Nam,type)
%函数作用：统计txt文本中的字符，单词，句子数
%Nam：文件名称；type需要统计的字符类型(c:字符；w:单词；p:句子)
%输入格式例如  stat('mytext1','p')
filename=strcat(Nam,'.txt')                                     %生成 xx.txt 的文件名
fd=fopen(filename,'r');                                         %已只读形式打开文件
m=fread(fd);                                                    %将字符转换成Ascall码保存在m中
Num_c=length(m);                                                %得到m的长度，即字符数
Num_w=0;                                                        %初始化
Num_p=0;
for i=1:Num_c                                                   %循环c次，i从第一个字符开始
    if m(i)==32||m(i)==46||m(i)==33||m(i)==63 &&i~=Num_c        %当字符为空格、句号、感叹号、问号且不是文末时
            Num_w=Num_w+1;                                      %单词数+1
        end
   
    if m(i)==46||m(i)==33||m(i)==63                             %当为句号、感叹号、问号时
                    Num_p=Num_p+1;                              %句子数+1
        end
end 
switch type                                                     %当分别输入'c'或‘w’或'p'时
    case 'c'                                                    %赋予y 字符 单词 句子 数
        y=Num_c;
    case 'w'
        y=Num_w;
    case 'p'
        y=Num_p;
end