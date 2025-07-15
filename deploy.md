# Deployment guide

Assumes installation will be from a second machine via `nixos-anywhere`.

1. NixOS installation
    1. Boot NixOS minimal installer on target machine
    2. Become root (`sudo su`) and set password (`passwd`)
    3. Note ID of target install disk (`ls /dev/disk/by-id`)
    4. Note IP address (`ip a`)
    5. Create new configs in `./configurations`
    6. Set hostname, installation disk and make any other changes
    7. Install NixOS (`nixos-anywhere --flake .#CONFIG IP`)
    8. Remove installation media
2. Home Manager setup
    1. (TODO)
3. sops-nix setup
    1. Generate new SSH key in `~/.ssh/sops-nix`
    2. Note age key (`ssh-to-age < ~/.ssh/sops-nix`)
    3. Update `.sops.yaml`
    4. Update keys for each secret (`sops updatekeys SECRET`)
4. Tailscale
    1. `sudo tailscale up --accept-routes` on target
    2. Enter URL on machine used for installation
5. [Firefox](./firefox/)
6. Borg/Borgmatic
    1. Create new repository in BorgBase
    2. Set config as required
    3. Insert a passphrase into password store
    4. `borgmatic init -e keyfile-blake2`
    5. Backup key into password store
    6. Do a backup (`borgmatic -v2 create`)
