{pkgs, ...}: {
  myHomeManager.librewolf.enable = true;
  myHomeManager.signal.enable = true;
  myHomeManager.vesktop.enable = true;
  myHomeManager.gtk.enable = true;

  home.packages = with pkgs; [
    gnome.gnome-calculator
    gnome.nautilus
    pavucontrol
    thunderbird
    obsidian
    vial
  ];
  nixpkgs.config.allowUnfreePredicate = _: true;
}
