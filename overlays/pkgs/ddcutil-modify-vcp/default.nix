{
  lib,
  writeTextFile,
  bash,
  ddcutil,
}: let
  name = "ddcutil-modify-vcp";
  description = "Set or adjust monitor parameters via ddcutil.";
  runtimeInputs = [bash ddcutil];
  text = builtins.readFile ./ddcutil-modify-vcp.bash;
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
