{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    perlPackages.CryptHSXKPasswd
  ];

  sops.secrets.hsxkpasswdrc = {
    sopsFile = ./hsxkpasswdrc.secret.txt;
    format = "binary";
    path = "${config.home.homeDirectory}/.hsxkpasswdrc";
  };
}
