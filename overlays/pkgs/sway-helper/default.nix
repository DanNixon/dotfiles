{rustPlatform}:
rustPlatform.buildRustPackage {
  name = "sway-helper";

  src = ./.;
  cargoLock.lockFile = ./Cargo.lock;
}
