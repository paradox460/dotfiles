function gjc --description "Clone a GitHub repo and initialize jj with git colocate"
    if set -q argv[2]
        set clonedDirName $argv[2]
    else
        set clonedDirName (path basename -E $argv[1])
    end
    gh repo clone $argv[1] $clonedDirName
    and cd $clonedDirName
    and jj git init --colocate
end