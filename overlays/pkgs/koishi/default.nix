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

    rev = "v0.3.0";

    hash = "sha256-t50J8IM3A2Mse72x8VDkEqfQUs6zecwIo9rapRqxp5o=";
  };

  cargoHash = "sha256-iFCLwdEef6tBNBWMe9/HB/GH38KyYUH6nlGe1i1MIDE=";

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
