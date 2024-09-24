{pkgs}: {
  ddcutil-modify-vcp = pkgs.callPackage ./ddcutil-modify-vcp {};
  de-screenshot = pkgs.callPackage ./de-screenshot {};
  media-control = pkgs.callPackage ./media-control {};
  sway-helper = pkgs.callPackage ./sway-helper {};
}
