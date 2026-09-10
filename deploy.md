# Deployment guide

Assumptions:

- A bootable device with the NixOS minimal installer
- A storage device with a copy of this repo
- Installation will happen on the target device

1. NixOS installation
    1. Boot NixOS minimal installer
    2. Insert and mount dotfiles storage device
    3. Note ID of target install disk (`ls /dev/disk/by-id`)
    4. Create/adjust appropriate config in `./configurations`
    5. Generate `hardware-configuration.nix` and amend as required (`nixos-generate-config --dir CONFIG-DIR`)
    6. Prepare disks (`sudo disko -m destroy,format,mount --flake .#CONFIG`)
    7. Install NixOS (`sudo nixos-install --root /mnt --flake .#CONFIG`)
    8. Reboot and remove external storage devices
2. Home Manager setup
    1. Insert and mount dotfiles storage device
    2. Deploy (`nix run nixpkgs#home-manager -- switch --flake .#CONFIG`)
    3. `fish_helix_key_bindings`
    4. Remove unused XDG user directories
3. COSMIC setup (`./script/cosmic-config-deploy.sh`)
4. [Flatpak](./flatpak)
5. sops-nix setup
    1. Generate new SSH key in `~/.ssh/sops-nix`
    2. Note age key (`ssh-to-age < ~/.ssh/sops-nix.pub`)
    3. Update `.sops.yaml`
    4. Update keys for each secret (`sops updatekeys SECRET`)
6. [Firefox](./firefox/)
7. Tailscale
    1. `sudo tailscale up --accept-routes` on target
    2. Enter URL on machine used for installation
8. Borg/Borgmatic
    1. Create new repository in BorgBase
    2. Set config as required
    3. Insert a passphrase into password store
    4. `borgmatic init -e keyfile-blake2`
    5. Backup key into password store
    6. Do a backup (`borgmatic -v2 create`)
