{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "catppuccin-mocha-lavender";
  };

  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "lavender";
      font = "Noto Sans";
      fontSize = "12";
    })
  ];
}
