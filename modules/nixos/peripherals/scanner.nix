{...}: {
  hardware.sane.enable = true;

  dotfiles.dan.groups = ["dialout" "scanner" "lp"];
}
