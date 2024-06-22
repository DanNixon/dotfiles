# `yukari`

## Hardware

Hetzner CPX11 VM in Helsinki.

## Deployment

- `nixos-anywhere --tty --flake .#yukari root@<IP>`
- Connect via web console
   - `passwd`
   - `sudo tailscale up`
- (then manage normally/locally via `nix-configs` on target)
