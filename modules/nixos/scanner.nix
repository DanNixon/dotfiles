{...}: {
  users.users.dan.extraGroups = ["dialout" "scanner" "lp"];

  hardware.sane.enable = true;
}
