require 'expandmode'
require 'movemode'

require 'hs.alert'
require "hs.ipc"
if not hs.ipc.cliInstall() then
  print('CLI load failed, trying cleanup and load')
  hs.ipc.cliUninstall()
  if hs.ipc.cliInstall() then
    print('CLI load succeeded!') 
  end
end

local super = {'ctrl', 'alt', 'cmd', 'shift'}
