{...}: {
  programs.gpg = {
    enable = true;

    publicKeys = [
      {
        trust = "ultimate";
        text = ''
          -----BEGIN PGP PUBLIC KEY BLOCK-----

          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
          /A1G
          =sCle
          -----END PGP PUBLIC KEY BLOCK-----
        '';
      }
    ];

    settings = {
      no-emit-version = true;
      no-comments = true;

      keyid-format = "0xlong";

      with-fingerprint = true;

      list-options = ["show-uid-validity"];
      verify-options = ["show-uid-validity"];

      default-recipient = "dan@dan-nixon.com";
      default-key = "dan@dan-nixon.com";
    };
  };
}
