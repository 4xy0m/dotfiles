{ inputs, pkgs, ... }:
{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  services.displayManager.noctalia-greeter.passwordless-sync-users = [ "nixos" ];
  programs.noctalia-greeter = {
    enable = true;

    greeter-args = "";
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
      keyboard = {
        layout = "us";
      };
    };
  };
}
