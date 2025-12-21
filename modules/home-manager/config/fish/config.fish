set -U fish_greeting

if status is-interactive
    abbr -a -- .. 'cd ..'
    abbr -a -- c clear
    abbr -a -- df 'df -h'
    abbr -a -- du 'du -h'
    abbr -a -- f nnn
    abbr -a -- free 'free -h'
    abbr -a -- g git
    abbr -a -- gs 'git s'
    abbr -a -- k kubectl
    abbr -a -- kk k9s
    abbr -a -- l 'ls --color=auto -lFh'
    abbr -a -- lb lsblk
    abbr -a -- lg lazygit
    abbr -a -- ll 'ls --color=auto -lFa'
    abbr -a -- lt tree
    abbr -a -- ltt 'tree -ashpug'
    abbr -a -- mx pulsemixer
    abbr -a -- p koishi
    abbr -a -- q exit
    abbr -a -- stripexif 'exiftool -all '
    abbr -a -- t 'cat $HOME/notebook/todo.txt'
    abbr -a -- today 'date '\''+%Y-%m-%d'\'''
    abbr -a -- tok 'tomb open -k -'
    abbr -a -- tt '$EDITOR $HOME/notebook/todo.txt'
    abbr -a -- v '$EDITOR'
end

# TODO: direnv
# TODO: fzf
