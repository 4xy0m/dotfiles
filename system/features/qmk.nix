{pkgs, ...}: {
  services.udev.packages = [pkgs.via pkgs.vial];
  hardware.keyboard.qmk.enable = true;
}
