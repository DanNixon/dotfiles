{pkgs, ...}: {
  services.printing.drivers = [pkgs.foomatic-db-ppds];

  hardware.printers.ensurePrinters = [
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
