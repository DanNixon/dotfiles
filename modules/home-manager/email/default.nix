{
  inputs,
  config,
  pkgs,
  ...
}: let
  secrets = import ./secrets.nix;
in {
  imports = [
    ./neomutt.nix
  ];

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;

  accounts.email.maildirBasePath = ".mail";

  accounts.email.accounts = {
    fastmail = let
      a = secrets.accounts.fastmail;
    in {
      primary = true;

      address = a.address;
      realName = a.realName;
      userName = a.address;
      passwordCommand = "pass Passwords/Personal/fastmail/api_password";

      imap.host = "imap.fastmail.com";
      mbsync = {
        enable = true;
        create = "both";
      };

      smtp = {
        host = "smtp.fastmail.com";
        port = 587;
        tls.useStartTls = true;
      };
      msmtp.enable = true;
    };

    gmail = let
      a = secrets.accounts.gmail;
    in {
      address = a.address;
      realName = a.realName;
      userName = a.address;
      passwordCommand = "pass Passwords/Personal/google/email_password";

      imap.host = "imap.gmail.com";
      mbsync = {
        enable = true;
        create = "both";
        patterns = [
          "*"
          "![Google Mail]/All Mail"
          "![Google Mail]/All mail"
        ];
      };

      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls.useStartTls = true;
      };
      msmtp.enable = true;
    };

    outlook-1 = let
      a = secrets.accounts.outlook-1;
    in {
      address = a.address;
      realName = a.realName;
      userName = a.address;
      passwordCommand = "pass Passwords/Personal/microsoft_1/Password";

      imap.host = "outlook.office365.com";
      mbsync = {
        enable = true;
        create = "both";
      };

      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls.useStartTls = true;
      };
      msmtp.enable = true;
    };

    outlook-2 = let
      a = secrets.accounts.outlook-2;
    in {
      address = a.address;
      realName = a.realName;
      userName = a.address;
      passwordCommand = "pass Passwords/Personal/microsoft_2/Password";

      imap.host = "outlook.office365.com";
      mbsync = {
        enable = true;
        create = "both";
      };

      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls.useStartTls = true;
      };
      msmtp.enable = true;
    };
  };
}
