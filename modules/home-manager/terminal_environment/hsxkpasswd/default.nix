{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.perlPackages.CryptHSXKPasswd];

  sops.secrets.hsxkpasswdrc = {
    sopsFile = ./hsxkpasswdrc.secret.txt;
    format = "binary";
    path = "${config.home.homeDirectory}/.hsxkpasswdrc";
  };
}
