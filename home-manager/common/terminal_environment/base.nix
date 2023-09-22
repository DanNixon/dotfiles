{ inputs, pkgs, ... }: {
  scheme = "${inputs.base16-schemes}/material-darker.yaml";

  home.shellAliases = {
    ".." = "cd ..";
    l = "ls --color=auto -lFh";
    ll = "ls --color=auto -lFa";
    lt = "tree";
    ltt = "tree -ashpug";

    df = "df -h";
    du = "du -h";
    free = "free -h";

    lb = "lsblk";

    q = "exit";
    c = "clear";

    g = "git";
    gs = "git s";
    lg = "lazygit";

    f = "nnn";
    p = "pass";
    tm = "tmux";
    tok = "tomb open -k -";
    v = "$EDITOR";
    m = "ncmpcpp";
    k = "kubectl";
    kk = "k9s";
    t = "cat $HOME/notebook/todo.txt";
    tt = "$EDITOR $HOME/notebook/todo.txt";
    mx = "pulsemixer";

    stripexif = "exiftool -all=";
    today = "date '+%Y-%m-%d'";
    zfs-ls = "zfs list -o name,referenced,used,available,encryption,keystatus,mounted,mountpoint";
  };

  programs.dircolors = {
    enable = true;
  };
}
