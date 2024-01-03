{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.base16.homeManagerModule

    ../base.nix

    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./neovim
    ./nix-index.nix
    ./nnn.nix
    ./pass.nix
    ./shell.nix
    ./tmux.nix
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
    lm_sensors
    neofetch
    progress

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
