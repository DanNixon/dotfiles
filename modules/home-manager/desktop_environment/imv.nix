{...}: {
  programs.imv = {
    enable = true;

    settings = {
      binds = {
        "h" = "prev";
        "j" = "next";
        "k" = "prev";
        "l" = "next";

        "<Shift+H>" = "pan 50 0";
        "<Shift+J>" = "pan 0 -50";
        "<Shift+K>" = "pan 0 50";
        "<Shift+L>" = "pan -50 0";
      };
    };
  };
}
