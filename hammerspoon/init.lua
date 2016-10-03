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
  {'Google Chrome', display_macbook, lay_big, 'all'},
  {'Safari', display_macbook, lay_big, 'all'},
  {'Firefox', display_macbook, lay_big, 'all'},
  {'Sublime Text', display_macbook, lay_big, 'all'},
  {'iTerm2', display_macbook, lay_big, 'all'},
  {'Messages', display_macbook, {x=1, y=2, w=2, h=4}, "Messages"},
  {'Messages', display_macbook, {x=0, y=2, w=1, h=4}, "Google Talk List"},
  {'Spotify', display_macbook, lay_med, "all"},
  {'Mail', display_macbook, lay_med, "all"},
  {'Sequel Pro', display_macbook, lay_med, "all"},
  {'MacVim', display_macbook, lay_side_big, "all"}
}

layout2 = {
  {'Google Chrome', display_macbook, lay_big, 'all'},
  {'Safari', display_macbook, lay_big, 'all'},
  {'Firefox', display_macbook, lay_big, 'all'},
  {'Sublime Text', display_asus, lay_big, 'all'},
  {'iTerm2', display_asus, lay_big, 'all'},
  {'Messages', display_macbook, {x=1, y=2, w=2, h=4}, "Messages"},
  {'Messages', display_macbook, {x=0, y=2, w=1, h=4}, "Google Talk List"},
  {'Spotify', display_macbook, lay_big, "all"},
  {'Mail', display_macbook, lay_big, "all"},
  {'Sequel Pro', display_asus, lay_med, "all"},
  {'MacVim', display_asus, lay_side_sm, "all"}
}

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F19")

launch = function(appname)
  hs.application.launchOrFocus(appname)
  k.triggered = true
end

-- Single keybinding for functions
singlelayouts = {
  {'1', function() applyLayout(layout1); end},
  {'2', function() applyLayout(layout2); end},
  {'RETURN', hs.grid.maximizeWindow},
  {'J', hs.grid.resizeWindowTaller},
  {'H', hs.grid.resizeWindowThinner},
  {'K', hs.grid.resizeWindowShorter},
  {'L', hs.grid.resizeWindowWider},
  {'DOWN', hs.grid.pushWindowDown},
  {'UP', hs.grid.pushWindowUp},
  {'LEFT', hs.grid.pushWindowLeft},
  {'RIGHT', hs.grid.pushWindowRight}
}

for i, lay in ipairs(singlelayouts) do
  k:bind({}, lay[1], function() lay[2](); end)
end

-- Positional Layouts
p = hs.hotkey.modal.new({}, "F15")
doublelayouts = {
  {'C', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      hs.grid.set(win, {x = 1, y = 1, w = hs.grid.GRIDWIDTH - 2, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  },
  {'H', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = 0, y = 0, w = rem, h = hs.grid.GRIDHEIGHT}, screen)
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
  {'F', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = rem, y = 1, w = wide - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  },
  {'D', function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local wide = math.floor(hs.grid.GRIDWIDTH / 3)
      local rem = hs.grid.GRIDWIDTH - wide
      hs.grid.set(win, {x = 1, y = 1, w = wide - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
    end
  }
}

for i, lay in ipairs(doublelayouts) do
  p:bind({}, lay[1], function() lay[2](); p:exit(); end)
end

pressedP = function() p:enter() end
releasedP = function() end
k:bind({}, 'p', nil, pressedP, releasedP)

-- Open applications
o = hs.hotkey.modal.new({}, "F16")
apps = {
  {'c', 'Google Chrome'},
  {'e', 'Mail'},
  {'t', 'iTerm'},
  {'f', 'Finder'},
  {'s', 'Spotify'},
  {'m', 'Messages'},
}
for i, app in ipairs(apps) do
  o:bind({}, app[1], function() launch(app[2]); o:exit(); end)
end

pressedA = function() o:enter() end
releasedA = function() end
k:bind({}, 'o', nil, pressedA, releasedA)

-- Shortcut to reload config
rfun = function()
  hs.reload()
  hs.alert.show("Config loaded")
  k.triggered = true
end
k:bind({}, 'r', nil, rfun)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- Automatic Display Switching
function screensChangedCallback()
  newNumberOfScreens = #hs.screen.allScreens()
  print("Screens Changed to " .. newNumberOfScreens .. ".")

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

-- Reload config on write
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

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
