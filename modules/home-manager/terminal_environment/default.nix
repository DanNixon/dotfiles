{pkgs, ...}: {
  imports = [
    ../base.nix

    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./hsxkpasswd
    ./neovim
    ./nix-index.nix
    ./nnn.nix
    ./rclone
    ./security.nix
    ./shell.nix
    ./ssh-config
  ];

  # System tools
  programs.bottom.enable = true;

  # File tools
  programs.ripgrep.enable = true;

  home.packages = with pkgs; [
    devenv

    # Bar/QR code tools
    qrencode
    zbar

    # System tools
    dmidecode
    lm_sensors
    pciutils
    progress
    usbutils

    # File tools
    dyff
    file
    hexdump
    jaq

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
}
