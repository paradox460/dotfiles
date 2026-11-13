-- MoveMode
-- Move windows without using the mouse
-- Toggled with cmd-alt-ctrl-shift-w
--  j
-- h l
--  k
-- cmd does "fine" adjustments

function moveWindowDirection(side, amount)
  local win = hs.window.focusedWindow()
  local frame = win:frame()

  if side == 's' then
    frame.y = frame.y + amount
  elseif side == 'e' then
    frame.x = frame.x + amount
  elseif side == 'n' then
    frame.y = frame.y - amount
  elseif side == 'w' then
    frame.x = frame.x - amount
  end

  win:setFrame(frame)
end


local moveMode = hs.hotkey.modal.new('cmd-alt-ctrl-shift', 'w')

function moveMode:entered()
  hs.alert('Move Mode')
end

function moveMode:exited()
  hs.alert('Exited Move Mode')
end

moveMode:bind('', 'escape', function()
  moveMode:exit()
end)

local moveWest = function()
  moveWindowDirection('w', 50)
end
moveMode:bind('', 'h', moveWest, nil, moveWest)

local moveWestFine = function()
  moveWindowDirection('w', 1)
end
moveMode:bind('cmd', 'h', moveWestFine, nil, moveWestFine)

local moveNorth = function()
  moveWindowDirection('n', 50)
end
moveMode:bind('', 'k', moveNorth, nil, moveNorth)

local moveNorthFine = function()
  moveWindowDirection('n', 1)
end
moveMode:bind('cmd', 'k', moveNorthFine, nil, moveNorthFine)

local moveSouth = function()
  moveWindowDirection('s', 50)
end
moveMode:bind('', 'j', moveSouth, nil, moveSouth)

local moveSouthFine = function()
  moveWindowDirection('s', 1)
end
moveMode:bind('cmd', 'j', moveSouthFine, nil, moveSouthFine)

local moveEast = function()
  moveWindowDirection('e', 50)
end
moveMode:bind('', 'l', moveEast, nil, moveEast)

local moveEastFine = function()
  moveWindowDirection('e', 1)
end
moveMode:bind('cmd', 'l', moveEastFine, nil, moveEastFine)
