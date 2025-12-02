{
  lib,
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops

    ./alacritty
    ./git
    ./hsxkpasswd
    ./neovim
    ./rclone
    ./ssh-config

    ./desktop_environment.nix
    ./development.nix
    ./media.nix
    ./nix-index.nix
    ./security.nix
    ./shell.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    overlays = [
      outputs.overlays.additions
    ];
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home = {
    username = lib.mkDefault "dan";
    homeDirectory = lib.mkDefault "/home/dan";

    stateVersion = "23.05";
  };

  sops.age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/sops-nix"];

  home.packages = with pkgs; [
    devenv

    # Bar/QR code tools
    qrencode
    zbar

    # System tools
    bottom
    dmidecode
    lm_sensors
    pciutils
    progress
    screen
    usbutils

    # File tools
    dyff
    file
    hexdump
    jaq
    nnn
    ripgrep

    # Disk/filesystem tools
    dua
    smartmontools
    tomb
    tree
    unzip

    # Networking tools
    bmon
    dogdns
    rsync
    sshfs
    sshpass # Used for some sshuttle scripts
    sshuttle
    wget
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--cycle"
    ];
  };
}
