{...}: {
  networking.nftables.enable = true;
  networking.firewall.enable = true;

  networking.networkmanager.enable = true;
  users.users.dan.extraGroups = ["networkmanager"];

  services.dnscrypt-proxy = {
    enable = true;

    settings = {
      fallback_resolvers = ["9.9.9.9:53" "1.1.1.1:53"];
      ignore_system_dns = true;

      netprobe_address = "9.9.9.9:53";

      forwarding_rules = "/etc/dnscrypt-proxy2/forwarding-rules.txt";
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  environment.etc."dnscrypt-proxy2/forwarding-rules.txt".text = ''
    castle.dan-nixon.com 100.65.23.56
  '';
}
