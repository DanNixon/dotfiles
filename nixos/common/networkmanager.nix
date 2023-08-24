{ ... }: {
  networking.nftables.enable = true;
  networking.firewall.enable = true;

  networking.networkmanager.enable = true;

  users.users.dan.extraGroups = [ "networkmanager" ];
}
