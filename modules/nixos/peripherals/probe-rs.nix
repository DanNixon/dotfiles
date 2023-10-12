{pkgs, ...}: {
  services.udev.packages = with pkgs; [
    picoprobe-udev-rules
  ];
}
