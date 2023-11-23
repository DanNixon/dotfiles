{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    borgbackup
  ];

  programs.borgmatic = {
    enable = true;

    backups."main" = {
      retention.keepWithin = "1m";

      storage.extraConfig = {
        checkpoint_interval = 300;
        compression = "none";
        extra_borg_options = {
          create = "--progress --list --filter=AME --stats";
          prune = "--list -s";
        };
      };
    };
  };
}
