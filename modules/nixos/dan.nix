{pkgs, ...}: {
  users.users.dan = {
    description = "Dan Nixon";

    isNormalUser = true;

    extraGroups = ["wheel" "video"];

    shell = pkgs.fish;

    openssh.authorizedKeys.keys = [
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
