{ ... }: {
  programs.tmux = {
    enable = true;
    escapeTime = 1;
    prefix = "M-Space";
    baseIndex = 1;
    extraConfig = ''
      bind-key -T root M-";" choose-tree -Z

      bind-key -T root M-h select-pane -L
      bind-key -T root M-j select-pane -D
      bind-key -T root M-k select-pane -U
      bind-key -T root M-l select-pane -R


      set-option -g status "on"
      set-option -g status-interval 1
      set-option -g status-style fg=colour7

      set-option -g pane-border-style fg=colour7
      set-option -g pane-active-border-style fg=colour3

      set-option -g message-style fg=colour0,bg=colour2
      set-option -g message-command-style fg=colour0,bg=colour4

      # Pane number display
      set-option -g display-panes-active-colour colour3
      set-option -g display-panes-colour colour7

      set-window-option -g window-status-bell-style bg=colour1,fg=colour0

      set-option -g status-left "#[fg=colour0, bg=colour2]#{?client_prefix,#[bg=colour4][P],[.]}#[fg=colour5, bg=colour0] "
      set-option -g status-right "#[fg=colour5][ #S ] #[fg=colour6][ %H:%M:%S ]"

      set-window-option -g window-status-format "[ #I #W ]"
      set-window-option -g window-status-current-format "#[fg=colour3, bold][(#I) #W ]"
    '';
  };
}
