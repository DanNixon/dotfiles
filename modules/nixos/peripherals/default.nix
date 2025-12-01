{pkgs, ...}: {
  users.users.dan.extraGroups = ["dialout" "plugdev" "i2c" "adbusers" "scanner" "lp"];

  programs.adb.enable = true;

  # ddcutil
  hardware.i2c.enable = true;

  services.udev.packages = [
    pkgs.picoprobe-udev-rules
  ];

  hardware.sane.enable = true;

  # Dymo label printers
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="0922", ATTRS{idProduct}=="1001", MODE="0666"
    ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="0922", ATTRS{idProduct}=="0015", MODE="0666"

    ATTRS{product}=="*CMSIS-DAP*", MODE="0666"
  '';
}
