{pkgs, ...}: {
  home.packages = with pkgs; [
    # Tools to aid in creating digital copies/backups of physical media
    cdparanoia # Backing up audio CDs
    cdrdao # Backing up PS1 game CDs
    dvdbackup # Backing up DVDs
    xsane # Scanning

    # Tools for working with media files
    exiftool
    ffmpeg

    # Retrieval tools
    gallery-dl
    yt-dlp
  ];
}
