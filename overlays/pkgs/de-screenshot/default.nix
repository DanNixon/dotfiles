{
  lib,
  writeTextFile,
  bash,
  jq,
  slurp,
  grim,
}: let
  name = "de-screenshot";
  description = "Takes a screenshot of a window, screen or specific area.";
  runtimeInputs = [bash jq slurp grim];
  text = builtins.readFile ./de-screenshot.bash;
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

    meta = {
      mainProgram = name;
      description = description;
    };
  }
