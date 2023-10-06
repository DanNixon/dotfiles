{
  lib,
  writeTextFile,
  bash,
  git,
  rsync,
}: let
  name = "update-storage";
in
  writeTextFile {
    inherit name;
    executable = true;
    destination = "/bin/${name}";

    text = ''
      #!${bash}${bash.shellPath}

      set -ex

      ${git}/bin/git -C "$HOME/git/notebook.git" push storage1
      ${git}/bin/git -C "$HOME/git/password-store.git" push storage1 master

      ${rsync}/bin/rsync \
        --archive \
        --inplace \
        --verbose \
        ~/tombs/ \
        '100.94.151.123:/data/dan/tombs'
    '';

    meta = with lib; {
      mainProgram = name;
    };
  }
