{...}: {
  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--cycle"
    ];
  };
}
