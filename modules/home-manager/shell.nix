{inputs, ...}: {
  scheme = "${inputs.tt-schemes}/base16/bright.yaml";

  programs.dircolors.enable = true;

  home.shellAliases = {
    ".." = "cd ..";
    l = "ls --color=auto -lFh";
    ll = "ls --color=auto -lFa";
    lt = "tree";
    ltt = "tree -ashpug";

    df = "df -h";
    du = "du -h";
    free = "free -h";

    lb = "lsblk";

    q = "exit";
    c = "clear";

    tok = "tomb open -k -";
    v = "$EDITOR";
    t = "cat $HOME/notebook/todo.txt";
    tt = "$EDITOR $HOME/notebook/todo.txt";
    mx = "pulsemixer";

    stripexif = "exiftool -all=";
    today = "date '+%Y-%m-%d'";

    f = "nnn";
  };

  programs.zsh = {
    enable = true;

    initExtraBeforeCompInit = ''
      zstyle ':completion:*' completer _expand _complete _ignored _approximate
      zstyle ':completion:*' completions 1
      zstyle ':completion:*' format %B%U%F{yellow}%d%f%u%b
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' list-prompt %S%F{yellow}At %p: Hit TAB for more%f%s
      zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
      zstyle ':completion:*' menu select=1
      zstyle ':completion:*' select-prompt %S%F{yellow}%p %l%f%s
      zstyle ':completion:*' verbose true
      zstyle :compinstall filename '/home/dan/.zshrc'
    '';

    initContent = ''
      # Vi style key bindings
      bindkey -v
      KEYTIMEOUT=10

      function zle-line-init zle-keymap-select {
        PROMPT_VI_MODE="''${''${KEYMAP/vicmd/N}/(main|viins)/I}"
        PROMPT_VI_COLOR="''${''${KEYMAP/vicmd/blue}/(main|viins)/green}"
        zle reset-prompt
      }

      zle -N zle-line-init
      zle -N zle-keymap-select

      # Use Vi style navigation in menu completion
      zmodload zsh/complist
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      # Prompts
      if (( ''${+SSH_CONNECTION} )); then
        PROMPT_HOSTNAME_COLOR='magenta'
      else
        PROMPT_HOSTNAME_COLOR='yellow'
      fi

      setopt PROMPT_SUBST
      PROMPT='%B%F{cyan}%n%f%b at %B%F{$PROMPT_HOSTNAME_COLOR}%m%f%b in %B%F{blue}%~%f%b [%B%F{$PROMPT_VI_COLOR}$PROMPT_VI_MODE%f%b]%B>%b '
      RPROMPT='%(?..%F{red}%?%f  )%F{green}%D{%H:%M:%S}%f'

      _fzf_complete_pass() {
        args=$@
        if [[ $args == 'p'*'otp'* ]]; then
          _fzf_complete --prompt="otp> " -- "$@" < <(
            find "$PASSWORD_STORE_DIR" -name "*otp.gpg" -printf "%P\n" | sed -e "s/\.gpg//g"
          )
        elif [[ $args == 'p'*'edit'* ]]; then
          _fzf_complete --prompt="everyting> " -- "$@" < <(
            find "$PASSWORD_STORE_DIR" -name "*.gpg" -printf "%P\n" | sed -e "s/\.gpg//g"
          )
        else
          _fzf_complete --prompt="everyting(-otp)> " -- "$@" < <(
            find "$PASSWORD_STORE_DIR" -name "*.gpg" -not -name "*otp.gpg" -printf "%P\n" | sed -e "s/\.gpg//g"
          )
        fi
      }
      _fzf_complete_p() { _fzf_complete_pass $@ }
    '';
  };
}
