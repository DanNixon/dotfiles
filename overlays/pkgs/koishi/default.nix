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

    rev = "v0.1.2";

    hash = "sha256-iIRd4mteQlmCq+UfbRJ7x5NPqSh+0RmHXhH41KWJ0bw=";
  };

  cargoHash = "sha256-w7uacyF/dHxLYTZ5zhKF3/u1hFmsNetJ3kkdUcNBbJE=";

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
