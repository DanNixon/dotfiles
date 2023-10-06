{lib, ...}: {
  services.syncthing = {
    enable = true;

    dataDir = "/home/dan";
    configDir = "/home/dan/.config/syncthing";

    user = "dan";
    group = "users";

    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = lib.mkDefault true;
  };
}
