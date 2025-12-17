{pkgs, ...}: {
  users.users.dan.extraGroups = ["dialout" "i2c" "adbusers" "scanner" "lp"];

  programs.adb.enable = true;

  hardware.i2c.enable = true; # For ddcutil

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

  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplip
      pkgs.foomatic-db-ppds
    ];
  };

  hardware.printers.ensurePrinters = [
    {
      name = "Home";

      deviceUri = "socket://10.1.11.20:9100";
      model = "HP/hp-laserjet_4100_mfp-pcl3.ppd.gz";

      ppdOptions = {
        PageSize = "A4";
      };
    }
    {
      name = "Makerspace";

      deviceUri = "socket://192.168.8.30:9100";
      model = "foomatic-db-ppds/Ricoh-P_C300W-Postscript-Ricoh.ppd.gz";

      ppdOptions = {
        PageSize = "A4";
      };
    }
  ];
}
