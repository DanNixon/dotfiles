# Nix configs

## NixOS

```sh
nixos-rebuild switch --flake .#<hostname>
```

## Home Manager

Bootstrap:
```sh
nix run nixpkgs#home-manager -- switch --flake .#<config name>
```

Normal:
```sh
home-manager switch --flake .#<config name>
```

## In Progress

- https://mynixos.com/nixpkgs/option/services.dnscrypt-proxy2.enable
