function varargout = gui1(varargin)
% GUI1 MATLAB code for gui1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui1

% Last Modified by GUIDE v2.5 13-Oct-2014 12:22:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui1_OutputFcn, ...
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
end

% --- Executes just before gui1 is made visible.
function gui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui1 (see VARARGIN)

% Choose default command line output for gui1
handles.output = hObject;
handles.ImgIdx =0;
handles.FLAG = true;
handles.ImgNum=0;
handles.filename={};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = gui1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end

% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname,~]=uploadimage(hObject, eventdata, handles);
files={};

if isnumeric(filename)
    return;
else
    if iscell(filename)
        ImgNum=length(filename);
        for i=1:ImgNum
            files{i}=[pathname filename{i}];
        end        
    else
        ImgNum=1;
        files{1}=[pathname filename];
    end
end

handles.ImgIdx=0;
handles.ImgNum=ImgNum;
handles.filename=files;
handles.Seeds=cell(ImgNum,1);
handles.Seeds_num=zeros(ImgNum,1);
handles.marks=cell(ImgNum,1);

set(handles.Current_Image_index,'string',num2str(handles.ImgIdx));
set(handles.next_image,'Enable','Off');
set(handles.current_image,'Enable','off');
set(handles.previous_image,'Enable','off');
set(handles.next_image,'String','First');
set(handles.next_image,'Enable','on');
%set(handles.text1,'String',['Processing Image ', num2str(handles.ImgIdx), '/', num2str(handles.ImgNum)]);
guidata(hObject, handles);
end

% --- Executes on button press in start_segementation.
function start_segementation_Callback(hObject, eventdata, handles)
% hObject    handle to start_segementation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in previous_image.
function previous_image_Callback(hObject, eventdata, handles)
% hObject    handle to previous_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  if handles.ImgIdx>=1 && handles.ImgIdx<=handles.ImgNum
    handles.ImgIdx=handles.ImgIdx-1;
    set(handles.Current_Image_index,'string',num2str(handles.ImgIdx));
   guidata(hObject,handles);
  end
  if handles.ImgIdx==1 || handles.ImgIdx==0
    set(handles.previous_image,'Enable','Off');
  end
  if handles.ImgIdx<=handles.ImgNum
    set(handles.next_image,'Enable','On');	
  end
end

% --- Executes on button press in current_image.
function current_image_Callback(hObject, eventdata, handles)
% hObject    handle to current_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% previous和next按钮可以被使用以调整当前处理的图片的index，将想要处理的图片调整到当前ImgIdx
% 对应的时候，使用current函数，创建image对象，并且对当前对象进行选点。
if handles.ImgIdx>0 && handles.ImgIdx<=handles.ImgNum
%imshow(handles.filename{handles.ImgIdx}); %这个语句是用来调试的，最开始没有选点的功能，按按钮的时候触发的函数是显示图片函数；
%下面创建并显示图形对象
imObj=imread(handles.filename{handles.ImgIdx});
figure;
imageHandle=imshow(imObj);
%current_handles={};
%current_handles.pos=handles.Seeds{handles.ImgIdx}; 
%current_handles.num=size(pos,2);
%current_handles.marks=[];  
%下面在图形对象上对已经被选过的点进行显示；每次使用current按钮打开这个图像的时候都这样显示，以便调整选点组
previous_pos=handles.Seeds{handles.ImgIdx}; 
for i=1:handles.Seeds_num(handles.ImgIdx)
    current_point=previous_pos(:,i);
    current_mark=drawCircle(current_point(1),current_point(2),20,handles,hObject);
    handles.marks{handles.ImgIdx}(i)=current_mark;
    guidata(hObject,handles);
end
%下面使用select_seeds_single_image函数进行选点，然后更新整个handles中的数据；
handles.Seeds{handles.ImgIdx}=select_seeds_single_image(hObject,eventdata,handles,imageHandle);
handles.Seeds_num(handles.ImgIdx)=size(handles.Seeds{handles.ImgIdx},2);
guidata(hObject,handles);%Very important sentence, by using this, data in handles can be updated
end
end

% --- Executes on button press in next_image.
function next_image_Callback(hObject, eventdata, handles)
% hObject    handle to next_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  handles.ImgNum==0
    msgbox('You have not chosen any train images yet!','Warning')
end
if handles.ImgIdx>=handles.ImgNum 
     msgbox('You have reached the last image!!','Warning')
elseif handles.ImgIdx>=0  
        handles.ImgIdx=handles.ImgIdx+1;
        set(handles.Current_Image_index,'string',num2str(handles.ImgIdx));
	   guidata(hObject, handles);
        set(handles.current_image,'Enable','On');
  
end
        if  handles.ImgIdx>1
            set(handles.previous_image,'Enable','On');
        end

        if handles.ImgIdx>0    
        set(handles.next_image,'String','Next');
        end
        if  handles.ImgIdx>=handles.ImgNum
              set(handles.next_image,'Enable','Off');
        %         msgbox('You have reached the first image!','Warning')
        end
end

function [filename, pathname,FilterIndex] =uploadimage(hObject, eventdata, handles)
[filename, pathname,FilterIndex] = uigetfile( ...
    {'*.png;*.jpg;*.jpeg;*.jpe;*.jfif;*.tif;*.tiff;*.bmp;*.dib;*.gif','Input Images(*.png,*.jpg,*.jpeg,*.tif,*.bmp,*.gif)';
    '*.png',  'PNG (*.png)'; ...
    '*.jpg;*.jpeg;*.jpe;*.jfif','JPEG (*.jpg,*.jpeg,*.jpe,*.jfif)'; ...
    '*.tif;*.tiff','TIFF (*.tif,*.tiff)'; ...
    '*.bmp;*.dib','Bitmap Files (*.bmp,*.dib)'; ...
    '*.gif','GIF(*.gif)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'MultiSelect', 'on', ...
    'Choose Training Images');
guidata(hObject, handles);
end


function [pos]=select_seeds_single_image(hObject, evendata, handles,imageHandle)
% 这两行从handles中获取当前图像已经有的记录；
pos=handles.Seeds{handles.ImgIdx}; 
marks=handles.marks{handles.ImgIdx};
% 使用键盘事件决定对当前对象的选点是否终止
KEY_IS_PRESSED=0;
while KEY_IS_PRESSED==0
     KEY_IS_PRESSED= waitforbuttonpress;
     if KEY_IS_PRESSED==1
     close;
     return;
     else
    % 利用ImageClickCallback进行选点，然后对得到的点是否符合要求进行判断；
    % 根据不同的判断结果进行不同的对handles的更新：
    % 如果是新选的点，则添加到handles的当前对象对应的选点列表中；
    % 如果判断为是已经存在的点，则从handles的当前对象对应的选点列表中删除这个点；
     [current_point,flag,current_mark]=ImageClickCallback(imageHandle, 'ButtonDownFcn',handles,hObject);
        if flag==1
          % handles.Seeds_num(handles.ImgIdx)=handles.Seeds_num(handles.ImgIdx)+1;
           pos=[pos,current_point];
           handles.Seeds{handles.ImgIdx}=pos;
           marks=[marks,current_mark];
           handles.marks{handles.ImgIdx}=marks;
          %handels.Seeds_num(handles.ImgIdx)=size(pos,2);
           guidata(hObject,handles);
        elseif flag==-1
           % handles.Seeds_num(handles.ImgIdx)=handles.Seeds_num(handles.ImgIdx)-1;
             pos_x=pos(1,:);
             pos_y=pos(2,:);
             radius = 20;
           for ind = 1:handles.Seeds_num(handles.ImgIdx)
              distance = sqrt(((pos_x(ind)-current_point(1))^2)+((pos_y(ind)-current_point(2))^2));
              if(distance < radius)
              handles.marks{handles.ImgIdx}(ind) =[];
              pos(:,ind)=[];
              handles.Seeds{handles.ImgIdx}=pos;
              %handels.Seeds_num(handles.ImgIdx)=size(pos,2);failed
              %assigment sentence
              guidata(hObject,handles);
              end
            end
        end
     end
end
end
function [doesExist] = checkExistence(x,y,handles,hObject)
if (size(handles.Seeds{handles.ImgIdx},2)>0)
    mouse_x=handles.Seeds{handles.ImgIdx}(1,:);
    mouse_y=handles.Seeds{handles.ImgIdx}(2,:);
    doesExist=0;
    for ind = 1: size(handles.Seeds{handles.ImgIdx},2)
        radius = 20;
        distance = sqrt(((mouse_x(ind)-x)^2)+((mouse_y(ind)-y)^2));
        if(distance < radius)
            hold on
%             plot(mouse_x(ind), mouse_y(ind),'r*')
                set(handles.marks{handles.ImgIdx}(ind),'Visible','off')
            hold off
            %handles.marks{handles.ImgIdx}(ind) =[];
            doesExist  = 1; 
            %handles.Seeds{handles.ImgIdx}(:,ind)=[];
            guidata(hObject,handles);
            return;
        end
    end
else
    doesExist = 0;
end
end

function [current_mark]=drawCircle(centx,centy,r,handles,hObject)
hold on;
% r = 20;
theta = 0 : (2 * pi / 10000) : (2 * pi);
pline_x = r * cos(theta) + centx;
pline_y = r * sin(theta) + centy;
%k = ishold;
current_mark = plot(pline_x, pline_y, '-');
set(current_mark, 'LineWidth',2)
guidata(hObject,handles);
hold off;
end

function [point,flag,current_mark]=ImageClickCallback (imageHandle , eventData,handles,hObject)
axesHandle  = get(imageHandle,'Parent');
coordinates = get(axesHandle,'CurrentPoint'); 
coordinates = coordinates(1,1:2);
if(~checkExistence(coordinates(1),coordinates(2),handles,hObject))
    %handles.Seeds_num(handles.ImgIdx) = handles.Seeds_num(handles.ImgIdx)+1;
    current_mark=drawCircle(coordinates(1), coordinates(2), 20,handles,hObject);
    guidata(hObject,handles);
    point=[coordinates(1);coordinates(2)];
    flag=1;
else
    current_mark=[];
    point=[coordinates(1);coordinates(2)];
    flag=-1;
end
end