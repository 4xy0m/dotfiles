{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.xdg-desktop-portal-termfilepickers.homeManagerModules.default ];

  xdg.portal.enable = lib.mkForce true;

  services.xdg-desktop-portal-termfilepickers =
    let
      termfilepickers = inputs.xdg-desktop-portal-termfilepickers.packages.${pkgs.system}.default;
    in
    {
      enable = true;
      package = termfilepickers;
      config = {
        terminal_command = [ (lib.getExe pkgs.ghostty) ];
      };
    };
}
