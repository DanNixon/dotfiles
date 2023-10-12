{...}: {
  hardware.sane.enable = true;

  users.users.dan.extraGroups = ["dialout" "scanner" "lp"];
}
