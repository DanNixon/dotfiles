{...}: {
  networking.nftables.enable = true;
  networking.firewall.enable = true;

  networking.networkmanager.enable = true;

  dotfiles.dan.groups = ["networkmanager"];
}
