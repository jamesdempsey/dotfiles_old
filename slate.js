// Configs

slate.configAll({
  'defaultToCurrentScreen' : true,
  'checkDefaultsOnLoad' : true
});

// Displays

var airDisplay = '1440x900';
var extDisplay = '1680x1050';

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

var topLeftCorner = slate.operation('corner', {
  'direction' : 'top-left',
  'width' : 'screenSizeX/2',
  'height' : 'screenSizeY/2'
});

var topRightCorner = slate.operation('corner', {
  'direction' : 'top-right',
  'width' : 'screenSizeX/2',
  'height' : 'screenSizeY/2'
});

var bottomLeftCorner = slate.operation('corner', {
  'direction' : 'bottom-left',
  'width' : 'screenSizeX/2',
  'height' : 'screenSizeY/2'
});

var bottomRightCorner = slate.operation('corner', {
  'direction' : 'bottom-right',
  'width' : 'screenSizeX/2',
  'height' : 'screenSizeY/2'
});

var fullscreen = slate.operation('move', {
  'x' : 'screenOriginX',
  'y' : 'screenOriginY',
  'width' : 'screenSizeX',
  'height' : 'screenSizeY'
});

var fullscreenExtDisplay = fullscreen.dup({ 'screen' : extDisplay });
var fullscreenAirDisplay = fullscreen.dup({ 'screen' : airDisplay });

var iTermChromeShow = slate.operation('show', {
  'app' : ['iTerm', 'Google Chrome']
});

var iTermMacVimShow = slate.operation('show', {
  'app' : ['iTerm', 'MacVim']
});

var iTermFocus = slate.operation('focus', { 'app' : 'iTerm' });
var macVimFocus = slate.operation('focus', { 'app' : 'MacVim' });
var chromeFocus = slate.operation('focus', { 'app' : 'Google Chrome' });
var iTunesFocus = slate.operation('focus', { 'app' : 'iTunes' });
var adiumFocus = slate.operation('focus', { 'app' : 'Adium' });

// Hashes

var fullscreenAirHash = {
    'operations': fullscreenAirDisplay,
    'repeat' : true
}

var fullscreenExtHash =  {
    'operations': fullscreenExtDisplay,
    'repeat' : true
}

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

var iTermMacVimLayout = slate.layout('iTermMacVimLayout', {
  '_after_' : { 'operations' : [iTermMacVimShow, iTermFocus] },
  'iTerm' : {
    'operations' : pushRight,
    'repeat' : true,
    'main-last' : true
  },
  'MacVim' : {
    'operations' : pushLeft,
    'repeat' : true,
    'main-last' : true
  }
});

var dualDisplays = slate.layout('dualDisplays', {
  'iTerm' : fullscreenAirHash,
  'MacVim' : fullscreenAirHash,
  'Google Chrome' : fullscreenExtHash,
  'iTunes' : fullscreenExtHash
});

var nativeDisplay = slate.layout('nativeDisplay', {
  'iTerm' : fullscreenAirHash,
  'MacVim' : fullscreenAirHash,
  'Google Chrome' : fullscreenAirHash,
  'iTunes' : fullscreenAirHash
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

slate.bind('up:ctrl,alt', topLeftCorner);
slate.bind('right:ctrl,alt', topRightCorner);
slate.bind('left:ctrl,alt', bottomLeftCorner);
slate.bind('down:ctrl,alt', bottomRightCorner);

slate.bind('m:ctrl,cmd', function(win) {
  win.doOperation(fullscreen);
});

slate.bind('i:ctrl,cmd', chromeFocus);
slate.bind('j:ctrl,cmd', iTermFocus);
slate.bind('k:ctrl,cmd', macVimFocus);
slate.bind('o:ctrl,cmd', iTunesFocus);
slate.bind('u:ctrl,cmd', adiumFocus);

slate.bind('j:ctrl,alt,cmd', slate.operation('layout', {
  'name' : iTermChromeLayout
}));

slate.bind('l:ctrl,cmd', slate.operation('layout', {
  'name' : iTermMacVimLayout
}));

// Defaults

slate.default(1, nativeDisplay)
slate.default(2, dualDisplays)
