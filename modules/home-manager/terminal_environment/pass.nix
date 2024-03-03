{pkgs, ...}: {
  home.shellAliases = {
    p = "pass";
  };

  programs.password-store = {
    enable = true;

    package = pkgs.pass.withExtensions (exts: [
      exts.pass-otp
    ]);
  };
}
