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

    rev = "v0.2.0";

    hash = "sha256-FoCA8TcW7bEVKFBLlpzIOu0vj90i7fxwOE//RD/y9Sk=";
  };

  cargoHash = "sha256-4Sdy/j2suM//SLLi0DIISXKYcFRYcl867ZKXTyOzdcM=";

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
