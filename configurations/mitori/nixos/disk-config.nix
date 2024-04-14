{
  disko.devices.disk = {
    sda = {
      type = "disk";
      device = "/dev/disk/by-id/ata-SAMSUNG_MZ7TY128HDHP-000L1_S2YPNB0H948930";

      content = {
        type = "gpt";

        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };

          ESP = {
            name = "ESP";
            size = "512M";
            type = "EF00";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          root = {
            name = "root";
            size = "100%";

            content = {
              type = "luks";
              name = "cryptedroot";
              extraOpenArgs = ["--allow-discards"];

              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
