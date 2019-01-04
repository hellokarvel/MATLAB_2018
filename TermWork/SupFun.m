function varargout = SupFun(varargin)
% SUPFUN MATLAB code for SupFun.fig
%      SUPFUN, by itself, creates a new SUPFUN or raises the existing
%      singleton*.
%
%      H = SUPFUN returns the handle to a new SUPFUN or the handle to
%      the existing singleton*.
%
%      SUPFUN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUPFUN.M with the given input arguments.
%
%      SUPFUN('Property','Value',...) creates a new SUPFUN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SupFun_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SupFun_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SupFun

% Last Modified by GUIDE v2.5 01-Jan-2019 20:22:45

% Begin initialization code - DO NOT EDIT

gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SupFun_OpeningFcn, ...
                   'gui_OutputFcn',  @SupFun_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SupFun is made visible.
function SupFun_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SupFun (see VARARGIN)

% Choose default command line output for SupFun
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

str='非线性方程求根 ';
set(handles.edit2,'string',str);
str2='屠嘉骏';
set(handles.edit3,'string',str2);


axes(handles.axes1)
f=@(x,y,z)(x.^2+ (9./4).*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (9./80).*y.^2.*z.^3;
[x,y,z]=meshgrid(linspace(-3,3));
val=f(x,y,z);
[p,v]=isosurface(x,y,z,val,0);
patch('faces',p,'vertices',v,'facevertexcdata',jet(size(v,1)),'facecolor','w','edgecolor','flat');
axis equal;
axis off
view(-10,24);
colormap([1 0.2 0.2]);



% UIWAIT makes SupFun wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SupFun_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes2) ;cla reset;
str='二分法求根演示';
set(handles.edit2,'string',str);


str1 = ['每次迭代用3个点划分两个区间', 10]; 
str2 = ['根据判断条件决定下一次迭代是往两个区间的哪一个进行', 10];
str3 = ['以左端点函数值为参考，此题为正', 10];
str4 = ['若函数值为负，迭代将往左进行，反之则为右'];
str = [str1,str2,str3,str4];
set(handles.edit4,'string',str);

fun='sin(2*x-0.1)+0.3';  %演示脚本   即便是任意取一点 多次迭代后也能取到点
xa=-5;xb=5;
x=xa;fa=eval(fun);
x=xb;fb=eval(fun);
delta=0.01;
n=50;

axes(handles.axes2)

fplot(fun,[xa-1,xb+1])
hold on;
fplot('0',[xa-1,xb+1])%画X轴
text(-5.9,-0.48,'y=sin(2*x-0.1)+0.3','FontSize',18);
text(-5.9,-0.6,'区间为[-5,5]','FontSize',18);

 plot([xa,xa],[0,fa],'LineWidth',2);
 
 text(xa,0.8*fa,strcat('左端点(参考点，正)'),'Color','r','FontSize',18);
 plot(xa,fa,'b.','MarkerSize',40);
 text(xa,fa,strcat('(-5,',num2str(fa),')'),'Color','b','FontSize',18);
 e1=plot([xb,xb],[0,fb],'LineWidth',2);
 e2=text(xb,0.8*fb,strcat('右端点'),'FontSize',18);
 pause(3);

for i=1:20
        xc=(xa+xb)/2;  
        x=xc;fc=eval(fun); 
     
        
        pi(i)=plot([xc,xc],[0,fc],'LineWidth',5);
        
        Tex(i)=text(xc,0.8*fc,strcat('  第',num2str(i),'次迭代'),'FontSize',24);
        
        str1 = [strcat('第',num2str(i),'次迭代的函数值为',num2str(fc)) ,10];
        if 0<fc p='正';q='右';
        else p='负';q='左';
        end
        str2 =[strcat('函数值为',p,',下次迭代将往',q,'进行')];
        st = [str1,str2];
        set(handles.edit1,'string',st);
        pause(5);      
       if 1<i  set(e1,'visible','off');
         set(e2,'visible','off');end
         if 2<i set(Tex(i-2),'visible','off');
                set(pi(i-2),'visible','off');
                
         end
        if fc*fa<0
             xb=xc;
        else xa=xc;
        end
          if  -0.012<fc&&fc<0.012   
                 text(xc,-0.1,['(',num2str(xc),',',num2str(0),')']);%标记
                end
        if (xb-xa)<delta,break
        end
end
%figure(2);
 %movie(fmat,1,0.6);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

st='Xk+1=Xk-(Xk-Xk-1)*f(k)/(f(k)-f(k-1))';
set(handles.edit1,'string',st);
axes(handles.axes2) ;cla reset;
str='弦截法求根演示';
set(handles.edit2,'string',str);
text(-1,-0.48,'y=log(x)+x-2','FontSize',18);
k=1;
fun=inline('[log(x)+x-2,1/x+1]');
x=1.2;f=feval(fun,x);
f='log(x)+x-2';  %演示脚本   即便是任意取一点 多次迭代后也能取到点
xa=0.1;xb=2;
x=xa;fa=eval(f);
x=xb;fb=eval(f);
%f=@(x) log(x)+x-2;
y='log(x)+x-2';
fplot(y,[-0.5,3]);
hold on;
fplot('0',[-0.5,3]);
tol=1e-4;
a=0.1;b=2;
  plot([a,a],[0,fa],'LineWidth',4);
  plot([b,b],[0,fb],'LineWidth',4);
  plot(a,0,'r.','MarkerSize',40);
  plot(b,0,'r.','MarkerSize',40);
text(a-0.05,fa,strcat('[0.1,',num2str(fa),']'),'FontSize',28,'Color','r');
text(b+0.05,fb+0.3,strcat('[2,',num2str(fb),']'),'FontSize',28,'Color','r');
t=-0.5:0.1:2;
x=0.1;
while k<6
x1=x;
f=feval(fun,x);
x=x-f(1)/f(2);
y=f(2)*(t-x1)+f(1);
    plot(t,y);
    plot(x1,f(1),'r.','MarkerSize',30);
if 1<k text(x1,f(1)-0.2*k,strcat('第',num2str(k-1),'次迭代'),'FontSize',15);
       text(x1,f(1)-0.7*k,strcat('(',num2str(x1),',',num2str(f(1)),')'),'FontSize',15);
end

    pause(2);
    if abs(x-x1)<0.0001
        index=1;break;
    end
    k=k+1;
end



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2) ;cla reset;
f='exp(x)-0.3';  %演示脚本   即便是任意取一点 多次迭代后也能取到点
xa=0;xb=2;
x=xa;fa=eval(f);
x=xb;fb=eval(f);
axes(handles.axes2)
fplot(f,[-2,xb]);
hold on;
fplot('0',[-2,xb+1])%画X轴
%text(-5.9,-0.48,'y=sin(2*x-0.1)+0.3','FontSize',18);

st='X(i+1)=Xi-f(i)/f''(i)';

set(handles.edit1,'string',st);

fun=inline('[exp(x)-0.3,exp(x)]');
x=1.2;f=feval(fun,x);
plot(x,f(1),'r.','MarkerSize',40);
text(x,f(1),strcat('初始点',num2str(f(1)),num2str(f(1)),')'),'FontSize',18);
text(-1.8,6.5,'y=exp(x)-0.3','FontSize',18);
text(-1.8,5.7,'初始点x=1.2','FontSize',18);
it_max=100;                           
ep=1e-5;
index=0;
k=1;
t=-1:0.2:2
while k<6
x1=x;
f=feval(fun,x);

x=x-f(1)/f(2);
y=f(2)*(t-x1)+f(1);
    plot(t,y);
    plot(x1,f(1),'r.','MarkerSize',40);
if 1<k text(x1,f(1)-0.3*k,strcat('第',num2str(k-1),'次迭代'),'FontSize',18);
       text(x1,f(1)-0.6*k,strcat('(',num2str(x1),',',num2str(f(1)),')'),'FontSize',18);
end

    pause(2);
    if abs(x-x1)<ep
        index=1;break;
    end
    k=k+1;
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.





function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2) ;cla reset;

str='二分法多区间求根演示';
set(handles.edit2,'string',str);
fun='sin(3*x-0.1)+0.3'; 
a=get(handles.edit5,'String');
N=str2num(a);
Xl=-5;Xr=5; 

delta=0.008;%delta 为允许误差
%————————————————————————————————
axes(handles.axes2);
x=Xl;fa=eval(fun);
x=Xr;fb=eval(fun);
fplot(fun,[Xl-1,Xr+1]);
hold on
fplot('0',[Xl-1,Xr+1])
text(-5.9,-0.48,fun,'FontSize',18);
text(-5.9,-0.6,'区间为[-5,5]','FontSize',18);
 %中点的x值
 %fc 终点处的函数值
 d=(Xr-Xl)/N;
 for i=1:N+1
     x=Xl+(i-1)*d;fa1=eval(fun);
      plot([x,x],[0,fa1],'LineWidth',4);
      hold on;
 end
 pause(3);
 for z=1:N
    xa=Xl+(z-1)*d;x=xa;fa=eval(fun);
    xb=Xl+z*d;
    for i=1:10
        xc=(xa+xb)/2;
        x=xc;fc=eval(fun);
        pi(i)=plot([xc,xc],[0,fc],'LineWidth',3);%求解y=fun(xc)
        pause(0.3);
         % Tex(i)=text(xc,0.8*fc,strcat('  第',num2str(i),'次迭代'),'FontSize',24);
       %x=xa; fa=eval(fun);   %有没有都求得出
    
            if fa*fc<0
                 xb=xc;
            else xa=xc;
            end

           if 2<i %set(Tex(i-2),'visible','off');
                set(pi(i-2),'visible','off');end

             if  -0.012<fc&&fc<0.012   
                 text(xc,-0.1,['(',num2str(xc),',',num2str(0),')']);%标记
                end
            if (xb-xa)<delta,break
            end
    end
   
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
