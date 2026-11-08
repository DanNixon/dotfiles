set -U fish_greeting

set -gx XDG_BIN_HOME "$HOME/.local/bin"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

if status is-interactive
    set -gx COMMA_PICKER fzf
    set -gx EDITOR hx
    set -gx FZF_DEFAULT_OPTS --cycle
    set -gx SOPS_AGE_KEY_CMD 'age-plugin-yubikey -i'

    if command -v fzf &>/dev/null
        eval "$(fzf --fish)"
    end

    if command -v direnv &>/dev/null
        eval "$(direnv hook fish)"
    end

    abbr -a -- .. 'cd ..'
    abbr -a -- c clear
    abbr -a -- df 'df -h'
    abbr -a -- du 'du -h'
    abbr -a -- f yazi
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
    abbr -a -- stripexif 'exiftool -all= '
    abbr -a -- t 'cat $HOME/notebook/todo.txt'
    abbr -a -- today 'date '\''+%Y-%m-%d'\'''
    abbr -a -- tok 'tomb open -k -'
    abbr -a -- tt 'hx $HOME/notebook/todo.txt'
    abbr -a -- e hx
end
