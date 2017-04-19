-- Layout configuration
local step = 10
local stepBig = 100

-- No window animations
hs.window.animationDuration = 0
hs.hints.showTitleThresh = 0

local display_macbook = 'Color LCD'
local display_asus = 'ASUS PB278'
local lastNumberOfScreens = #hs.screen.allScreens()

hs.grid.MARGINX = 10
hs.grid.MARGINY = 10
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
  {'iTerm', display_macbook, lay_big, 'all'},
  {'Messages', display_macbook, {x=1, y=2, w=2, h=4}, "Messages"},
  {'Messages', display_macbook, {x=0, y=2, w=1, h=4}, "Google Talk List"},
  {'Messages', display_macbook, {x=0, y=2, w=1, h=4}, "Olark"},
  {'Spotify', display_macbook, lay_med, "all"},
  {'Mail', display_macbook, lay_med, "all"},
  {'Spark', display_macbook, lay_med, "all"},
  {'Sequel Pro', display_macbook, lay_med, "all"},
  {'MacVim', display_macbook, lay_side_big, "all"},
  {'Slack', display_macbook, lay_med, "all"}
}

layout2 = {
  {'Google Chrome', display_macbook, lay_big, 'all'},
  {'Mail', display_macbook, lay_big, "all"},
  {'Spark', display_macbook, lay_big, "all"},
  {'Messages', display_macbook, {x=1, y=2, w=2, h=4}, "Messages"},
  {'Messages', display_macbook, {x=0, y=2, w=1, h=4}, "Google Talk List"},
  {'Messages', display_macbook, {x=0, y=2, w=1, h=4}, "Olark"},
  {'Spotify', display_macbook, lay_big, "all"},
  {'Safari', display_macbook, lay_big, 'all'},
  {'Firefox', display_macbook, lay_big, 'all'},
  {'Sublime Text', display_asus, lay_big, 'all'},
  {'iTerm2', display_asus, lay_big, 'all'},
  {'Sequel Pro', display_asus, lay_med, "all"},
  {'MacVim', display_asus, lay_side_sm, "all"},
  {'Slack', display_macbook, lay_big, "all"}
}

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({'cmd'}, 'escape')
function k:entered() s:exit(); o:exit(); i:exit(); p:exit(); end

-- used if you are ok pressing three triggers
s = hs.hotkey.modal.new({'cmd', 'option', 'shift'}, 'u', 'Size')
function s:entered() k:exit(); o:exit(); i:exit(); p:exit(); end

o = hs.hotkey.modal.new({'cmd', 'option', 'shift'}, 'o', 'Open')
function o:entered() k:exit(); s:exit(); i:exit(); p:exit(); end

i = hs.hotkey.modal.new({'cmd', 'option', 'shift'}, 'i', 'Small')
function i:entered() k:exit(); s:exit(); o:exit(); p:exit(); end

p = hs.hotkey.modal.new({'cmd', 'option', 'shift'}, 'p', 'Large')
function p:entered() k:exit(); s:exit(); o:exit(); i:exit(); end

quitAll = function()
    i:exit(); o:exit(); s:exit(); p:exit(); k:exit();
end

-- Bind the Hyper key
k:bind('', 'escape', quitAll)
o:bind('', 'escape', quitAll)
s:bind('', 'escape', quitAll)
i:bind('', 'escape', quitAll)
p:bind('', 'escape', quitAll)

-- used if you want multi key presses like vim/tmux
u = hs.hotkey.modal.new({}, "F18")
pressedS = function() s:enter() end
releasedS = function() end
k:bind({}, 'u', nil, pressedS, releasedS)

p = hs.hotkey.modal.new({}, "F15")
pressedP = function() p:enter() end
releasedP = function() end
k:bind({}, 'p', nil, pressedP, releasedP)

i = hs.hotkey.modal.new({}, "F17")
pressedI = function() i:enter(); end
releasedI = function() end
k:bind({}, 'i', nil, pressedI, releasedI)

o = hs.hotkey.modal.new({}, "F16")
pressedA = function() o:enter() end
releasedA = function() end
k:bind('', 'o', nil, pressedA, releasedA)

launch = function(appname)
  hs.application.launchOrFocus(appname)
  k.triggered = true
end

-- Single keybinding for functions
mainBindings = {
  {'1', function() applyLayout(layout1); k:exit(); end},
  {'2', function() applyLayout(layout2); k:exit(); end},
  {'RETURN', function() hs.grid.maximizeWindow(); k:exit(); end},
  {"'", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      hs.grid.set(win, {x = 1, y = 1, w = hs.grid.GRIDWIDTH - 2, h = hs.grid.GRIDHEIGHT - 2}, screen)
      k:exit();
    end
  },
  {'a', function()
    launch('iTerm'); 
    launch('Messages');
    launch('Slack'); 
    launch('Google Chrome');
    applyLayout(layout1);
    k:exit();
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
  {'H', hs.grid.resizeWindowThinner},
  {'K', hs.grid.resizeWindowShorter},
  {'L', hs.grid.resizeWindowWider},
}

for b, lay in ipairs(sBindings) do
  s:bind({}, lay[1], function() lay[2](); end)
end

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
  p:bind({}, lay[1], function() lay[2](); p:exit(); k:exit(); end)
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
  {'c', 'Google Chrome'},
  {'e', 'Spark'},
  {'t', 'iTerm'},
  {'i', 'iTerm'},
  {'f', 'Finder'},
  {'s', 'Slack'},
  {'m', 'Messages'},
  {'q', 'Sequel Pro'},
  {'p', 'Pages'},
  {'x', 'Xcode'},
  {'r', 'Reminders'},
  {'h', 'Hues'},
  {'v', 'MacVim'},
  {'u', 'Sublime Text'},
}
for f, app in ipairs(apps) do
  o:bind({}, app[1], function() launch(app[2]); o:exit(); k:exit(); end)
end

-- Shortcut to reload config
rfun = function()
  hs.reload();
  hs.alert.show('Config loaded');
  k:exit();
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

-- Change screens
hs.hotkey.bind({"ctrl", "alt"}, 'LEFT', hs.grid.pushWindowPrevScreen)
hs.hotkey.bind({"ctrl", "alt"}, 'RIGHT', hs.grid.pushWindowNextScreen)

screenWatcher = hs.screen.watcher.new(screensChangedCallback)
screenWatcher:start()

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
