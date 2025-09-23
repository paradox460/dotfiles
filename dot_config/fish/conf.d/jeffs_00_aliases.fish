# Launch a new fish shell, we pretend we're reloading configuration
alias reload 'exec fish -l'

alias git hub

alias vim nvim

alias ff_duration 'ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1'
alias ff_frames 'ffprobe -v error -select_streams v:0 -count_frames -show_entries stream=nb_read_frames -print_format default=nokey=1:noprint_wrappers=1'

alias lg 'lazygit'

alias yoink 'open -a Yoink'

alias current-issue 'git rev-parse --abbrev-ref HEAD | gsed -E "s/.*\/(.*?)\/.*/\1/"'

alias zq 'zoxide query'

alias kbm '/Applications/Keyboard\ Maestro.app/Contents/MacOS/keyboardmaestro'
