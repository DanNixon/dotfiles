{...}: {
  services.flatpak.packages = [
    "org.kicad.KiCad"
    "org.freecadweb.FreeCAD"
    "org.librecad.librecad"
    "org.openscad.OpenSCAD"
    "com.prusa3d.PrusaSlicer"
    "com.bambulab.BambuStudio"
  ];
}
