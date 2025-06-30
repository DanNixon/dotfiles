{
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  name = "koishi";

  src = fetchFromGitHub {
    owner = "dannixon";
    repo = "koishi";

    rev = "0f6f19752500d27418215b4c91d080a35b3997ed";

    hash = "sha256-t9VNhLU61HxbaMyhhguidBXRSJaASYK/E407+n6A64g=";
  };

  cargoHash = "sha256-MZBjmXRRL5D3Gs8a9tNUSEhpzWW6HIGK8h5eIPSIF/M=";

  doCheck = false;
}
