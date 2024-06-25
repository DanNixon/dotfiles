{
  writeTextFile,
  runtimeShell,
}: let
  name = "firefox-private";
  description = "Opens a new private Firefox window.";
in
  writeTextFile {
    inherit name;
    executable = true;
    destination = "/bin/${name}";

    text = ''
      #!${runtimeShell}
      flatpak run org.mozilla.firefox -- --private-window
    '';

    meta = {
      mainProgram = name;
      description = description;
    };
  }
