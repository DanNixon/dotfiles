{ pkgs, ... }: {
  home.packages = with pkgs; [
    yubikey-manager
    yubikey-personalization
  ];

  programs.gpg = {
    enable = true;

    publicKeys = [
      {
        trust = "ultimate";
        text = ''
          -----BEGIN PGP PUBLIC KEY BLOCK-----

          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
          uUrm
          =qxd0
          -----END PGP PUBLIC KEY BLOCK-----
        '';
      }
    ];

    settings = {
      no-emit-version = true;
      no-comments = true;

      keyid-format = "0xlong";

      with-fingerprint = true;

      list-options = [ "show-uid-validity" ];
      verify-options = [ "show-uid-validity" ];

      default-recipient = "dan@dan-nixon.com";
      default-key = "dan@dan-nixon.com";
    };
  };
}
