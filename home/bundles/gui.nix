{ pkgs, ... }:
{
  myHomeManager.librewolf.enable = true;
  myHomeManager.signal.enable = true;
  myHomeManager.vesktop.enable = true;
  myHomeManager.gtk.enable = true;
  myHomeManager.element.enable = true;

  home.packages = with pkgs; [
    gnome-calculator
    nautilus
    pavucontrol
    thunderbird
    obsidian
    vial
    # davinci-resolve
    vscode
    cryptomator
  ];
  nixpkgs.config.allowUnfreePredicate = _: true;
}
