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
    ./neovim
    ./desktop_environment.nix
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

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/sops-nix"];
  };

  home.packages = with pkgs; [
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
    rclone
    rsync
    sshfs
    sshpass # Used for some sshuttle scripts
    sshuttle
    wget

    # Tools to aid in creating digital backups of physical media
    cdparanoia # Backing up audio CDs
    cdrdao # Backing up PS1 game CDs
    dvdbackup # Backing up DVDs
    xsane # Scanning

    # Tools for working with media files
    exiftool
    ffmpeg

    # Retrieval tools
    gallery-dl
    yt-dlp

    # Development tools
    devenv
    distrobox
    gcc
    k9s
    kubectl
    shellcheck
    tokei # Line of code reporting tool
    rustup
    gfold
    git
    lazygit

    # Text editor stuff
    helix
    marksman
    nixd
    openscad-lsp
    tombi
    yaml-language-server

    # Security tools
    perlPackages.CryptHSXKPasswd
  ];

  home.sessionVariables.EDITOR = "hx";

  sops.secrets = {
    hsxkpasswdrc.path = "${config.home.homeDirectory}/.hsxkpasswdrc";
    "rclone.conf".path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
    ssh_config.path = "${config.home.homeDirectory}/.ssh/config";
  };

  xdg.configFile = {
    "alacritty/alacritty.toml".source = ./config/alacritty/alacritty.toml;
    "alacritty/colors.toml".source = ./config/alacritty/colors.toml;
    "git/attributes".source = ./config/git/attributes;
    "git/config".source = ./config/git/config;
  };

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
