function [sys,x0,str,ts,simStateCompliance] = pendan(t,x,u,flag,RefBlock)
%PENDAN S-function for making pendulum animation.
%
%   See also: PENDDEMO.

%   Copyright 1990-2014 The MathWorks, Inc.

% Plots every major integration step, but has no states of its own
switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(RefBlock);

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,
    sys=mdlTerminate();
    
  %%%%%%%%%%%%%%%%
  % Unused flags %
  %%%%%%%%%%%%%%%%
  case { 1, 3, 4},
    sys = [];
    
  %%%%%%%%%%%%%%%
  % DeleteBlock %
  %%%%%%%%%%%%%%%
  case 'DeleteBlock',
    LocalDeleteBlock
    
  %%%%%%%%%%%%%%%
  % DeleteFigure %
  %%%%%%%%%%%%%%%
  case 'DeleteFigure',
    LocalDeleteFigure
  
  %%%%%%%%%%
  % Slider %
  %%%%%%%%%%
  case 'Slider',
    LocalSlider
  
  %%%%%%%%%
  % Close %
  %%%%%%%%%
  case 'Close',
    LocalClose
  
  %%%%%%%%%%%%
  % Playback %
  %%%%%%%%%%%%
  case 'Playback',
    LocalPlayback
   
  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(message('simdemos:general:UnhandledFlag', num2str( flag )));
end

% end pendan

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(RefBlock)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 0;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times, for the pendulum example,
% the animation is updated every dt seconds
%
dt = 0.05;
ts  = [dt 0];

%
% create the figure, if necessary
%
LocalPendInit(RefBlock);

% specify that the simState for this s-function is same as the default
simStateCompliance = 'DefaultSimState';

% end mdlInitializeSizes

%
%=============================================================================
% mdlUpdate
% Update the pendulum animation.
%=============================================================================
%
function sys=mdlUpdate(t,x,u) %#ok<INUSL>

fig = get_param(gcbh,'UserData');
if ishghandle(fig, 'figure'),
  if strcmp(get(fig,'Visible'),'on'),
    ud = get(fig,'UserData');
    LocalPendSets(t,ud,u);
  end
end;
 
sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlTerminate
% Re-enable playback buttong for the pendulum animation.
%=============================================================================
%
function sys=mdlTerminate() 

fig = get_param(gcbh,'UserData');
if ishghandle(fig, 'figure'),
    pushButtonPlayback = findobj(fig,'Tag','penddemoPushButton');
    set(pushButtonPlayback,'Enable','on');
end;
 
sys = [];

% end mdlTerminate

%
%=============================================================================
% LocalDeleteBlock
% The animation block is being deleted, delete the associated figure.
%=============================================================================
%
function LocalDeleteBlock

fig = get_param(gcbh,'UserData');
if ishghandle(fig, 'figure'),
  delete(fig);
  set_param(gcbh,'UserData',-1)
end

% end LocalDeleteBlock

%
%=============================================================================
% LocalDeleteFigure
% The animation figure is being deleted, set the S-function UserData to -1.
%=============================================================================
%
function LocalDeleteFigure

ud = get(gcbf,'UserData');
set_param(ud.Block,'UserData',-1);
  
% end LocalDeleteFigure

%
%=============================================================================
% LocalSlider
% The callback function for the animation window slider uicontrol.  Change
% the reference block's value.
%=============================================================================
%
function LocalSlider

ud = get(gcbf,'UserData');
set_param(ud.RefBlock,'Value',num2str(get(gcbo,'Value')));

% end LocalSlider

%
%=============================================================================
% LocalClose
% The callback function for the animation window close button.  Delete
% the animation figure window.
%=============================================================================
%
function LocalClose

delete(gcbf)

% end LocalClose

%
%=============================================================================
% LocalPlayback
% The callback function for the animation window playback button.  Playback
% the animation.
%=============================================================================
%
% function LocalPlayback
% 
% %
% % first find the animation data in the base workspace, issue an error
% % if the information isn't there
% %
% t = evalin('base','t','[]');
% y = evalin('base','y','[]');
% 
% if isempty(t) || isempty(y),
%   errordlg(...
%     ['You must first run the simulation before '...
%      'playing back the animation.'],...
%     'Animation Playback Error');
% end
% 
% %
% % playback the animation, note that the playback is wrapped in a try-catch
% % because is it is possible for the figure and it's children to be deleted
% % during the drawnow in LocalPendSets
% %
% try
%   ud = get(gcbf,'UserData');
%   for i=1:length(t),
%     LocalPendSets(t(i),ud,y(i,:));
%   end
% catch %#ok<CTCH>
%     % do nothing
% end

% end LocalPlayback

%
%=============================================================================
% LocalPendSets
% Local function to set the position of the graphics objects in the
% inverted pendulum animation window.
%=============================================================================
%
function LocalPendSets(time,ud,u)
% u(1): 
% u(2): cart position
% u(3): pendulum angle
global pend_length

XDelta   = 0.1; % cart width
PDelta   = 0.01; % pendulum width
PendLength = pend_length;
XPendTop = u(2) + PendLength*sin(u(3));
YPendTop = PendLength*cos(u(3));
PDcosT   = PDelta*cos(u(3));
PDsinT   = -PDelta*sin(u(3));
set(ud.Cart,...
  'XData',ones(2,1)*[u(2)-XDelta u(2)+XDelta]);
set(ud.Pend,...
  'XData',[XPendTop-PDcosT XPendTop+PDcosT; u(2)-PDcosT u(2)+PDcosT], ...
  'YData',[YPendTop-PDsinT YPendTop+PDsinT; -PDsinT PDsinT]);
set(ud.TimeField,...
  'String',num2str(time));
% set(ud.RefMark,...
%   'XData',u(1)+[-XDelta 0 XDelta]);

% Force plot to be drawn
pause(0)
drawnow

% end LocalPendSets

%
%=============================================================================
% LocalPendInit
% Local function to initialize the pendulum animation.  If the animation
% window already exists, it is brought to the front.  Otherwise, a new
% figure window is created.
%=============================================================================
%
function LocalPendInit(RefBlock)

global position_init
global theta_init
global pend_length
global Fig

%
% The name of the reference is derived from the name of the
% subsystem block that owns the pendulum animation S-function block.
% This subsystem is the current system and is assumed to be the same
% layer at which the reference block resides.
%
sys = get_param(gcs,'Parent');

TimeClock = 0;
RefSignal = str2double(get_param([sys '/' RefBlock],'Value'));

XDelta    = 0.1; % width
PDelta    = 0.01;
PendLength = pend_length;
XPendTop  = position_init + PendLength*sin(theta_init); % Will be zero
YPendTop  = PendLength*cos(theta_init);         % Will be 10
PDcosT    = PDelta*cos(theta_init);     % Will be 0.2
PDsinT    = -PDelta*sin(theta_init);    % Will be zero

%
% The animation figure handle is stored in the pendulum block's UserData.
% If it exists, initialize the reference mark, time, cart, and pendulum
% positions/strings/etc.
%
Fig = get_param(gcbh,'UserData');
if ishghandle(Fig ,'figure'),
  FigUD = get(Fig,'UserData');
%   set(FigUD.RefMark,...
%       'XData',RefSignal+[-XDelta 0 XDelta]);
  set(FigUD.TimeField,...
      'String',num2str(TimeClock));
  set(FigUD.Cart,...
      'XData',ones(2,1)*[position_init-XDelta position_init+XDelta]);
  set(FigUD.Pend,...
      'XData',[XPendTop-PDcosT XPendTop+PDcosT; position_init-PDcosT position_init+PDcosT],...
      'YData',[YPendTop-PDsinT YPendTop+PDsinT; -PDsinT PDsinT]);
  
  % disable playback button during simulation
%   pushButtonPlayback = findobj(Fig,'Tag','penddemoPushButton');
%   set(pushButtonPlayback,'Enable','off');
        
  %
  % bring it to the front
  %
  figure(Fig);
  return
end

%
% the animation figure doesn't exist, create a new one and store its
% handle in the animation block's UserData
%
FigureName = 'Pendulum Visualization';
Fig = figure(...
  'Units',           'pixel',...
  'Position',        [100 100 700 400],...
  'Name',            FigureName,...
  'NumberTitle',     'off',...
  'IntegerHandle',   'off',...
  'HandleVisibility','callback',...
  'Resize',          'off',...
  'DeleteFcn',       'cartpend_anime([],[],[],''DeleteFigure'')',...
  'CloseRequestFcn', 'cartpend_anime([],[],[],''Close'');');
AxesH = axes(...
  'Parent',  Fig,...
  'FontSize', 18,...
  'Units',   'pixel',...
  'Position',[50 50 600 300],...
  'CLim',    [1 64], ...
  'Xlim',    [-1.2 1.2],...
  'Ylim',    [-0.5 0.7],...
  'Visible', 'on');
Cart = surface(...
  'Parent',   AxesH,...
  'XData',    ones(2,1)*[position_init-XDelta position_init+XDelta],...
  'YData',    [0 0; -0.1 -0.1],...
  'ZData',    zeros(2),...
  'CData',    11*ones(2));
Pend = surface(...
  'Parent',   AxesH,...
  'XData',    [XPendTop-PDcosT XPendTop+PDcosT; position_init-PDcosT position_init+PDcosT],...
  'YData',    [YPendTop-PDsinT YPendTop+PDsinT; -PDsinT PDsinT],...
  'ZData',    zeros(2),...
  'CData',    50*ones(2));
% RefMark = patch(...
%   'Parent',   AxesH,...
%   'XData',    RefSignal+[-XDelta 0 XDelta],...
%   'YData',    [-2 0 -2],...
%   'CData',    22,...
%   'FaceColor','flat');
% uicontrol(...
%   'Parent',  Fig,...
%   'Style',   'text',...
%   'Units',   'pixel',...
%   'Position',[0 0 500 50]);
uicontrol(...
  'Parent',             Fig,...
  'Style',              'text',...
  'FontSize',           18,...
  'Units',              'pixel',...
  'Position',           [240 0 100 25], ...
  'HorizontalAlignment','right',...
  'String',             'Time: ');
TimeField = uicontrol(...
  'Parent',             Fig,...
  'Style',              'text',...
  'FontSize',           18,...
  'Units',              'pixel', ...
  'Position',           [360 0 100 25],...
  'HorizontalAlignment','left',...
  'String',             num2str(TimeClock));
% SlideControl = uicontrol(...
%   'Parent',   Fig,...
%   'Style',    'slider',...
%   'Units',    'pixel', ...
%   'Position', [250 25 300 22],...
%   'Min',      -9,...
%   'Max',      9,...
%   'Value',    RefSignal,...
%   'Callback', 'pendan([],[],[],''Slider'');');
% uicontrol(...
%   'Parent',  Fig,...
%   'Style',   'pushbutton',...
%   'Position',[415 15 70 20],...
%   'String',  'Close', ...
%   'Callback','pendan([],[],[],''Close'');');
% uicontrol(...
%   'Parent',  Fig,...
%   'Style',   'pushbutton',...
%   'Position',[15 15 70 20],...
%   'String',  'Playback', ...
%   'Callback','pendan([],[],[],''Playback'');',...
%   'Interruptible','off',...
%   'BusyAction','cancel', ...
%   'Tag','penddemoPushButton',...
%   'Enable','off');

%
% all the HG objects are created, store them into the Figure's UserData
%
FigUD.Cart         = Cart;
FigUD.Pend         = Pend;
FigUD.TimeField    = TimeField;
% FigUD.SlideControl = SlideControl;
% FigUD.RefMark      = RefMark;
FigUD.Block        = get_param(gcbh,'Handle');
% % FigUD.RefBlock     = get_param([sys '/' RefBlock],'Handle');
set(Fig,'UserData',FigUD);

drawnow

%
% store the figure handle in the animation block's UserData
%
set_param(gcbh,'UserData',Fig);

% end LocalPendInit
