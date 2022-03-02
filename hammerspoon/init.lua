-- Layout configuration
local step = 10
local stepBig = 100
local log = hs.logger.new('init','debug')

-- No window animations
hs.window.animationDuration = 0
hs.hints.titleMaxSize = -1
hs.hints.showTitleThresh = 0

hs.application.enableSpotlightForNameSearches(true)

local display_macbook = 'Color LCD'
local display_asus = 'LG UltraFine'
local lastNumberOfScreens = #hs.screen.allScreens()

hs.grid.MARGINX = 20
hs.grid.MARGINY = 20
hs.grid.GRIDHEIGHT = 8
hs.grid.GRIDWIDTH = 10

local lay_big = {x = 0, y = 0, w = hs.grid.GRIDWIDTH, h = hs.grid.GRIDHEIGHT}
local lay_med = {x = 1, y = 1, w = hs.grid.GRIDWIDTH - 2, h = hs.grid.GRIDHEIGHT - 2}
local lay_side_big = {x = 1, y = 1, w = math.floor(hs.grid.GRIDWIDTH / 3), h = hs.grid.GRIDHEIGHT - 2}
local lay_side_sm = {x = 1, y = 1, w = math.floor(hs.grid.GRIDWIDTH / 3) - 1, h = hs.grid.GRIDHEIGHT - 2}

-- App name, display, grid layout, window name
layout1 = {
  {'Google Chrome', display_macbook, lay_med, 'all'},
  {'Safari', display_macbook, lay_med, 'all'},
  {'Firefox', display_macbook, lay_med, 'all'},
  {'Sublime Text', display_macbook, lay_big, 'all'},
  {'Alacritty', display_macbook, lay_big, 'all'},
  {'iTerm', display_macbook, lay_big, 'all'},
  {'Messages', display_macbook, {x=0, y=0, w=2, h=4}, 'all'},
  {'Adium', display_macbook, {x=0, y=0, w=1, h=1}, 'all'},
  {'Spotify', display_macbook, lay_med, "all"},
  {'Spark', display_macbook, lay_med, "all"},
  {'Mail', display_macbook, lay_med, "all"},
  {'Todoist', display_macbook, lay_med, "all"},
  {'Sequel Pro', display_macbook, lay_med, "all"},
  {'MacVim', display_macbook, lay_side_big, "all"},
  {'Slack', display_macbook, lay_med, "all"}
}

layout2 = {
  {'Google Chrome', display_macbook, lay_big, 'all'},
  {'Spark', display_macbook, lay_big, "all"},
  {'Mail', display_macbook, lay_big, "all"},
  {'Messages', display_macbook, {x=0, y=0, w=2, h=4}, "all"},
  {'Adium', display_macbook, {x=0, y=0, w=1, h=1}, 'all'},
  {'Spotify', display_macbook, lay_big, "all"},
  {'Safari', display_macbook, lay_big, 'all'},
  {'Firefox', display_macbook, lay_big, 'all'},
  {'Sublime Text', display_asus, lay_big, 'all'},
  {'iTerm', display_asus, lay_big, 'all'},
  {'Todoist', display_macbook, lay_med, "all"},
  {'Sequel Pro', display_asus, lay_med, "all"},
  {'MacVim', display_asus, lay_side_sm, "all"},
  {'Alacritty', display_asus, lay_big, 'all'},
  {'Slack', display_macbook, lay_big, "all"}
}

layout3 = {
  {'Google Chrome', display_asus, lay_big, 'all'},
  {'Spark', display_macbook, lay_big, "all"},
  {'Mail', display_macbook, lay_big, "all"},
  {'Messages', display_macbook, {x=0, y=2, w=2, h=4}, "all"},
  {'Adium', display_macbook, {x=0, y=1, w=2, h=4}, 'all'},
  {'Spotify', display_macbook, lay_big, "all"},
  {'Safari', display_macbook, lay_big, 'all'},
  {'Firefox', display_macbook, lay_big, 'all'},
  {'Sublime Text', display_asus_4k, lay_big, 'all'},
  {'iTerm', display_asus_4k, lay_big, 'all'},
  {'Sequel Pro', display_macbook, lay_med, "all"},
  {'MacVim', display_asus_4k, lay_big, "all"},
  {'Alacritty', display_asus_4k, lay_big, 'all'},
  {'Slack', display_macbook, lay_big, "all"}
}

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({'cmd'}, 'escape')
function k:entered() d:exit(); o:exit() i:exit(); p:exit(); u:exit(); f:exit(); end

-- used if you are ok pressing three triggers
o = hs.hotkey.modal.new({'cmd', 'option', 'shift'}, 'o', 'Open')
function o:entered() f:exit(); u:exit(); d:exit(); k:exit(); i:exit(); p:exit(); end

i = hs.hotkey.modal.new({'cmd', 'option', 'shift'}, 'i', 'Small')
function i:entered() f:exit(); u:exit(); d:exit(); k:exit(); o:exit(); p:exit(); end

p = hs.hotkey.modal.new({'cmd', 'option', 'shift'}, 'p', 'Large')
function p:entered() f:exit(); u:exit(); d:exit(); k:exit(); o:exit(); i:exit(); end

u = hs.hotkey.modal.new({'cmd', 'option', 'shift'}, 'u', 'Half')
function u:entered() f:exit(); p:exit(); d:exit(); k:exit(); o:exit(); i:exit(); end

f = hs.hotkey.modal.new({'cmd', 'option', 'shift'}, 'f', 'Focus')
function f:entered() u:exit(); p:exit(); d:exit(); k:exit(); o:exit(); i:exit(); end

quitAll = function(omit)
  f:exit(); u:exit(); d:exit(); i:exit(); o:exit(); p:exit();
  if omit ~= true then
    k:exit();
  end
end

-- quick escape
hs.hotkey.bind({"cmd", "ctrl", "shift"}, 'escape', function ()
  quitAll();
  hs.alert.show('Emergency Exit.');
end)

-- Bind the Hyper key
k:bind({}, 'escape', quitAll)
o:bind({}, 'escape', quitAll)
i:bind({}, 'escape', quitAll)
p:bind({}, 'escape', quitAll)
u:bind({}, 'escape', quitAll)
f:bind({}, 'escape', quitAll)

-- used if you want multi key presses like vim/tmux
k:bind({}, 'm', nil, function()
  quitAll(); k:enter();
end, function() end)

d = hs.hotkey.modal.new({})
pressedD = function() quitAll(true); d:enter(); end
releasedD = function() end
k:bind({}, 'd', nil, pressedD, releasedD)

e = hs.hotkey.modal.new({})
pressedE = function() quitAll(true); e:enter(); end
releasedE = function() end
k:bind({}, 'e', nil, pressedE, releasedE)

w = hs.hotkey.modal.new({})
pressedW = function() quitAll(true); w:enter(); end
releasedW = function() end
k:bind({}, 'w', nil, pressedW, releasedW)

p = hs.hotkey.modal.new({})
pressedP = function() quitAll(true); p:enter(); end
releasedP = function() end
k:bind({}, 'p', nil, pressedP, releasedP)

i = hs.hotkey.modal.new({})
pressedI = function() quitAll(true); i:enter(); end
releasedI = function() end
k:bind({}, 'i', nil, pressedI, releasedI)

o = hs.hotkey.modal.new({})
pressedA = function() quitAll(true); o:enter(); end
releasedA = function() end
k:bind({}, 'o', nil, pressedA, releasedA)

u = hs.hotkey.modal.new({})
pressedU = function() quitAll(true); u:enter(); end
releasedU = function() end
k:bind({}, 'u', nil, pressedU, releasedU)

f = hs.hotkey.modal.new({})
pressedF = function() quitAll(true); f:enter(); end
releasedF = function() end
k:bind({}, 'f', nil, pressedF, releasedF)

launch = function(appname)
  hs.application.launchOrFocus(appname)
  k.triggered = true
end

-- Single keybinding for functions
mainBindings= {
  {'1', function() quitAll(); applyLayout(layout1); end},
  {'2', function() quitAll(); applyLayout(layout2); end},
  {'3', function() quitAll(); applyLayout(layout3); end},
  {"'", function() quitAll(); hs.grid.maximizeWindow(); end},
  {'=', function()
      quitAll();
      local windows = hs.window.allWindows()
      for i, win in ipairs(windows) do
        local f = win:frame()
        local screen = win:screen()
        local frame = screen:fullFrame()
        f.x = frame.x
        f.y = frame.y
        f.w = frame.w
        f.h = frame.h
        win:setFrame(f)
      end
    end
  },
  {'RETURN', function()
      quitAll();
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local frame = screen:fullFrame()
      f.x = frame.x
      f.y = frame.y
      f.w = frame.w
      f.h = frame.h
      win:setFrame(f)
    end
  },
  {";", function()
      quitAll();
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      hs.grid.set(win, {x = 1, y = 1, w = hs.grid.GRIDWIDTH - 2, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  },
  {'a', function()
    quitAll();
    launch('iTerm');
    launch('Slack');
    launch('Google Chrome');
    launch('Todoist');
    end
  },
  {'J', hs.grid.pushWindowDown},
  {'K', hs.grid.pushWindowUp},
  {'H', hs.grid.pushWindowLeft},
  {'L', hs.grid.pushWindowRight}
}

for i, lay in ipairs(mainBindings) do
  k:bind({}, lay[1], function() lay[2](); end)
end

sBindings = {
  {'J', hs.grid.resizeWindowTaller},
  {'H', function ()
      hs.grid.pushWindowLeft();
      hs.grid.resizeWindowWider();
    end
  },
  {'K', hs.grid.resizeWindowShorter},
  {'L', function ()
      hs.grid.resizeWindowThinner();
      hs.grid.pushWindowRight();
    end
  },
}

dBindings = {
  {'J', hs.grid.resizeWindowTaller},
  {'H', hs.grid.resizeWindowThinner},
  {'K', hs.grid.resizeWindowShorter},
  {'L', hs.grid.resizeWindowWider},
}

for b, lay in ipairs(dBindings) do
  d:bind({}, lay[1], function() lay[2](); end)
end

fBindings = {
  {'J', hs.window.focusWindowSouth},
  {'H', hs.window.focusWindowWest},
  {'K', hs.window.focusWindowNorth},
  {'L', hs.window.focusWindowEast},
}

for b, lay in ipairs(fBindings) do
  f:bind({}, lay[1], function() quitAll(); lay[2](); end)
end

eBindings = {
  {'J', function ()
      hs.grid.resizeWindowShorter();
      hs.grid.pushWindowDown();
    end
  },
  {'H', hs.grid.resizeWindowThinner},
  {'K', function ()
      hs.grid.pushWindowUp();
      hs.grid.resizeWindowTaller();
    end
  },
  {'L', hs.grid.resizeWindowWider},
}

for b, lay in ipairs(eBindings) do
  e:bind({}, lay[1], function() lay[2](); end)
end

wBindings = {
  {'J', function ()
      hs.grid.resizeWindowShorter();
      hs.grid.pushWindowDown();
    end
  },
  {'H', function ()
      hs.grid.pushWindowLeft();
      hs.grid.resizeWindowWider();
    end
  },
  {'K', function ()
      hs.grid.pushWindowUp();
      hs.grid.resizeWindowTaller();
    end
  },
  {'L', function ()
      hs.grid.resizeWindowThinner();
      hs.grid.pushWindowRight();
    end
  },
}

pBindings = {
  {'H', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = 0, y = 0, w = rem, h = hs.grid.GRIDHEIGHT}, screen)
    end
  },
  {'J', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = 1, y = 1, w = rem - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  },
  {'K', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = wide, y = 1, w = rem - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  },
  {'L', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = wide, y = 0, w = rem, h = hs.grid.GRIDHEIGHT}, screen)
    end
  }
}

for b, lay in ipairs(pBindings) do
  p:bind({}, lay[1], function() lay[2](); quitAll(); end)
end

uBindings = {
  {'H', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 2)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = 0, y = 0, w = wide, h = hs.grid.GRIDHEIGHT}, screen)
    end
  },
  {'J', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 2)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = 1, y = 1, w = rem - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  },
  {'K', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 2)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = wide, y = 1, w = rem - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  },
  {'L', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 2)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = wide, y = 0, w = rem, h = hs.grid.GRIDHEIGHT}, screen)
    end
  }
}

for b, lay in ipairs(uBindings) do
  u:bind({}, lay[1], function() lay[2](); quitAll(); end)
end

-- Small Positional Layouts
iBindings = {
  {'H', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = 0, y = 0, w = wide, h = hs.grid.GRIDHEIGHT}, screen)
    end
  },
  {'J', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = 1, y = 1, w = wide - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  },
  {'K', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = rem, y = 1, w = wide - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  },
  {'L', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = rem, y = 0, w = wide, h = hs.grid.GRIDHEIGHT}, screen)
    end
  }
}

for a, lay in ipairs(iBindings) do
  i:bind({}, lay[1], function() lay[2](); i:exit(); k:exit(); end)
end

-- Open applications
apps = {
  {'a', 'Alacritty'},
  {'g', 'Google Chrome'},
  {'c', 'Google Chrome'},
  {'e', 'Mail'},
  {'m', 'Mail'},
  {'t', 'iTerm'},
  {'f', 'Finder'},
  {'s', 'Slack'},
  {'v', 'Visual Studio Code'},
}
for f, app in ipairs(apps) do
  o:bind({}, app[1], function() launch(app[2]); o:exit(); k:exit(); end)
end

-- Shortcut to reload config
rfun = function()
  hs.reload();
  hs.alert.show('Config loaded');
  quitAll();
end
k:bind('', 'r', rfun)

-- Automatic Display Switching
function screensChangedCallback()
  newNumberOfScreens = #hs.screen.allScreens()
  print("Screens Changed to " .. newNumberOfScreens .. ".")

  hs.grid.setGrid('10x8', 'Color LCD');
  hs.grid.setGrid('10x8', 'ASUS PB278');

  if lastNumberOfScreens ~= newNumberOfScreens then
    if newNumberOfScreens == 1 then
      applyLayout(layout1)
    elseif newNumberOfScreens == 2 then
      applyLayout(layout2)
    end
  end

  lastNumberOfScreens = newNumberOfScreens
end

function applyPlace(win, mon, place)
  local scr = hs.screen.find(mon)
  print(scr)
  hs.grid.set(win, place, scr)
end

function applyLayout(layout)

  for key, arr in pairs(layout) do

    local appName = arr[1]
    local monitor = arr[2]
    local placement = arr[3]
    local windowName = arr[4]
    local app = hs.appfinder.appFromName(appName)

    print(appName .. " to " .. monitor .. " windows -> " .. windowName .. ".")

    if app then
        if windowName ~= 'all' then
            local win = hs.appfinder.windowFromWindowTitlePattern("^" .. windowName .. "*")
            if win ~= nil then
                print("Window found for -> " .. win:title())
                applyPlace(win, monitor, placement)
            else
                print("Window not found for " .. windowName)
            end
        else
          for i, win in ipairs(app:allWindows()) do
            local title = win:title()
            if string.match(title, 'Developer Tools') then
              win:close()
            else
              applyPlace(win, monitor, placement)
            end
          end
        end
    end
  end

end

function toggle_app(name)
  log.d(name)
  focused = hs.window.focusedWindow()
  search = hs.application.find(name)
  if focused and search then
    app = focused:application()
    log.d(app:title())
    log.d(search:title())
    if app:title() == search:title() then
      log.d('Hide application')
      search:hide()
      return
    end
  end

  log.d('launchOrFocus', name)
  if name == 'Code' then
    name = 'Visual Studio Code'
  end
  hs.application.launchOrFocus(name)
end

-- Change screens
hs.hotkey.bind({"ctrl", "alt"}, 'LEFT', function()
  focused = hs.window.focusedWindow()
  screen = focused:screen()
  if focused:isFullScreen() then
    focused:setFullScreen(false)
    focused:moveToScreen(screen:toWest())
    hs.timer.doAfter(0.6, function()
      focused:setFullScreen(true)
    end)
  else
    focused:moveToScreen(screen:toWest())
    hs.grid.snap(focused);
  end
end)

hs.hotkey.bind({"ctrl", "alt"}, 'UP', function()
  focused = hs.window.focusedWindow()
  screen = focused:screen()
  if focused:isFullScreen() then
    focsed:setFullScreen(false)
    focused:moveToScreen(screen:toNorth())
    hs.timer.doAfter(0.6, function()
      focused:setFullScreen(true)
    end)
  else
    focused:moveToScreen(screen:toNorth())
    hs.grid.snap(focused);
  end
end)

hs.hotkey.bind({"ctrl", "alt"}, 'RIGHT', function()
  focused = hs.window.focusedWindow()
  screen = focused:screen()
  if focused:isFullScreen() then
    focused:setFullScreen(false)
    focused:moveToScreen(screen:toEast())
    hs.timer.doAfter(0.6, function()
      focused:setFullScreen(true)
    end)
  else
    focused:moveToScreen(screen:toEast())
    hs.grid.snap(focused);
  end
end)

hs.hotkey.bind({"ctrl", "alt"}, 'DOWN', function()
  focused = hs.window.focusedWindow()
  screen = focused:screen()
  if focused:isFullScreen() then
    focused:setFullScreen(false)
    focused:moveToScreen(screen:toSouth())
    hs.timer.doAfter(0.6, function()
      focused:setFullScreen(true)
    end)
  else
    focused:moveToScreen(screen:toSouth())
    hs.grid.snap(focused);
  end
end)

-- window hints
-- hs.hotkey.bind({"cmd", "shift"}, "return", function()
--   hs.hints.windowHints(nil);
-- end)

hs.hotkey.bind({"cmd", "alt"}, "return", function()
  local chrome = hs.application.find('Google Chrome')
  local firefox = hs.application.find('Firefox')
  local safari = hs.application.find('Safari')

  if chrome ~= nil and chrome:isRunning() then
    toggle_app('Google Chrome')
    return
  elseif firefox ~= nil and firefox:isRunning() then
    toggle_app('Firefox')
    return
  elseif safari ~= nil and safari:isRunning() then
    toggle_app('Safari')
    return
  end

  toggle_app('Google Chrome')
end)

hs.hotkey.bind({"cmd", "alt"}, "t", function()
  toggle_app('Todoist')
end)

hs.hotkey.bind({"alt"}, "return", function()
  local vscode = hs.application.find('Code')
  local iterm = hs.application.find('iTerm')
  local alacritty = hs.application.find('Alacritty')

  if iterm ~= nil and iterm:isRunning() then
    toggle_app('iTerm')
    return
  elseif vscode ~= nil and vscode:isRunning() then
    toggle_app('Code')
    return
  elseif alacritty ~= nil and alacritty:isRunning() then
    toggle_app('Alacritty')
    return
  end

  toggle_app('iTerm')
end)

-- screenWatcher = hs.screen.watcher.new(screensChangedCallback)
-- screenWatcher:start()

-- Logging Utility
function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end
