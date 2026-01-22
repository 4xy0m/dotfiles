{...}: {
  services.syncthing = {
    enable = true;
    user = "nixos";
    dataDir = "/home/nixos";
    configDir = "/home/nixos/.config/syncthing";
    openDefaultPorts = true;
  };
}
