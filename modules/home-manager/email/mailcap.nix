{pkgs, ...}: {
  home.packages = with pkgs; [
    mailcap
    w3m
  ];

  home.file.".mailcap".text = ''
    text/html; w3m -T text/html '%s' ; needsterminal
    text/html; w3m -T text/html -dump '%s' ; copiousoutput
  '';
}
