{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    taskwarrior-tui
  ];

  programs.taskwarrior = {
    enable = true;
    dataLocation = "~/notebook/taskwarrior";
    config = {
      urgency = {
        active.coefficient = 0.0;
        age.coefficient = 0.0;
        annotations.coefficient = 0.0;
        blocking.coefficient = 1.0;
        project.coefficient = 0.0;
        tags.coefficient = 0.0;
      };
      weekstart = "Monday";
      rule.precedence.color = "deleted,completed,active,keyword.,tag.,project.,overdue,scheduled,due.today,due,blocked,blocking,recurring,tagged,uda.";
      color = {
        label = "";
        "label.sort" = "bold";
        alternate = "";
        header = "blue";
        footnote = "";
        warning = "black on yellow";
        error = "magenta";
        debug = "cyan";

        completed = "";
        deleted = "";
        active = "";
        recurring = "";
        scheduled = "";
        until = "";
        blocked = "";
        blocking = "";
        tagged = "";

        uda.priority = {
          H = "red";
          M = "yellow";
          L = "green";
        };

        due = "";
        "due.today" = "";
        overdue = "cyan";

        burndown = {
          done = "black on cyan";
          pending = "black on red";
          started = "black on yellow";
        };

        history = {
          add = "black on red";
          delete = "black on yellow";
          done = "black on cyan";
        };

        summary = {
          background = "on black";
          bar = "black on cyan";
        };

        calendar = {
          due = "black on red";
          "due.today" = "black on red";
          holiday = "black on yellow";
          overdue = "black on yellow";
          today = "black on white";
          weekend = "yellow";
          weeknumber = "blue";
        };

        sync = {
          added = "cyan";
          changed = "red";
          rejected = "magenta";
        };

        undo = {
          afger = "green";
          before = "red";
        };
      };
    };
  };
}
