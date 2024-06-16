{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.rclone];

  sops.secrets.rclone_config = {
    sopsFile = ./config.secret.txt;
    format = "binary";
    path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
  };
}
