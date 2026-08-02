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

    rev = "v0.2.2";

    hash = "sha256-Lv1ldNjF986azoQg6WeAbSXjtqKnTldaxJJWV67frLE=";
  };

  cargoHash = "sha256-c33T6thYPpxDX06412yL20isP4Xv+/B95WO+iKl9ZKE=";

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
