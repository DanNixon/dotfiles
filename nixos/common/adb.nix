{...}: {
  programs.adb.enable = true;

  users.users.dan.extraGroups = ["adbusers"];
}
