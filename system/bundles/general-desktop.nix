{...}: {
  myNixOS.sddm.enable = true;
  myNixOS.grub.enable = true;
  myNixOS.docker.enable = true;
  myNixOS.obs.enable = true;
  myNixOS.pipewire.enable = true;
  myNixOS.syncthing.enable = true;

  networking.networkmanager.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  time.timeZone = "CET";
}
