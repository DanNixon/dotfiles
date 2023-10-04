{
  lib,
  writeTextFile,
  bash,
  mpc_cli,
  socat,
}: let
  name = "media-control";
  description = "Controls running media players.";
  runtimeInputs = [bash mpc_cli socat];
  text = builtins.readFile ./media-control.bash;
in
  writeTextFile {
    inherit name;
    executable = true;
    destination = "/bin/${name}";

    text = ''
      #!${bash}${bash.shellPath}
      export PATH="${lib.makeBinPath runtimeInputs}:$PATH"
      ${text}
    '';

    meta = with lib; {
      mainProgram = name;
      description = description;
    };
  }
