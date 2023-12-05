# Nix configs

## NixOS

```sh
nixos-rebuild switch --flake .#<hostname>
```

## Home Manager

Bootstrap:

```sh
nix run nixpkgs#home-manager -- switch --flake .
```

Normal:

```sh
home-manager switch --flake .
```
