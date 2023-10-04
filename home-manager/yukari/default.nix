{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/terminal_environment
    ../common/borgmatic.nix
  ];

  programs.borgmatic.backups."main" = {
    location = {
      sourceDirectories = [
        "/home/dan/docs"
        "/home/dan/git"
        "/home/dan/phone"
        "/home/dan/tombs"
      ];
      repositories = ["ssh://sfxwxlb3@sfxwxlb3.repo.borgbase.com/./repo"];
    };
    storage.encryptionPasscommand = "pass borg/yukari/passphrase";
  };
}
