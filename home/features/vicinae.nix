{ pkgs, ... }:
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;

    themes.catppuccin-mocha-lavender = {
      meta = {
        version = 1;
        name = "Catppuccin Mocha Lavender";
        description = "Catppuccin Mocha with lavender-focused accents";
        variant = "dark";
        inherits = "vicinae-dark";
      };

      colors = {
        core = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          secondary_background = "#181825";
          border = "#313244";
          accent = "#B4BEFE";
        };
        accents = {
          blue = "#89B4FA";
          green = "#A6E3A1";
          magenta = "#F5C2E7";
          orange = "#FAB387";
          purple = "#B4BEFE";
          red = "#F38BA8";
          yellow = "#F9E2AF";
          cyan = "#94E2D5";
        };
      };
    };

    settings.theme = {
      dark = {
        name = "catppuccin-mocha-lavender";
        icon_theme = "default";
      };
      light = {
        name = "vicinae-light";
        icon_theme = "default";
      };
    };
  };

  home.packages = [
    (pkgs.writeShellScriptBin "launcher" ''
      #!/usr/bin/env bash
      vicinae toggle
    '')
  ];
}
