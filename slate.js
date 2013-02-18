// Operations

var pushLeft = slate.operation('push', {
  'direction' : 'left',
  'style' : 'bar-resize:screenSizeX/2'
});

var pushUp = slate.operation('push', {
  'direction' : 'up',
  'style' : 'bar-resize:screenSizeY/2'
});

var pushRight = slate.operation('push', {
  'direction' : 'right',
  'style' : 'bar-resize:screenSizeX/2'
});

var pushDown = slate.operation('push', {
  'direction' : 'down',
  'style' : 'bar-resize:screenSizeY/2'
});

var fullscreen = slate.operation('move', {
  'x' : 'screenOriginX',
  'y' : 'screenOriginY',
  'width' : 'screenSizeX',
  'height' : 'screenSizeY'
});

var iTermChromeShow = slate.operation('show', {
  'app' : ['iTerm', 'Google Chrome']
});

var iTermFocus = slate.operation('focus', { 'app' : 'iTerm' });
var macVimFocus = slate.operation('focus', { 'app' : 'MacVim' });
var chromeFocus = slate.operation('focus', { 'app' : 'Google Chrome' });

// Layouts

var iTermChromeLayout = slate.layout('iTermChromeLayout', {
  '_after_' : { 'operations' : [iTermChromeShow, iTermFocus] },
  'iTerm' : {
    'operations' : pushRight,
    'main-first' : true
  },
  'Google Chrome' : {
    'operations' : pushLeft,
    'main-first' : true
  }
});

// Binds

slate.bind('left:ctrl,alt,cmd', function(win) {
  win.doOperation(pushLeft);
});

slate.bind('up:ctrl,alt,cmd', function(win) {
  win.doOperation(pushUp);
});

slate.bind('right:ctrl,alt,cmd', function(win) {
  win.doOperation(pushRight);
});

slate.bind('down:ctrl,alt,cmd', function(win) {
  win.doOperation(pushDown);
});

slate.bind('m:ctrl,alt,cmd', function(win) {
  win.doOperation(fullscreen);
});

slate.bind('i:ctrl,cmd', chromeFocus)
slate.bind('j:ctrl,cmd', iTermFocus)
slate.bind('k:ctrl,cmd', macVimFocus)

slate.bind('j:ctrl,alt,cmd', slate.operation('layout', {
  'name' : iTermChromeLayout
}));
