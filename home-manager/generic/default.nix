{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/terminal_environment
    ../common/development.nix
  ];

  # home = {
  #   username = "dan";
  #   homeDirectory = "/home/dan";
  # };
}
