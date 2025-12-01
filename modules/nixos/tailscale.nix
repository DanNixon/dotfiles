{...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  services.dnscrypt-proxy.settings.forwarding_rules = "/etc/dnscrypt-proxy2/forwarding-rules.txt";
  environment.etc."dnscrypt-proxy2/forwarding-rules.txt".text = ''
    castle.dan-nixon.com 100.65.23.56
  '';
}
