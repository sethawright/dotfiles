-----------------------------------------------
-- Set up
-----------------------------------------------

local hyperCtrl = {"shift", "cmd", "ctrl"}
local hyper = {"shift", "cmd", "alt"}

local ding = {"cmd", "ctrl"}
local dingShft = {"cmd", "ctrl", "shift"}

local mash = {"cmd", "alt", "ctrl"}
local mashift = {"cmd", "alt", "ctrl", "shift"}

local turbo = {"cmd", "alt"}
local turboShft = {"cmd", "alt", "shift"}

screenWatcher = nil
appWatcher = nil

local step = 10
local stepBig = 100

local display_macbook = 'Color LCD'
local display_asus = 'ASUS PB278'
local lastNumberOfScreens = #hs.screen.allScreens()

focusMode = false

hs.grid.MARGINX = 20
hs.grid.MARGINY = 20
hs.grid.GRIDHEIGHT = 8
hs.grid.GRIDWIDTH = 10

local lay_big = {x = 0, y = 0, w = hs.grid.GRIDWIDTH, h = hs.grid.GRIDHEIGHT}
local lay_med = {x = 1, y = 1, w = hs.grid.GRIDWIDTH - 2, h = hs.grid.GRIDHEIGHT - 2}
local lay_side_big = {x = 1, y = 1, w = math.floor(hs.grid.GRIDWIDTH / 3), h = hs.grid.GRIDHEIGHT - 2}
local lay_side_sm = {x = 1, y = 1, w = math.floor(hs.grid.GRIDWIDTH / 3) - 1, h = hs.grid.GRIDHEIGHT - 2}

hs.window.animationDuration = 0
hs.hints.showTitleThresh = 0

  -- App name, display, grid layout, window name, go to full screen?
layout1 = {
  {'Google Chrome', display_macbook, lay_big, 'all'},
  {'Safari', display_macbook, lay_big, 'all'},
  {'Firefox', display_macbook, lay_big, 'all'},
  {'Sublime Text', display_macbook, lay_big, 'all'},
  {'iTerm2', display_macbook, lay_big, 'all', true},
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

-----------------------------------------------
-- Display Switching
-----------------------------------------------

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
    local fullScreen = arr[5]
    local app = hs.appfinder.appFromName(appName)

    print(appName .. " to " .. monitor .. " windows -> " .. windowName .. ".")

    if app then
        if windowName ~= 'all' then
            local win = hs.appfinder.windowFromWindowTitlePattern(windowName .. "*")
            if win ~= nil then
                applyPlace(win, monitor, placement)
            else
                print("Window not found for " .. windowName)
            end

            if fullScreen ~= nil then
              win:setFullScreen(fullScreen)
            end
        else
          for i, win in ipairs(app:allWindows()) do
            local title = win:title()
            if string.match(title, 'Developer Tools') then
              win:close()
            else
              applyPlace(win, monitor, placement)
              if fullScreen ~= nil then
                win:setFullScreen(fullScreen)
              end
            end
          end
        end
    end
  end

end

-----------------------------------------------
-- Fullscreen Windows
-----------------------------------------------

hs.hotkey.bind(hyper, "return", function()
  hs.grid.maximizeWindow()
end)

hs.hotkey.bind(hyper, "1", function()
  applyLayout(layout1)
end)

hs.hotkey.bind(hyper, "2", function()
  applyLayout(layout2)
end)

hs.hotkey.bind(turbo, "return", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  hs.grid.set(win, {x = 1, y = 1, w = hs.grid.GRIDWIDTH - 2, h = hs.grid.GRIDHEIGHT - 2}, screen)
end)

-----------------------------------------------
-- Snap windows
-----------------------------------------------

hs.hotkey.bind(mash, ';', function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(mash, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)

-----------------------------------------------
-- Move windows to grid
-----------------------------------------------

hs.hotkey.bind(mash, 'J', hs.grid.pushWindowDown)
hs.hotkey.bind(mash, 'K', hs.grid.pushWindowUp)
hs.hotkey.bind(mash, 'H', hs.grid.pushWindowLeft)
hs.hotkey.bind(mash, 'L', hs.grid.pushWindowRight)

-----------------------------------------------
-- Resize windows to grid
-----------------------------------------------

hs.hotkey.bind(mashift, 'K', hs.grid.resizeWindowShorter)
hs.hotkey.bind(mashift, 'J', hs.grid.resizeWindowTaller)
hs.hotkey.bind(mashift, 'L', hs.grid.resizeWindowWider)
hs.hotkey.bind(mashift, 'H', hs.grid.resizeWindowThinner)

-----------------------------------------------
-- 5/7 2/7 convenient window placement
-----------------------------------------------

hs.hotkey.bind(hyper, 'LEFT', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()

  local wide = math.floor(hs.grid.GRIDWIDTH / 3)
  local rem = hs.grid.GRIDWIDTH - wide

  hs.grid.set(win, {x = 0, y = 0, w = rem, h = hs.grid.GRIDHEIGHT}, screen)
end)

hs.hotkey.bind(hyper, 'RIGHT', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()

  local wide = math.floor(hs.grid.GRIDWIDTH / 3)
  local rem = hs.grid.GRIDWIDTH - wide

  hs.grid.set(win, {x = wide, y = 0, w = rem, h = hs.grid.GRIDHEIGHT}, screen)
end)

hs.hotkey.bind(dingShft, 'LEFT', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()

  local wide = math.floor(hs.grid.GRIDWIDTH / 3)
  local rem = hs.grid.GRIDWIDTH - wide

  hs.grid.set(win, {x = 0, y = 0, w = wide, h = hs.grid.GRIDHEIGHT}, screen)
end)

hs.hotkey.bind(dingShft, 'RIGHT', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()

  local wide = math.floor(hs.grid.GRIDWIDTH / 3)
  local rem = hs.grid.GRIDWIDTH - wide

  hs.grid.set(win, {x = rem, y = 0, w = wide, h = hs.grid.GRIDHEIGHT}, screen)
end)

hs.hotkey.bind(turbo, 'LEFT', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()

  local wide = math.floor(hs.grid.GRIDWIDTH / 3)
  local rem = hs.grid.GRIDWIDTH - wide

  hs.grid.set(win, {x = 1, y = 1, w = rem - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
end)

hs.hotkey.bind(turbo, 'RIGHT', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()

  local wide = math.floor(hs.grid.GRIDWIDTH / 3)
  local rem = hs.grid.GRIDWIDTH - wide

  hs.grid.set(win, {x = wide, y = 1, w = rem - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
end)

hs.hotkey.bind(ding, 'LEFT', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()

  local wide = math.floor(hs.grid.GRIDWIDTH / 3)
  local rem = hs.grid.GRIDWIDTH - wide

  hs.grid.set(win, {x = 1, y = 1, w = wide - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
end)

hs.hotkey.bind(ding, 'RIGHT', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()

  local wide = math.floor(hs.grid.GRIDWIDTH / 3)
  local rem = hs.grid.GRIDWIDTH - wide

  hs.grid.set(win, {x = rem, y = 1, w = wide - 1, h = hs.grid.GRIDHEIGHT - 2}, screen)
end)

-----------------------------------------------
-- Change screens
-----------------------------------------------

hs.hotkey.bind({"ctrl", "alt"}, 'LEFT', hs.grid.pushWindowPrevScreen)
hs.hotkey.bind({"ctrl", "alt"}, 'RIGHT', hs.grid.pushWindowNextScreen)

-----------------------------------------------
--- Free Movements
-----------------------------------------------

hs.hotkey.bind(mash, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - step
  win:setFrame(f, 0)
end)

hs.hotkey.bind(mash, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + step
  win:setFrame(f, 0)
end)

hs.hotkey.bind(mash, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - step
  win:setFrame(f, 0)
end)

hs.hotkey.bind(mash, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + step
  win:setFrame(f, 0)
end)

hs.hotkey.bind(mashift, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - stepBig
  win:setFrame(f, 0)
end)

hs.hotkey.bind(mashift, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + stepBig
  win:setFrame(f, 0)
end)

hs.hotkey.bind(mashift, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - stepBig
  win:setFrame(f, 0)
end)

hs.hotkey.bind(mashift, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + stepBig
  win:setFrame(f, 0)
end)

function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated or eventType == hs.application.watcher.launched) then

      if (focusMode) then
          print('Application changed to ' .. appName)

          hs.fnutils.each(hs.window:visibleWindows(), function(win)
            local app = win:application()
            local nm = app:title()
            if nm ~= appName then
                app:hide()
            end
          end)
      end

  end
end

hs.hotkey.bind('cmd', "\\", function()
    focusMode = not focusMode
    if (focusMode) then
        hs.alert.show('Focus Mode On')
        local focused = hs.window.frontmostWindow()
        hs.fnutils.each(hs.window:visibleWindows(), function(win)
            if win ~= focused then
                local app = win:application()
                app:hide()
            end
        end)
    else
        hs.alert.show('Focus Mode Off')
    end
end)

appWatcher = hs.application.watcher.new(applicationWatcher):start()
screenWatcher = hs.screen.watcher.new(screensChangedCallback)
screenWatcher:start()

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

-----------------------------------------------
-- Show window hints
-----------------------------------------------

hs.hotkey.bind({"cmd"}, "escape", function()
  hs.hints.windowHints()
end)

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
