{
  disko.devices = {
    disk = {
      root = {
        type = "disk";
        device = "/dev/disk/by-id/todo";

        content = {
          type = "gpt";

          partitions = {
            esp = {
              size = "1G";
              type = "EF00";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            root = {
              size = "100%";

              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
    };

    zpool = {
      rpool = {
        type = "zpool";

        options.ashift = "12";

        rootFsOptions = {
          mountpoint = "none";
          acltype = "posixacl";
          xattr = "sa";
          dnodesize = "auto";
          atime = "off";
          compression = "lz4";
          encryption = "on";
          keyformat = "passphrase";
          keylocation = "prompt";
        };

        datasets = {
          "root" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/";
          };
          "home" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/home";
          };
          "nix" = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/nix";
          };
          "reserved" = {
            type = "zfs_fs";
            options.mountpoint = "none";
            options.refreservation = "2G";
          };
        };
      };
    };
  };
}
