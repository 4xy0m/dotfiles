{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.grub2-themes.nixosModules.default
  ];
  options.myNixOS.grub-theme.resolution = lib.mkOption {};
  config = {
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub2-theme = {
      enable = true;
      theme = "vimix";
      footer = true;
      screen = config.myNixOS.grub-theme.resolution;
    };
  };
}
