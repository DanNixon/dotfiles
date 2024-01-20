{...}: {
  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--no-mouse"
      "--cycle"
    ];
  };
}
