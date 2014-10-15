function varargout = seg_Gui1(varargin)
% SEG_GUI1 MATLAB code for seg_Gui1.fig
%      SEG_GUI1, by itself, creates a new SEG_GUI1 or raises the existing
%      singleton*.
%
%      H = SEG_GUI1 returns the handle to a new SEG_GUI1 or the handle to
%      the existing singleton*.
%
%      SEG_GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEG_GUI1.M with the given input arguments.
%
%      SEG_GUI1('Property','Value',...) creates a new SEG_GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before seg_Gui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to seg_Gui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help seg_Gui1

% Last Modified by GUIDE v2.5 15-Oct-2014 16:33:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @seg_Gui1_OpeningFcn, ...
                   'gui_OutputFcn',  @seg_Gui1_OutputFcn, ...
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


% --- Executes just before seg_Gui1 is made visible.
function seg_Gui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to seg_Gui1 (see VARARGIN)

% Choose default command line output for seg_Gui1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes seg_Gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = seg_Gui1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_images.
function load_images_Callback(hObject, eventdata, handles)
% hObject    handle to load_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in start_segmentation.
function start_segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to start_segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in previous_image.
function previous_image_Callback(hObject, eventdata, handles)
% hObject    handle to previous_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in current_image.
function current_image_Callback(hObject, eventdata, handles)
% hObject    handle to current_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in next_image.
function next_image_Callback(hObject, eventdata, handles)
% hObject    handle to next_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
