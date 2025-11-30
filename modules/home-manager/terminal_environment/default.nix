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
}
