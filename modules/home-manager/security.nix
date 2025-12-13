{pkgs, ...}: {
  home.packages = with pkgs; [
    # Encryption tools
    age
    age-plugin-yubikey
    sops

    # Yubikey tools
    yubikey-manager
    yubikey-personalization

    # Password manager
    koishi
  ];

  home.sessionVariables = {
    SOPS_AGE_KEY_CMD = "age-plugin-yubikey -i";
  };

  home.shellAliases = {
    p = "koishi";
  };

  # Legacy password manager
  # TODO: remove
  programs.password-store = {
    enable = true;

    package = pkgs.pass.withExtensions (exts: [
      exts.pass-otp
    ]);
  };
}
