function varargout = SRM_challenge_07(varargin)
% SRM_challenge_07 M-file for SRM_challenge_07.fig
%
%      to run this programm: >SRM_challenge_07
%
%      SRM_challenge_07, by itself, creates a new SRM_challenge_07 or raises the existing
%      singleton*.
%
%      H = SRM_challenge_07 returns the handle to a new SRM_challenge_07 or the handle to
%      the existing singleton*.
%
%      SRM_challenge_07('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRM_challenge_07.M with the given input arguments.
%
%      SRM_challenge_07('Property','Value',...) creates a new SRM_challenge_07 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SRM_challenge_07_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SRM_challenge_07_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Last Modified by GUIDE v2.5 04-Mar-2008 12:31:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SRM_challenge_07_OpeningFcn, ...
                   'gui_OutputFcn',  @SRM_challenge_07_OutputFcn, ...
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

% Author: Skander Mensi, LCN, epfl. (skander.mensi@gmail.com)

% --- Executes just before SRM_challenge_07 is made visible.
function SRM_challenge_07_OpeningFcn(hObject, eventdata, handles, varargin)

%------Load data of Challenge A---------%
%handles.data = load('modeldB_data.mat');
handles.data = load_data();

handles.filter = handles.data.filter.fifi;
handles.a = handles.data.filter.a;
handles.b = handles.data.filter.b;
handles.c = handles.data.filter.c;
handles.d = handles.data.filter.d;

handles.eta = handles.data.ETA;
handles.cst_threshold = handles.data.cst_threshold;
handles.exp1_threshold = handles.data.exp1_threshold;

handles.I = [];
handles.V = [];
handles.spiketimes = [];
handles.mean = [];
handles.std = [];
handles.int_coinc = [];

handles.SRM_output = [];
handles.SRM_input = [];
%---------------------------------------%

%------Initialize Edit_text zone--------%
set(handles.mean_I_edit_text,'String','----');
set(handles.std_I_edit_text,'String','----');
set(handles.SRM_coincidence_edit_text,'String','----');
set(handles.intrinsic_coincidence_edit_text,'String','----');
set(handles.raw_coincidence_edit_text,'String','----');
set(handles.threshold_equation_edit_text,'String','----');
set(handles.theta_0_edit_text,'String','----');
set(handles.theta_1_edit_text,'String','----');
set(handles.tau_theta_1_edit_text,'String','----');
%---------------------------------------%

%--------Initialize Slider--------------%
set(handles.tau_kappa_slider,'Value',-1/handles.data.filter.b);
set(handles.tau_2_kappa_slider,'Value',-1/handles.data.filter.d);
set(handles.theta_0_slider,'Value',get(handles.theta_0_slider,'Min'));
set(handles.theta_1_slider,'Value',get(handles.theta_1_slider,'Min'));
set(handles.tau_theta_1_slider,'Value',get(handles.tau_theta_1_slider,'Min'));
%---------------------------------------%

%-------Initialize Axes-----------------%
handles.temp = 0:0.2:(120-1)*0.2;
axes(handles.eta_axes);
plot(handles.temp, handles.data.ETA(1:120));
xlabel('time [ms]');
ylabel('Eta [mV]');
axis tight;

handles.temp = 0:0.2:(length(handles.data.filter.fifi)-1)*0.2;
axes(handles.kappa_axes);
plot(handles.temp, handles.data.filter.fifi);
xlabel('time [ms]');
ylabel('kappa [mV]');
axis tight;
%---------------------------------------%

% Choose default command line output for SRM_challenge_07
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = SRM_challenge_07_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%--------------------------------DEBUT------------------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
function load_data_popup_Callback(hObject, eventdata, handles)

val = get(hObject, 'Value')-1;

if (val==0)
    axes(handles.current_axes);
    cla;
    axes(handles.SRM_axes);
    cla;
    set(handles.mean_I_edit_text,'String','----');
    set(handles.std_I_edit_text,'String','----');
    set(handles.SRM_coincidence_edit_text,'String','----');
    set(handles.intrinsic_coincidence_edit_text,'String','----');
    set(handles.raw_coincidence_edit_text,'String','----');
    set(handles.tau_kappa_slider,'Value',-1/handles.data.filter.b);
    set(handles.tau_2_kappa_slider,'Value',-1/handles.data.filter.d);
    handles.temp = 0:0.2:(length(handles.data.filter.fifi)-1)*0.2;
    axes(handles.kappa_axes);
    plot(handles.temp, handles.data.filter.fifi);
    xlabel('time [ms]');
    ylabel('kappa [mV]');
    axis tight;
else

    handles.I = handles.data.data{val}.I;
    handles.V = handles.data.data{val}.V;
    handles.spiketimes = handles.data.data{val}.spiketimes;
    handles.mean = handles.data.data{val}.mean;
    handles.std = handles.data.data{val}.std;
    handles.int_coinc = handles.data.data{val}.int_coinc;
    
    set(handles.mean_I_edit_text,'String',num2str(handles.mean));
    set(handles.std_I_edit_text,'String',num2str(handles.std));
    set(handles.intrinsic_coincidence_edit_text,'String',num2str(handles.int_coinc));

    handles.temp = 0:0.2:(length(handles.I)-1)*0.2;
    axes(handles.current_axes);
    cla;
    plot(handles.temp, handles.I);
    xlabel('time [ms]');
    ylabel('current [pA]');
    axis tight;

    handles.temp = 0:0.2:(length(handles.V)-1)*0.2;
    axes(handles.SRM_axes);
    cla;
    hold on;
    plot(handles.temp, handles.V);
    xlabel('time [ms]');
    ylabel('membrane potential [mV]');
    axis tight;
end

guidata(hObject, handles);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
function tau_kappa_slider_Callback(hObject, eventdata, handles)

if((get(handles.tau_kappa_slider,'Value'))==0)
    handles.b = -1/0.00000000000000001;
else
    handles.b = (-1/(get(handles.tau_kappa_slider,'Value')));
end
temp = 0:length(handles.data.filter.fifi)-1;

handles.filter = handles.a * exp(handles.b*temp) + handles.c * exp(handles.d*temp);

handles.temp = 0:0.2:(length(handles.filter)-1)*0.2;
axes(handles.kappa_axes);
cla;
plot(handles.temp, handles.filter);
xlabel('time [ms]');
ylabel('kappa [mV]');
axis tight;

guidata(hObject, handles);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
function tau_2_kappa_slider_Callback(hObject, eventdata, handles)


if((get(handles.tau_2_kappa_slider,'Value'))==0)
    handles.d = -1/0.00000000000000001;
else
    handles.d = (-1/(get(handles.tau_2_kappa_slider,'Value')));
end
temp = 0:length(handles.data.filter.fifi)-1;

handles.filter = handles.a * exp(handles.b*temp) + handles.c * exp(handles.d*temp);

handles.temp = 0:0.2:(length(handles.filter)-1)*0.2;
axes(handles.kappa_axes);
cla;
plot(handles.temp, handles.filter);
xlabel('time [ms]');
ylabel('kappa [mV]');
axis tight;

guidata(hObject, handles);
%-------------------------------------------------------------------------%



%-------------------------------------------------------------------------%
function launch_pushbutton_Callback(hObject, eventdata, handles)

handles.SRM_output = [];
handles.SRM_input = [];

val_1 = get(handles.threshold_popupmenu, 'Value')-1;
val_2 = get(handles.load_data_popup, 'Value')-1;
if(val_2==0)
    name = 'NO DATA LOADED';
    set(handles.threshold_equation_edit_text,'String',name);
elseif(val_1==0)
    name = 'CHOOSE A TYPE OF THRESHOLD';
    set(handles.threshold_equation_edit_text,'String',name);
else
    handles.SRM_input.U_sub = conv(handles.I,handles.filter);
    handles.SRM_input.spiketimes = handles.spiketimes;
    handles.SRM_input.eta = handles.data.ETA;
    
    if(val_1==1)
        handles.SRM_input.threshold = [handles.cst_threshold 0 1 0 1];
    elseif(val_1==2)
        handles.SRM_input.threshold = [handles.exp1_threshold 0 1];
    end

    handles.SRM_output = SRM(handles.SRM_input);
    
    %handles.SRM_output.Vsrm = SRM_test(handles.SRM_input.threshold,handles.filter,handles.SRM_input.eta,handles.I,-59.7588,3,5000);
    
    
    handles.SRM_output.Vsrm = handles.SRM_output.Vsrm(1:length(handles.V));
    handles.SRM_output.spiketimes = Extract_spiketimes(handles.SRM_output.Vsrm);
    handles.SRM_output.temp = max(handles.SRM_output.spiketimes(:,2));
    
    [handles.SRM_output.coincidence handles.SRM_output.coincidente_spike] = ...
        GamCoincFac(handles.SRM_output.spiketimes(:,1),handles.SRM_input.spiketimes(:,1),5000);
    
    set(handles.SRM_coincidence_edit_text,'String','loading');
    set(handles.SRM_coincidence_edit_text,'String',num2str(handles.SRM_output.coincidence));
    set(handles.raw_coincidence_edit_text,'String',num2str(handles.SRM_output.coincidence/handles.int_coinc));
    
    handles.temp = 0:0.2:(length(handles.V)-1)*0.2;
    axes(handles.SRM_axes);
    cla;
    hold on;
    plot(handles.temp, handles.V);
    
    X = handles.temp(1:300);
    Y = handles.SRM_output.Vsrm(1:300);
    p = plot(X(1:300),Y(1:300),'-r','EraseMode','none');
    
    for t=301:300:length(handles.temp);
        X = handles.temp(t-300:t);
        Y = handles.SRM_output.Vsrm(t-300:t);
        set(p,'XData',X,'YData',Y) 
        drawnow
    end
    plot(handles.temp,handles.SRM_output.Vsrm(1:length(handles.temp)),'r');
    xlabel('time [ms]');
    ylabel('membrane potential [mV]');
    plot(handles.SRM_output.spiketimes(handles.SRM_output.coincidente_spike)*0.2,handles.SRM_output.temp+5,'k+');
    plot(10,handles.SRM_output.temp+10,'.');
    axis tight;
    hold off;
end

guidata(hObject, handles);
%-------------------------------------------------------------------------%



%-------------------------------------------------------------------------%
function reset_pushbutton_Callback(hObject, eventdata, handles)

set(handles.threshold_popupmenu,'Value',1);
name = 'Choose a type of threshold';
set(handles.threshold_equation_edit_text,'String',name);
set(handles.theta_0_slider,'Value',get(handles.theta_0_slider,'Min'));
set(handles.theta_1_slider,'Value',get(handles.theta_1_slider,'Min'));
set(handles.tau_theta_1_slider,'Value',get(handles.tau_theta_1_slider,'Min'));

set(handles.theta_0_edit_text,'String',num2str(get(handles.theta_0_slider,'Value')));
set(handles.theta_1_edit_text,'String',num2str(get(handles.theta_1_slider,'Value')));
set(handles.tau_theta_1_edit_text,'String',num2str(get(handles.tau_theta_1_slider,'Value')));
    
set(handles.load_data_popup,'Value',1);
axes(handles.current_axes);
cla;
axes(handles.SRM_axes);
cla;
set(handles.mean_I_edit_text,'String','----');
set(handles.std_I_edit_text,'String','----');
set(handles.SRM_coincidence_edit_text,'String','----');
set(handles.intrinsic_coincidence_edit_text,'String','----');
set(handles.raw_coincidence_edit_text,'String','----');
set(handles.tau_kappa_slider,'Value',-1/handles.data.filter.b);
set(handles.tau_2_kappa_slider,'Value',-1/handles.data.filter.d);
handles.temp = 0:0.2:(length(handles.data.filter.fifi)-1)*0.2;
axes(handles.kappa_axes);
plot(handles.temp, handles.data.filter.fifi);
xlabel('time [ms]');
ylabel('kappa [mV]');
axis tight;

handles.filter = handles.data.filter.fifi;
handles.a = handles.data.filter.a;
handles.b = handles.data.filter.b;
handles.c = handles.data.filter.c;
handles.d = handles.data.filter.d;
handles.eta = handles.data.ETA;
handles.cst_threshold = handles.data.cst_threshold;
handles.exp1_threshold = handles.data.exp1_threshold;

guidata(hObject, handles);
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
function export_graph_pushbutton_Callback(hObject, eventdata, handles)

if(isempty(handles.SRM_output))
    name = 'NOTHING TO PLOT';
    set(handles.threshold_equation_edit_text,'String',name);
else
    figure(2);
    hold on;
    plot(handles.temp, handles.V);
    plot(handles.temp,handles.SRM_output.Vsrm(1:length(handles.temp)),'r');
    plot(handles.SRM_output.spiketimes(handles.SRM_output.coincidente_spike)*0.2,handles.SRM_output.temp+5,'k+');
    xlabel('time [ms]');
    ylabel('membrane potential [mV]');
    axis tight;
    hold off;
end
%-------------------------------------------------------------------------%



%-------------------------------------------------------------------------%
function threshold_popupmenu_Callback(hObject, eventdata, handles)

val = get(hObject, 'Value')-1;

if (val==0)
    name = 'Choose a type of threshold';
    set(handles.threshold_equation_edit_text,'String',name);
    
    set(handles.theta_0_slider,'Value',get(handles.theta_0_slider,'Min'));
    set(handles.theta_1_slider,'Value',get(handles.theta_1_slider,'Min'));
    set(handles.tau_theta_1_slider,'Value',get(handles.tau_theta_1_slider,'Min'));
    
    set(handles.theta_0_edit_text,'String',num2str(get(handles.theta_0_slider,'Value')));
    set(handles.theta_1_edit_text,'String',num2str(get(handles.theta_1_slider,'Value')));
    set(handles.tau_theta_1_edit_text,'String',num2str(get(handles.tau_theta_1_slider,'Value')));
    
elseif(val==1)
    name = 'theta(t) = theta_0';
    set(handles.threshold_equation_edit_text,'String',name);
    
    set(handles.theta_0_slider,'Value',handles.data.cst_threshold);
    
    set(handles.theta_1_slider,'Value',get(handles.theta_1_slider,'Min'));
    set(handles.tau_theta_1_slider,'Value',get(handles.tau_theta_1_slider,'Min'));
    
    set(handles.theta_0_edit_text,'String',num2str(handles.data.cst_threshold));
    
    set(handles.theta_1_edit_text,'String','not used');
    set(handles.tau_theta_1_edit_text,'String','not used');

elseif(val==2)
    name = 'dtheta/dt = (theta - theta_0)/-tau_1 + nu_1';
    set(handles.threshold_equation_edit_text,'String',name);
    
    set(handles.theta_0_slider,'Value',handles.data.exp1_threshold(1));
    set(handles.theta_1_slider,'Value',handles.data.exp1_threshold(2));
    set(handles.tau_theta_1_slider,'Value',handles.data.exp1_threshold(3));
    
    set(handles.theta_0_edit_text,'String',num2str(handles.data.exp1_threshold(1)));
    set(handles.theta_1_edit_text,'String',num2str(handles.data.exp1_threshold(2)));
    set(handles.tau_theta_1_edit_text,'String',num2str(handles.data.exp1_threshold(3)));
    
end

guidata(hObject, handles);
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
function theta_0_slider_Callback(hObject, eventdata, handles)

val = get(handles.threshold_popupmenu,'Value')-1;
if(val==0)
    set(handles.theta_0_slider,'Value',get(handles.theta_0_slider,'Min'));
    set(handles.theta_0_edit_text,'String',num2str(get(handles.theta_0_slider,'Value')));
elseif(val==1)
    handles.cst_threshold = get(handles.theta_0_slider,'Value');
    set(handles.theta_0_edit_text,'String',num2str(get(handles.theta_0_slider,'Value')));
elseif(val==2)
    handles.exp1_threshold(1) = get(handles.theta_0_slider,'Value');
    set(handles.theta_0_edit_text,'String',num2str(get(handles.theta_0_slider,'Value')));
end

guidata(hObject, handles);
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
function theta_1_slider_Callback(hObject, eventdata, handles)

val = get(handles.threshold_popupmenu,'Value')-1;
if(val==0 || val ==1)
    set(handles.theta_1_slider,'Value',get(handles.theta_1_slider,'Min'));
    set(handles.theta_1_edit_text,'String',num2str(get(handles.theta_1_slider,'Value')));
elseif(val==2)
    handles.exp1_threshold(2) = get(handles.theta_1_slider,'Value');
    set(handles.theta_1_edit_text,'String',num2str(get(handles.theta_1_slider,'Value')));
end

guidata(hObject, handles);
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
function tau_theta_1_slider_Callback(hObject, eventdata, handles)

val = get(handles.threshold_popupmenu,'Value')-1;
if(val==0 || val ==1)
    set(handles.tau_theta_1_slider,'Value',get(handles.tau_theta_1_slider,'Min'));
    set(handles.tau_theta_1_edit_text,'String',num2str(get(handles.tau_theta_1_slider,'Value')));
elseif(val==2)
    handles.exp1_threshold(3) = get(handles.tau_theta_1_slider,'Value');
    set(handles.tau_theta_1_edit_text,'String',num2str(get(handles.tau_theta_1_slider,'Value')));
end

guidata(hObject, handles);
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
function theta_0_edit_text_Callback(hObject, eventdata, handles)

val = get(handles.threshold_popupmenu,'Value')-1;
if(val==0)
    set(handles.theta_0_slider,'Value',get(handles.theta_0_slider,'Min'));
    set(handles.theta_0_edit_text,'String',num2str(get(handles.theta_0_slider,'Value')));
elseif(val==1)
    handles.cst_threshold = str2double(get(handles.theta_0_edit_text,'String'));
    set(handles.theta_0_slider,'Value',handles.cst_threshold);
elseif(val==2)
    handles.exp1_threshold(1) = str2double(get(handles.theta_0_edit_text,'String'));
    set(handles.theta_0_slider,'Value',handles.exp1_threshold(1));
end

guidata(hObject, handles);
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
function theta_1_edit_text_Callback(hObject, eventdata, handles)

val = get(handles.threshold_popupmenu,'Value')-1;
if(val==0 || val==1)
    set(handles.theta_1_slider,'Value',get(handles.theta_1_slider,'Min'));
    set(handles.theta_1_edit_text,'String',num2str(get(handles.theta_1_slider,'Value')));
elseif(val==2)
    handles.exp1_threshold(2) = str2double(get(handles.theta_1_edit_text,'String'));
    set(handles.theta_1_slider,'Value',handles.exp1_threshold(2));
end

guidata(hObject, handles);
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
function tau_theta_1_edit_text_Callback(hObject, eventdata, handles)

val = get(handles.threshold_popupmenu,'Value')-1;
if(val==0 || val==1)
    set(handles.tau_theta_1_slider,'Value',get(handles.tau_theta_1_slider,'Min'));
    set(handles.tau_theta_1_edit_text,'String',num2str(get(handles.tau_theta_1_slider,'Value')));
elseif(val==2)
    handles.exp1_threshold(3) = str2double(get(handles.tau_theta_1_edit_text,'String'));
    set(handles.tau_theta_1_slider,'Value',handles.exp1_threshold(3));
end

guidata(hObject, handles);
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
function raw_coincidence_edit_text_Callback(hObject, eventdata, handles)
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
function load_data_popup_panel_Callback(hObject, eventdata, handles)
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
function mean_I_edit_text_Callback(hObject, eventdata, handles)
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
function std_I_edit_text_Callback(hObject, eventdata, handles)
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
function SRM_coincidence_edit_text_Callback(hObject, eventdata, handles)
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
function intrinsic_coincidence_edit_text_Callback(hObject, eventdata, handles)
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
function threshold_equation_edit_text_Callback(hObject, eventdata, handles)
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%-----------------------------Create Function-----------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%

function load_data_popup_panel_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function load_data_popup_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tau_kappa_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function mean_I_edit_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function std_I_edit_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SRM_coincidence_edit_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function intrinsic_coincidence_edit_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function threshold_popupmenu_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function threshold_equation_edit_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta_0_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function theta_1_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function tau_theta_1_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function theta_0_edit_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta_1_edit_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tau_theta_1_edit_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function raw_coincidence_edit_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tau_2_kappa_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function [spiketimes] = Extract_spiketimes(voltage)
%   sampling_freq est utile pour caculer la période réfractaire, environ
%   0.8 ms pour détecter tout les spikes.
%   limit_t_refr = floor(0.8*(sampling_freq*1e-3))
%   extrait les spiketimes d'un trace. spiketimes(:,1) = spiketimes
%   les spiketimes sont detecté en zéros upward crossing
%   spiketimes(:,2) = max voltage du spike, utile pour plotter la détection
%   des spikes.
%   spiketimes(:,3) = ISI, utile pour eta dépendant du last isi;

sampling_freq = 5000;
k=1;                                                %compte le nombre de spike
voltage_prime = [0;diff(voltage)];                  %dérivée de voltage
limite = 0;                                         %limite à partir de laquelle on prend un spike = 0
limit_t_refr = floor(0.8*(sampling_freq*1e-3));     %voir au dessus
t_refr = limit_t_refr + 1;                          %permet de detecter un spike en t=1
spiketimes_t(1,1) = 0;
spiketimes_t(1,2) = 0;
spiketimes_t(1,3) = 0;

for i=1:length(voltage)-6          %parcours le voltage
    if(voltage(i) >= limite && voltage_prime(i) > 0 && t_refr >= limit_t_refr)
        k = k+1;
        t_refr = 0;
        spiketimes_t(k,2) = max(voltage(i:i+5)); % prend le max sur 1 [ms]
        spiketimes_t(k,1) = i;
        spiketimes_t(k,3) = spiketimes_t(k,1)-spiketimes_t(k-1,1);
    else
        t_refr = t_refr + 1;
    end
end

spiketimes_t(:,1) = spiketimes_t(:,1)-1;    %détecte le zéros crossing, sinon détecter le t d'après

spiketimes(:,1) = spiketimes_t(2:end,1);
spiketimes(:,2) = spiketimes_t(2:end,2);
spiketimes(:,3) = spiketimes_t(2:end,3);


%
%    G = GamCoincFac(PredSpkTrain,TargetSpkTrain, SamplingFreq)
%       Calculates the Gamma factor for the Target Spike Train
%       TargetSpkTrain and the Modeled Spike Train PredSpkTrain.
%       SamplingFreq the sampling frequency in Hz, and the spike trains are
%       a list of spike indices (spike times = SpkTrain / SamplingFreq).  
%   
%   See
%       Kistler et al, Neural Comp 9:1015-1045 (1997)
%       Jolivet et al, J Neurophysiol 92:959-976 (2004)
%   for further details
%
%
%           - Renaud Jolivet 2007.05.
%           - modified by R. Naud 2007.09. (siingularity and break in loop
%          and empty PredSpkTrain handling)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [G CoincSpike] = GamCoincFac(PredSpkTrain,TargetSpkTrain,SamplingFreq)

CoincSpike = [];
if isempty(PredSpkTrain)
    G = 0;
    NCoinc = [];
    return;
end

% Some parameters
DeltaWindow     =   2e-03;                      % [sec]         % half-width of coincidence detection (2 msec)
DeltaBins       =   DeltaWindow*SamplingFreq;   % [time bins]   % half-width of coincidence detection (2 msec)
NSpikesPred     =   length(PredSpkTrain);
NSpikesTarget   =   length(TargetSpkTrain);
%
% Compute frequencies, normalisation and average coincidences 
FreqPred        =   SamplingFreq*(NSpikesPred-1)/max((PredSpkTrain(NSpikesPred)-PredSpkTrain(1)),1);
NCoincAvg       =   2*DeltaWindow*NSpikesTarget*FreqPred;
NNorm           =   abs(1-2*FreqPred*DeltaWindow);
%
% Compute the gamma coincidence factor
NCoinc          =   0; 
i               =   1;
while i <= NSpikesTarget
    j=1;
    while j <= NSpikesPred
        if abs(PredSpkTrain(j)-TargetSpkTrain(i)) <= DeltaBins
            NCoinc  =   NCoinc+1;
            i       =   i+1;
            CoincSpike(end+1) = j;
            if i> NSpikesTarget, break, end
        end
        j=j+1;
    end
    i=i+1;
end

G               =	(NCoinc-NCoincAvg)/(1/2*(NSpikesPred+NSpikesTarget))*1/NNorm;

if(G<0)
	G = 0;
else
	G = G;
end

function SRM_output = SRM(SRM_input)
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here

%----------Initialisation des parametres----%
E_rest = -59.7588;
%E_rest = -61.2;
U_sub = SRM_input.U_sub + E_rest;
eta = diff([0 SRM_input.eta]);
nu_0        = SRM_input.threshold(1);
nu_1        = SRM_input.threshold(2);
tau_1    = SRM_input.threshold(3)*5;
%----------------------------------------%

%----------Initialisation----------------%
t_refr = 0;
SRM_output.spike = [];
SRM_output.spike(1) = 0;
%----------------------------------------%

%---------Allocation de mémoire pour SRM_ouput.u----%
SRM_output.Vsrm = E_rest*ones(length(U_sub),1);
U_threshold = nu_0;
%----------------------------------------%

for i=2:length(U_sub)

    if(SRM_output.spike(end) == i-2)
        dthreshold = ((U_threshold - nu_0)/-tau_1) + nu_1;
    else
        dthreshold = ((U_threshold - nu_0)/-tau_1);
    end

    U_threshold = U_threshold + dthreshold;

    if(SRM_output.Vsrm(i-1) > U_threshold && t_refr > 15)
        SRM_output.spike(end+1) = i-1;
        t_refr = 0;
        SRM_output.Vsrm(i) = SRM_output.Vsrm(i-1) + eta(i-SRM_output.spike(end));
    elseif(SRM_output.spike(end) ~= 0 && t_refr <= 1)
        SRM_output.Vsrm(i) = SRM_output.Vsrm(i-1) + eta(i-SRM_output.spike(end));
        t_refr = t_refr+1;
    elseif(SRM_output.spike(end) ~= 0 && t_refr < length(eta(1:123))-1)
        SRM_output.Vsrm(i) = U_sub(i) + (eta(i-SRM_output.spike(end)+1)-eta(i-SRM_output.spike(end)));
        t_refr = t_refr+1;
    else
        SRM_output.Vsrm(i) = U_sub(i);
        t_refr = t_refr+1;
    end
end

SRM_output.spike = SRM_output.spike(2:end);
