{pkgs, ...}: {
  users.users.dan.extraGroups = ["dialout" "i2c" "adbusers" "scanner" "lp"];

  programs.adb.enable = true;

  # ddcutil
  hardware.i2c.enable = true;

  hardware.sane.enable = true;

  services.udev = {
    packages = [
      pkgs.picoprobe-udev-rules
    ];

    extraRules = ''
      # Dymo label printers
      ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="0922", ATTRS{idProduct}=="1001", MODE="0666"
      ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="0922", ATTRS{idProduct}=="0015", MODE="0666"

      # Pi debug probe
      ATTRS{product}=="*CMSIS-DAP*", MODE="0666"
    '';
  };
}
