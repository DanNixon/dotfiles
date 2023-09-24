{ config, ... }: {
  sops.secrets.ssh_config = let
    dan = config.users.users.dan;
  in {
    sopsFile = ./secrets.yaml;
    owner = dan.name;
    group = dan.group;
    path = "${dan.home}/.ssh/config";
  };
}
