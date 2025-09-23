-- ExpandMode
-- Resize windows without using the mouse
-- Toggled with cmd-alt-ctrl-shift-e
--   j
-- h g l
--   k
-- Shift contracts
-- Cmd does "fine" adjustments

function resizeWindowDirection(side, amount)
  local win = hs.window.focusedWindow()
  local frame = win:frame()

  if side == 's' then
    frame.h = frame.h + amount
  elseif side == 'e' then
    frame.w = frame.w + amount
  elseif side == 'n' then
    frame.h = frame.h + amount
    frame.y = frame.y - amount
  elseif side == 'w' then
    frame.w = frame.w + amount
    frame.x = frame.x - amount
  end

  win:setFrame(frame)
end

local expandMode = hs.hotkey.modal.new('cmd-alt-ctrl-shift', 'e')

function expandMode:entered()
  hs.alert('Expand Mode')
end

function expandMode:exited()
  hs.alert('Exited Expand Mode')
end

expandMode:bind('', 'escape', function()
  expandMode:exit()
end)

local expandWest = function()
  resizeWindowDirection('w', 50)
end
expandMode:bind('', 'h', expandWest, nil, expandWest)

local expandWestFine = function()
  resizeWindowDirection('w', 1)
end
expandMode:bind('cmd', 'h', expandWestFine, nil, expandWestFine)

local expandSouth = function()
  resizeWindowDirection('s', 50)
end
expandMode:bind('', 'j', expandSouth, nil, expandSouth)

local expandSouthFine = function()
  resizeWindowDirection('s', 1)
end
expandMode:bind('cmd', 'j', expandSouthFine, nil, expandSouthFine)

local expandNorth = function()
  resizeWindowDirection('n', 50)
end
expandMode:bind('', 'k', expandNorth, nil, expandNorth)

local expandNorthFine = function()
  resizeWindowDirection('n', 1)
end
expandMode:bind('cmd', 'k', expandNorthFine, nil, expandNorthFine)

local expandEast = function()
  resizeWindowDirection('e', 50)
end
expandMode:bind('', 'l', expandEast, nil, expandEast)

local expandEastFine = function()
  resizeWindowDirection('e', 1)
end
expandMode:bind('cmd', 'l', expandEastFine, nil, expandEastFine)

local expandAll = function()
  resizeWindowDirection('e', 25)
  resizeWindowDirection('w', 25)
  resizeWindowDirection('n', 25)
  resizeWindowDirection('s', 25)
end
expandMode:bind('', 'g', expandAll, nil, expandAll)

local expandAllFine = function()
  resizeWindowDirection('e', 1)
  resizeWindowDirection('w', 1)
  resizeWindowDirection('n', 1)
  resizeWindowDirection('s', 1)
end
expandMode:bind('cmd', 'g', expandAllFine, nil, expandAllFine)

local contractWest = function()
  resizeWindowDirection('w', -50)
end
expandMode:bind('shift', 'h', contractWest, nil, contractWest)

local contractWestFine = function()
  resizeWindowDirection('w', -1)
end
expandMode:bind('shift+cmd', 'h', contractWestFine, nil, contractWestFine)

local contractSouth = function()
  resizeWindowDirection('s', -50)
end
expandMode:bind('shift', 'j', contractSouth, nil, contractSouth)

local contractSouthFine = function()
  resizeWindowDirection('s', -1)
end
expandMode:bind('shift+cmd', 'j', contractSouthFine, nil, contractSouthFine)

local contractNorth = function()
  resizeWindowDirection('n', -50)
end
expandMode:bind('shift', 'k', contractNorth, nil, contractNorth)

local contractNorthFine = function()
  resizeWindowDirection('n', -1)
end
expandMode:bind('shift+cmd', 'k', contractNorthFine, nil, contractNorthFine)

local contractEast = function()
  resizeWindowDirection('e', -50)
end
expandMode:bind('shift', 'l', contractEast, nil, contractEast)

local contractEastFine = function()
  resizeWindowDirection('e', -1)
end
expandMode:bind('shift+cmd', 'l', contractEastFine, nil, contractEastFine)

local contractAll = function()
  resizeWindowDirection('e', -25)
  resizeWindowDirection('w', -25)
  resizeWindowDirection('n', -25)
  resizeWindowDirection('s', -25)
end
expandMode:bind('shift', 'g', contractAll, nil, contractAll)

local contractAllFine = function()
  resizeWindowDirection('e', -1)
  resizeWindowDirection('w', -1)
  resizeWindowDirection('n', -1)
  resizeWindowDirection('s', -1)
end
expandMode:bind('shift+cmd', 'g', contractAllFine, nil, contractAllFine)
