{...}: {
  programs.adb.enable = true;

  dotfiles.dan.groups = ["adbusers"];
}
