# Cheat Sheet

## NixOS

- Update now: `nixos-rebuild switch --flake .`
- Update on boot: `nixos-rebuild boot --flake .`

## Home Manager

- Bootstrap: `nix run nixpkgs#home-manager -- switch --flake .`
- Update: `home-manager switch --flake .`

## Managing NixOS generations

- List: `nix-env --profile /nix/var/nix/profiles/system --list-generations`
- Remove specific: `nix-env --profile /nix/var/nix/profiles/system --delete-generations N ...`

## Managing Home Manager generations

- List: `home-manager generations`
- Remove specific: `home-manager remove-generations N ...`
- Remove old: `home-manager expire-generations "-7days"`

## Store

- Garbage collect: `nix store gc`
