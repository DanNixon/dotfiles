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
    bmon
    distrobox
    dogdns
    dua
    dyff
    file
    ffsend
    hexdump
    htop-vim
    ipcalc
    jq
    neofetch
    nix-diff
    nix-tree
    pinentry_curses
    progress
    qrencode
    rclone
    rsync
    sipcalc
    shellcheck
    sshfs
    sshpass # Used for some sshuttle scripts
    sshuttle
    tcpdump
    termdown
    tomb
    tree
    unzip
    wget
    zbar
  ];
}
