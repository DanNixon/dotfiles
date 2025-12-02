{lib, ...}: {
  services.syncthing = {
    enable = lib.mkDefault false;

    configDir = "/home/dan/.config/syncthing";
    dataDir = "/home/dan/.config/syncthing";

    user = "dan";
    group = "users";

    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;
  };
}
