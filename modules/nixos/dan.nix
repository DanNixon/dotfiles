{pkgs, ...}: {
  users.users.dan = {
    description = "Dan Nixon";

    isNormalUser = true;

    extraGroups = ["wheel" "video"];

    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+vdIusbvn2f1ME6riwqwU2sfaYeRLYLkV5LAKiFHmOLHFnHtYX1DZ5YWOIlmmGfUx5azzFfxlOYjRAMn3S4JxD3/pyfYUjUJdT2rtQx1TGpI5whV24f0vTDbCxgtpgzBEsdRiQmVY+YpFbfh5hpknmBM2HBGNXZbLJe7PmIXklRNNKl2PkbB7QsVu4OnLcBKGQVRi2hcqCEtYgt9WtxuenvnAt+VHt5Gm2/n/bPFIotBUNYMoIrVjagilltn5KbyXOPNeXKyhZ5P0bYx/ejiQeCVwF3DedGjWES/cjF5LpmtAfNX01i+j13Oj9t01QZauvPUrK4tqEsApOcUt4gCcU062U5LjAgNCXL++2WUpem6y5JxpO9QqIYovsFpXsLvBPUlOHhYdcgUjKTdG5eRh96IWgu2Xo5hBvYHY11Em35tiVa3UNI4ZUKiNzOMe2D5bQkbUOjribxjcUxzpEvP4x+WIpHv9ww+5qvSkaHnnEko5gOloMd3iduKsJi/VTAFIR0L+WJadlEKIIjSOqAQVCo+yyCR2shE7n5oHTriCJ+q2HBqz6d39JBT1u/jNw7TqC42nO+yZ1BXCC3tzJLYhGrPX8AdAXbYLd2BL/9bOYuUX2D8CyvZlM0ujevudsAwsSKeFbLVqJKZ2R+/kDniU/LbojdCZsQrRSo7A1Ml0xw== dannixon"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIK7s0LdsRToGiVzKkx6Qb9rfVo/vJFLwPFIdLKB6Eb6qAAAADHNzaDpkYW5uaXhvbg== dannixon-sk-f-yellow"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGPvnIg4Zq1LrKS/FiaHhj1bucpzjFkOd7bONizDaJoeKO1t7SOaFQ3akmnyhzwZ3ofiLrYndt7RUj/fuWRuplQ= dannixon-sk-p-yellow"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDBp50eBJ/i1f3iVzvT5r3Wgw3oNOg1/Ee/VsTrM1EylAAAADHNzaDpkYW5uaXhvbg== dannixon-sk-f-blue"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGnGBOiciPIJpUKrgEx5bqEKu3eKCkeyBNieD/FOH7ArWSPI0S2c2AEhz/zCHFGD9PrQpg2s0ImEG/ZqwHHOUWw= dannixon-sk-p-blue"
    ];

    initialPassword = "change-me";
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
    enableExtraSocket = true;
  };

  services.pcscd.enable = true;
  services.yubikey-agent.enable = true;

  nix.extraOptions = ''
    trusted-users = root dan
  '';
}
