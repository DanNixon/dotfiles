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
    ./neovim.nix
    ./nix-index.nix
    ./nnn.nix
    ./pass.nix
    ./shell.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    distrobox
    pinentry_curses
    qrencode
    shellcheck
    termdown
    zbar

    # System tools
    htop-vim
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
    jq

    # Disk/filesystem tools
    dua
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
