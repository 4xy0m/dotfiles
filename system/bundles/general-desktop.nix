{...}: {
  myNixOS.sddm.enable = true;
  myNixOS.grub.enable = true;
  myNixOS.docker.enable = true;
  myNixOS.obs.enable = true;
  myNixOS.pipewire.enable = true;
  myNixOS.syncthing.enable = true;

  networking.wireless.iwd.enable = true;
  nix.settings = {
    accept-flake-config = true;
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [
      "root"
      "@wheel"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
    ];
    substituters = [
      "https://hyprland.cachix.org"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
  time.timeZone = "CET";
}
