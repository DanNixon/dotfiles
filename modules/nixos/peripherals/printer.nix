{pkgs, ...}: {
  services.printing = {
    enable = true;

    drivers = [pkgs.hplip];
  };

  hardware.printers.ensurePrinters = [
    {
      name = "HP-LaserJet-4100-MFP";

      deviceUri = "socket://10.1.11.20:9100";
      model = "HP/hp-laserjet_4100_mfp-pcl3.ppd.gz";

      ppdOptions = {
        PageSize = "A4";
      };
    }
  ];
}
