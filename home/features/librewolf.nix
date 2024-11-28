{
  pkgs,
  inputs,
  ...
}: {
  programs.librewolf = {
    enable = true;
    profiles.default = {
      search = {
        force = true;
        default = "Brave";
        engines = {
          "Brave" = {
            urls = [
              {
                  template = "https://search.brave.com/search?q={searchTerms}";
              }
              {
                  template = "https://search.brave.com/api/suggest?q={searchTerms}";
                  type = "application/x-suggestions+json";
              }
            ];
          };
        };
      };
     extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
       ublock-origin
       bitwarden
       darkreader
       inputs.firefox-addons.packages.${pkgs.system}."2fas-two-factor-authentication"
       vimium
       stylus
       firefox-color
     ];
    };
    settings = {
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
    };
  };
}
