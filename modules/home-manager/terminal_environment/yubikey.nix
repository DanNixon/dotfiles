{pkgs, ...}: {
  home.packages = with pkgs; [
    yubikey-manager
    yubikey-personalization
  ];

  home.sessionVariables = {
    SOPS_AGE_KEY_CMD = "age-plugin-yubikey -i";
  };
}
