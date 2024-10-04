{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  myNixOS.bundles.general-desktop.enable = true;
  myNixOS.bundles.home-manager.enable = true;
  myNixOS.battery-life.enable = true;
  myNixOS.grub-theme.resolution = "1080p";
  myNixOS.home-manager = {
    "nixos" = {
      userConfig = ./home.nix;
    };
  };
  system.stateVersion = "24.05";
}
