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

local step = 10
local stepBig = 100

hs.grid.MARGINX = 20
hs.grid.MARGINY = 20
hs.grid.GRIDHEIGHT = 9
hs.grid.GRIDWIDTH = 16

hs.window.animationDuration = 0
hs.hints.showTitleThresh = 0

-----------------------------------------------
-- Fullscreen Windows
-----------------------------------------------

hs.hotkey.bind(hyper, "return", function()
    hs.grid.maximizeWindow()
end)

hs.hotkey.bind(turbo, "return", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    hs.grid.set(win, {x = 1, y = 1, w = hs.grid.GRIDWIDTH - 2, h = hs.grid.GRIDHEIGHT - 2}, screen)
end)

-----------------------------------------------
-- Change grid sizing
-----------------------------------------------

hs.hotkey.bind(hyper, '=', function() hs.grid.adjustNumberOfRows( 1) end)
hs.hotkey.bind(hyper, '-', function() hs.grid.adjustNumberOfRows(-1) end)
hs.hotkey.bind(mash, '=', function() hs.grid.adjustNumberOfColumns( 1) end)
hs.hotkey.bind(mash, '-', function() hs.grid.adjustNumberOfColumns(-1) end)

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

hs.hotkey.bind({"ctrl", "alt"}, 'LEFT', hs.grid.pushWindowNextScreen)
hs.hotkey.bind({"ctrl", "alt"}, 'RIGHT', hs.grid.pushWindowPrevScreen)

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

--- resize ----
hs.hotkey.bind(turbo, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w - step
  win:setFrame(f)
end)

hs.hotkey.bind(turbo, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w + step

  win:setFrame(f)
end)

hs.hotkey.bind(turbo, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h - step
  win:setFrame(f)
end)

hs.hotkey.bind(turbo, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h + step
  win:setFrame(f)
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

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")

-----------------------------------------------
-- Show window hints
-----------------------------------------------

hs.hotkey.bind({"cmd"}, "escape", function()
    hs.hints.windowHints()
end)
