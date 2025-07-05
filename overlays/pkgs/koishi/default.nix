{
  fetchFromGitHub,
  rustPlatform,
  installShellFiles,
}:
rustPlatform.buildRustPackage {
  name = "koishi";

  src = fetchFromGitHub {
    owner = "dannixon";
    repo = "koishi";

    rev = "8939c3834391c6d2297a2cd03b45d9859fa54e22";

    hash = "sha256-duWSKgJCHFROFAt0wmDPQpejc+1MlH6zcpWYo16MKa8=";
  };

  cargoHash = "sha256-1+1T11OwfV48rGT2wEcDrTyOBZQjxcrir5np3uDv9I4=";

  nativeBuildInputs = [
    installShellFiles
  ];

  doCheck = false;

  postInstall = ''
    installShellCompletion --cmd koishi \
      --bash <(COMPLETE=bash $out/bin/koishi) \
      --fish <(COMPLETE=fish $out/bin/koishi) \
      --zsh <(COMPLETE=zsh $out/bin/koishi)
  '';
}
