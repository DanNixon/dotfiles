{
  lib,
  inputs,
  outputs,
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    inputs.sops-nix.homeManagerModules.sops
    ./desktop_environment.nix
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
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/sops-nix"];
  };

  home.packages = with pkgs; [
    # Misc tools
    direnv
    fzf
    qrencode
    zbar
    hydra-check

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
    ripgrep
    yazi

    # Disk/filesystem tools
    dua
    smartmontools
    tomb
    tree
    unzip

    # Networking tools
    bmon
    doggo
    rclone
    rsync
    sshfs
    sshpass # Used for some sshuttle scripts
    sshuttle
    trippy
    wget
    wireshark

    # Physical media backup tools
    cdparanoia # Backing up audio CDs
    cdrdao # Backing up PS1 game CDs
    dvdbackup # Backing up DVDs

    # Media tools
    exiftool
    ffmpeg

    # Retrieval tools
    gallery-dl
    yt-dlp

    # Development tools
    bubblewrap
    devenv
    distrobox
    gcc
    k9s
    kubectl
    shellcheck
    tokei
    rustup
    gfold
    git
    lazygit
    quickemu

    # Text editor stuff
    helix
    pkgs-unstable.zed-editor
    marksman
    nixd
    openscad-lsp
    tombi
    yaml-language-server

    # Security tools
    age
    age-plugin-yubikey
    sops
    yubikey-manager
    yubikey-personalization
    koishi
    perlPackages.CryptHSXKPasswd
  ];

  sops.secrets = {
    hsxkpasswdrc.path = "${config.home.homeDirectory}/.hsxkpasswdrc";
    "rclone.conf".path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
    ssh_config.path = "${config.home.homeDirectory}/.ssh/config";
  };

  xdg.configFile = {
    "alacritty/alacritty.toml".source = ../../xdg_config/alacritty/alacritty.toml;
    "alacritty/colors.toml".source = ../../xdg_config/alacritty/colors.toml;
    "fish/conf.d/config.fish".source = ../../xdg_config/fish/conf.d/config.fish;
    "fish/functions/fish_bind_count.fish".source = ../../xdg_config/fish/functions/fish_bind_count.fish;
    "fish/functions/fish_default_mode_prompt.fish".source = ../../xdg_config/fish/functions/fish_default_mode_prompt.fish;
    "fish/functions/fish_helix_command.fish".source = ../../xdg_config/fish/functions/fish_helix_command.fish;
    "fish/functions/fish_helix_key_bindings.fish".source = ../../xdg_config/fish/functions/fish_helix_key_bindings.fish;
    "fish/functions/fish_prompt.fish".source = ../../xdg_config/fish/functions/fish_prompt.fish;
    "git/attributes".source = ../../xdg_config/git/attributes;
    "git/config".source = ../../xdg_config/git/config;
    "helix/config.toml".source = ../../xdg_config/helix/config.toml;
    "imv/config".source = ../../xdg_config/imv/config;
  };
  home.file = {
    ".var/app/io.mpv.Mpv/config/mpv/input.conf".source = ../../xdg_config/mpv/input.conf;
  };

  programs.nix-index = {
    enableFishIntegration = false;
    enableBashIntegration = false;
  };
  programs.nix-index-database.comma.enable = true;
}
