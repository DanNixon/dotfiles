{inputs, ...}: {
  scheme = "${inputs.tt-schemes}/base16/bright.yaml";

  programs.dircolors.enable = true;

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

    tok = "tomb open -k -";
    v = "$EDITOR";
    t = "cat $HOME/notebook/todo.txt";
    tt = "$EDITOR $HOME/notebook/todo.txt";
    mx = "pulsemixer";

    stripexif = "exiftool -all=";
    today = "date '+%Y-%m-%d'";
    zfs-ls = "zfs list -o name,referenced,used,available,encryption,keystatus,mounted,mountpoint";
  };
}
