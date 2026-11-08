function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end

    set_color --bold cyan
    printf '%s' $USER
    set_color normal
    printf ' at '

    set_color --bold yellow
    echo -n (prompt_hostname)
    set_color normal
    printf ' in '

    set_color --bold blue
    printf '%s' (prompt_pwd --full-length-dirs 3)
    set_color normal

    set_color --bold white
    printf ' > '
    set_color normal
end
