function varargout = newton_GUI(varargin)
% NEWTON_GUI MATLAB code for newton_GUI.fig
%      NEWTON_GUI, by itself, creates a new NEWTON_GUI or raises the existing
%      singleton*.
%
%      H = NEWTON_GUI returns the handle to a new NEWTON_GUI or the handle to
%      the existing singleton*.
%
%      NEWTON_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWTON_GUI.M with the given input arguments.
%
%      NEWTON_GUI('Property','Value',...) creates a new NEWTON_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newton_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newton_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newton_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @newton_GUI_OutputFcn, ...
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


function newton_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);



function varargout = newton_GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;




function funkcja_edit_Callback(hObject, eventdata, handles)

function funkcja_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function licz_button_Callback(hObject, eventdata, handles)

syms x
t0 = str2double(get(handles.x0_edit,'String'));
dok = str2double(get(handles.dok_edit,'String'));
f = get(handles.funkcja_edit,'String');
f = sym(f);
f_prim = diff(f);
f = @(x)eval(f);
f_prim = @(x)eval(f_prim);

%Algorytm Newtona
t = t0;
tvals = t0;
nmax = 25;                                       
d = 1;                                         
n = 0;                                           
while (d >= dok)&(n <= nmax)                        
    y=t-f(t)/f_prim(t); 
    tvals=[tvals;y];                           
    d=abs(y-t);                             
    t=y;
    n=n+1;                                  
end        
t_max = 1.5*tvals(end)+tvals(end);
t_min = tvals(end)-1.5*tvals(end);
t = linspace(t_min,t_max,100);
plot(t,f(t),'b');
grid on
hold on
a = f_prim(tvals);
b = f(tvals)-a.*tvals;
for i=1:n
    y = a(i)*t+b(i);
    plot(t,y,'r');
end
plot(tvals(n), 0, 's')
ylim([min(f(t)), max(f(t))])
hold off    
set(handles.wynik_edit,'String',num2str(tvals(end)));

function dok_edit_Callback(hObject, eventdata, handles)

function dok_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x0_edit_Callback(hObject, eventdata, handles)

function x0_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wynik_edit_Callback(hObject, eventdata, handles)

function wynik_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
