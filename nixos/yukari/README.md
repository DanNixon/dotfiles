# Yukari

## Deployment

- Create Hetzner VM: Helsinki, Ubuntu 22.04, CPX11
- `nixos-anywhere --tty --flake .#yukari root@<IP>`
- Connect via web console
  - `passwd`
  - `sudo tailscale up`
- (then manage normally/locally via `nix-configs` on target)
