{ lib, ... }: {
  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };

    openFirewall = lib.mkDefault true;
  };
}
