{pkgs, ...}: {
  imports = [
    ../base.nix

    ./age.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./hsxkpasswd
    ./koishi.nix
    ./neovim
    ./nix-index.nix
    ./nnn.nix
    ./pass.nix
    ./rclone
    ./shell.nix
    ./ssh-config
    ./yubikey.nix
    ./zellij.nix
    ./zsh.nix
  ];

  # System tools
  programs.bottom.enable = true;

  # File tools
  programs.ripgrep.enable = true;
  programs.jq.enable = true;

  home.packages = with pkgs; [
    qrencode
    termdown
    zbar

    devenv

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
    dogdns
    ipcalc
    rsync
    sipcalc
    sshfs
    sshpass # Used for some sshuttle scripts
    sshuttle
    tcpdump
    wget
  ];
}
