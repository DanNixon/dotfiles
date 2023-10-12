{...}: {
  hardware.i2c.enable = true;
  users.users.dan.extraGroups = ["i2c"];
}
