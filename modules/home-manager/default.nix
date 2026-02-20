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
    inputs.sops-nix.homeManagerModules.sops
    ./desktop_environment.nix
    ./nix-index.nix
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
    # Misc tools
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
    dogdns
    rclone
    rsync
    sshfs
    sshpass # Used for some sshuttle scripts
    sshuttle
    trippy
    wget

    # Physical media backup tools
    cdparanoia # Backing up audio CDs
    cdrdao # Backing up PS1 game CDs
    dvdbackup # Backing up DVDs
    xsane # Scanning

    # Media tools
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

  home.sessionVariables = {
    EDITOR = "hx";
    SOPS_AGE_KEY_CMD = "age-plugin-yubikey -i";
  };

  sops.secrets = {
    hsxkpasswdrc.path = "${config.home.homeDirectory}/.hsxkpasswdrc";
    "rclone.conf".path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
    ssh_config.path = "${config.home.homeDirectory}/.ssh/config";
  };

  xdg.configFile = {
    "alacritty/alacritty.toml".source = ./config/alacritty/alacritty.toml;
    "alacritty/colors.toml".source = ./config/alacritty/colors.toml;
    "fish/conf.d/config.fish".source = ./config/fish/config.fish;
    "fish/functions/fish_bind_count.fish".source = ./config/fish/functions/fish_bind_count.fish;
    "fish/functions/fish_default_mode_prompt.fish".source = ./config/fish/functions/fish_default_mode_prompt.fish;
    "fish/functions/fish_helix_command.fish".source = ./config/fish/functions/fish_helix_command.fish;
    "fish/functions/fish_helix_key_bindings.fish".source = ./config/fish/functions/fish_helix_key_bindings.fish;
    "fish/functions/fish_prompt.fish".source = ./config/fish/functions/fish_prompt.fish;
    "git/attributes".source = ./config/git/attributes;
    "git/config".source = ./config/git/config;
    "helix/config.toml".source = ./config/helix/config.toml;
    "zed/keymap.json".source = ./config/zed/keymap.json;
    "zed/settings.json".source = ./config/zed/settings.json;
  };

  programs.dircolors.enable = true;
  programs.fish.enable = true;

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

  # Legacy password manager
  # TODO: remove
  programs.password-store = {
    enable = true;

    package = pkgs.pass.withExtensions (exts: [
      exts.pass-otp
    ]);
  };
}
