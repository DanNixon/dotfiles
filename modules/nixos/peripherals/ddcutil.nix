{...}: {
  hardware.i2c.enable = true;

  dotfiles.dan.groups = ["i2c"];
}
