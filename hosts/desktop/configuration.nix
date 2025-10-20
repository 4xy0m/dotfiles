{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  myNixOS.bundles.general-desktop.enable = true;
  myNixOS.bundles.home-manager.enable = true;
  # myNixOS.ollama.enable = true;
  myNixOS.qmk.enable = true;
  myNixOS.grub-theme.resolution = "ultrawide2k";
  myNixOS.home-manager = {
    "nixos" = {
      userConfig = ./home.nix;
    };
  };
  system.stateVersion = "24.05";
}
