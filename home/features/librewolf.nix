{
  pkgs,
  inputs,
  ...
}: {
  programs.librewolf = {
    enable = true;
    #    profiles.default = {
    #      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
    #        ublock-origin
    #        bitwarden
    #        darkreader
    # "2fas-two-factor-authentication"
    # vimium
    # stylus
    # firefox-color
    #      ];
    #    };
    settings = {
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
    };
  };
}
