{ ... }: {
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--no-mouse"
      "--cycle"
      "--bind tab:up,btab:down"
    ];
  };
}
