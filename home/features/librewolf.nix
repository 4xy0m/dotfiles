{
  pkgs,
  inputs,
  config,
  ...
}: 
  let 
    textfox = pkgs.fetchFromGitHub {
      owner = "adriankarlen";
      repo = "textfox";
      rev = "e0d002eea7a5a3791bbf3f4b64c9197a531a4f96";
      hash = "sha256-/g0f7j7qFUtO9tX7qMwVjIvb7LxRUjnm2c9wNU/kprQ=";
    }; in 
{
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
      "extensions.autoDisableScopes" = 0;
      "extensions.enabledScopes" = 15;
    };
  };
  home.file = {
    ".librewolf/default/chrome" = {
      source = "${textfox}/chrome";
      recursive = true;
    };
    ".librewolf/default/chrome/config.css".text = with config.colorScheme.colors; ''
      :root { 
        --tf-display-horizontal-tabs: block; 
        --tf-bg: #${base00}; 
        --tf-accent: #${base07}; 
        --tf-border: #${base04}; 
      }
    '';
    ".librewolf/default/user.js".source = "${textfox}/user.js";
  };
}
