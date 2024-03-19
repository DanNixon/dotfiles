{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./neomutt.nix
  ];

  programs.mbsync.enable = true;

  accounts.email.maildirBasePath = ".mail";

  accounts.email.accounts.fastmail = {
    primary = true;

    address = "dan@dan-nixon.com";
    realName = "Dan Nixon";
    userName = "dan@dan-nixon.com";
    passwordCommand = "pass Passwords/Personal/fastmail/api_password";

    imap.host = "imap.fastmail.com";
    mbsync = {
      enable = true;
      create = "both";
      extraConfig.channel = {
        CopyArrivalDate = "yes";
      };
    };
  };
}
