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

    rev = "v0.2.1";

    hash = "sha256-TljCtd7m4dCjZ48f49EXahFhr8AsBXvmLK9v7UAcmTw=";
  };

  cargoHash = "sha256-SBWy29csUXwbh0I9qqzrkNjVKXAxzPAiWyxLLzdOb2c=";

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
