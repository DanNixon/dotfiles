{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../base.nix

    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./joshuto.nix
    ./neovim
    ./nix-index.nix
    ./nnn.nix
    ./pass.nix
    ./shell.nix
    ./xplr.nix
    ./zellij.nix
    ./zsh.nix
  ];

  # System tools
  programs.bottom.enable = true;

  # File tools
  programs.ripgrep.enable = true;
  programs.jq.enable = true;

  home.packages = with pkgs; [
    pinentry-curses
    qrencode
    termdown
    zbar

    # System tools
    dmidecode
    lm_sensors
    fastfetch
    pciutils
    progress
    usbutils

    # Nix tools
    nix-diff
    nix-tree
    nvd

    # File tools
    dyff
    file
    hexdump

    # Disk/filesystem tools
    dua
    smartmontools
    tomb
    tree
    unzip

    # Networking tools
    bmon
    ffsend
    dogdns
    ipcalc
    rclone
    rsync
    sipcalc
    sshfs
    sshpass # Used for some sshuttle scripts
    sshuttle
    tcpdump
    wget
  ];
}
