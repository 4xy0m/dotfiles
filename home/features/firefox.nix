{
  inputs,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles.nixos = {
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        bitwarden
      ];
    };
  };
}
