{config, ...}: {
  sops.secrets.ssh_config = {
    sopsFile = ./config.secret.txt;
    format = "binary";
    path = "${config.home.homeDirectory}/.ssh/config";
  };
}
