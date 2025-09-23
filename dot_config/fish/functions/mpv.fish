function mpv -w mpv
  command mpv $argv; osascript -l JavaScript -e 'Application("iTerm2").activate()' &> /dev/null
end
