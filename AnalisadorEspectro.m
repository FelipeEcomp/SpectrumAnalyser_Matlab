function varargout = AnalisadorEspectro(varargin)
% ANALISADORESPECTRO M-file for AnalisadorEspectro.fig
%      ANALISADORESPECTRO, by itself, creates a new ANALISADORESPECTRO or raises the existing
%      singleton*.
%
%      H = ANALISADORESPECTRO returns the handle to a new ANALISADORESPECTRO or the handle to
%      the existing singleton*.
%
%      ANALISADORESPECTRO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALISADORESPECTRO.M with the given input arguments.
%
%      ANALISADORESPECTRO('Property','Value',...) creates a new ANALISADORESPECTRO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalisadorEspectro_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalisadorEspectro_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalisadorEspectro

% Last Modified by GUIDE v2.5 20-Dec-2011 04:44:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalisadorEspectro_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalisadorEspectro_OutputFcn, ...
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
clc, clear all
% End initialization code - DO NOT EDIT
end

% --- Executes just before AnalisadorEspectro is made visible.
function AnalisadorEspectro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalisadorEspectro (see VARARGIN)

% Choose default command line output for AnalisadorEspectro
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnalisadorEspectro wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = AnalisadorEspectro_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
set(handles.axes1,'XLim',[0 4000]);
set(handles.axes1,'YLim',[0 100]);
end

% --- Executes on button press in comecar.
function comecar_Callback(hObject, eventdata, handles)
% hObject    handle to comecar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla; %limpa o grafico axes

fs = 8000;
fslido = fs*0.1;          %um decimo de segundo
nadas = zeros(fs-fslido,1); %soma nao funciona se nao ter o mesmo numero 
                          %de posicoes. (fs*0.5) pois é o tempo de 0.5 seg.

x = str2num(get(handles.tempomax,'String')); 
while x ~= 1
    audio1 = wavrecord(fslido,fs,1); %Grava fslido amostras a frequencia fs
    espectro = fft([audio1;nadas]);
                                     %A fft é somete das amostras lidas
    axes(handles.axes1);             %Imprimir na mesma figura
    i = 1*abs(espectro);             %
    plot(i(1:4000,1));               %Expectro de todo audio
    axis([1 4000 0 100]), xlabel('Frequência'), ylabel ('Amplitude')
    
    x = str2num(get(handles.tempomax,'String')); 
    
end
set(handles.tempomax,'String','1000');
end

% --- Executes on button press in parar1.
function parar1_Callback(hObject, eventdata, handles)
% hObject    handle to parar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.tempomax,'String','1');
end

% --- Executes on button press in iniciar1.
function iniciar1_Callback(hObject, eventdata, handles)
% hObject    handle to iniciar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.iniciar1,'Visible','off');
set(handles.text1,'Visible','off');
set(handles.text2,'Visible','off');
set(handles.text3,'Visible','off');
set(handles.text3,'Visible','off');
set(handles.text4,'Visible','off');
set(handles.text5,'Visible','off');
set(handles.comecar,'Visible','on');
set(handles.parar1,'Visible','on');
set(handles.axes1,'Visible','on');
end


function tempomax_Callback(hObject, eventdata, handles)
% hObject    handle to tempomax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tempomax as text
%        str2double(get(hObject,'String')) returns contents of tempomax as a double
end

% --- Executes during object creation, after setting all properties.
function tempomax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tempomax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

