set -l brew_root
switch (uname -m)
  case arm64
      set brew_root /opt/homebrew
  case x86_64
      set brew_root /usr/local
end
source (command $brew_root/bin/brew shellenv | psub)
