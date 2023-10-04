{config, ...}: {
  sops.secrets.rclone_config = let
    dan = config.users.users.dan;
  in {
    sopsFile = ./secrets.yaml;
    owner = dan.name;
    group = dan.group;
    path = "${dan.home}/.config/rclone/rclone.conf";
  };
}
