{pkgs, ...}: {
  home.shellAliases = {
    g = "git";
    gs = "git s";
    lg = "lazygit";
  };

  programs.git = {
    enable = true;

    userName = "Dan Nixon";
    userEmail = "dan@dan-nixon.com";

    aliases = {
      ap = "add --patch";

      s = "status --short --branch";
      ss = "show";

      co = "checkout";
      sw = "switch";

      c = "commit";
      ca = "commit --amend";
      cf = "commit --fixup";

      d = "diff";
      ds = "diff --staged";

      b = "branch --all";
      bd = "branch -D";

      l = "log --pretty=concise";
      la = "log --pretty=full --graph --show-signature";
      lg = "log --pretty=concise --graph";
      lb = "log --pretty=cleangraph --graph --branches --simplify-by-decoration";
      rl = "log --pretty=reflog --walk-reflogs";

      rb = "rebase";
      rbi = "rebase --interactive";
      rbc = "rebase --continue";

      p = "push";
      pu = "push --set-upstream";
      pfl = "push --force-with-lease";

      f = "fetch";

      cla = "clean -ixd";

      test-pr = "!f() { git fetch $1 pull/$2/merge:pr/$2-merged && git checkout pr/$2-merged; }; f";
    };

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        default = "current";
      };
      pull = {
        ff = "only";
      };
      fetch = {
        prune = true;
      };
      rebase = {
        autoSquash = true;
      };
      merge = {
        conflictStyle = "diff3";
        tool = "meld";
      };
      mergetool = {
        prompt = false;
      };
      diff = {
        colorMoved = "plain";
        tool = "meld";
      };
      "diff \"bin\"" = {
        textconv = "hexdump -v -C";
      };
      "diff \"zip\"" = {
        textconv = "unzip -c -a";
      };
      difftool = {
        prompt = false;
      };
      pretty = {
        concise = "%C(yellow)%h %C(reset)%ad %C(blue)%an %C(reset)%s%C(green)%d";
        cleangraph = "%C(yellow)%h %C(reset)%ad %C(reset)%s%C(green)%d";
        reflog = "%C(yellow)%h %C(reset)%ad %C(blue)%an %C(reset)%gs%C(green)%d";
      };
    };

    attributes = [
      # FreeCad project file
      "*.FCStd diff=zip"
    ];

    ignores = [
      "*~"
      # Direnv
      ".env"
      ".direnv"
      # Tomb
      ".host"
      ".last"
      ".tty"
      ".uid"
    ];
  };

  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    gfold
  ];
}
