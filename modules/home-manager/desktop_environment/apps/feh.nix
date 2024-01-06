{...}: {
  programs.feh = {
    enable = true;

    keybindings = {
      prev_img = ["k" "Left"];
      next_img = ["j" "Right"];

      toggle_menu = null;
    };

    buttons = {
      prev_img = null;
      next_img = null;

      toggle_menu = null;

      pan = 1;
      zoom = 3;
    };
  };
}
