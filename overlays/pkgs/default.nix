{pkgs}: {
  ddcutil-modify-vcp = pkgs.callPackage ./ddcutil-modify-vcp {};
  de-screenshot = pkgs.callPackage ./de-screenshot {};
  firefox-private = pkgs.callPackage ./firefox-private {};
  media-control = pkgs.callPackage ./media-control {};
  sway-helper = pkgs.callPackage ./sway-helper {};
}
