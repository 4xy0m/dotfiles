{pkgs, ...}: {
  services.udev.packages = [pkgs.vial];
  hardware.keyboard.qmk.enable = true;
}
