{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  xdg.configFile."wallpapers/" = {
    source = ./hyprpaper/wallpapers;
    recursive = true;
  };

  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      wallpaper = {
        enabled = true;
        default.path = "${config.home.homeDirectory}/.config/wallpapers/${config.myHomeManager.wallpaper}";
      };

      shell.font_family = "JetBrainsMono Nerd Font";

      osd = {
        position = "bottom_center";
        monitors = [
          (builtins.head config.myHomeManager.monitors).name
        ];
      };

      notification.monitors = [
        (builtins.head config.myHomeManager.monitors).name
      ];

      lockscreen = {
        monitors = [
          (builtins.head config.myHomeManager.monitors).name
        ];
      };

      bar.default.enabled = false;
      bar.default.monitor.main = {
        enabled = true;
        match = (builtins.head config.myHomeManager.monitors).name;
        background_opacity = 0.55;
        margin_ends = 0;
        capsule = true;
        border_width = 0.0;
        padding = 14;
        start = [
          "launcher"
          "cpu"
          "cpu_temp"
          "memory"
          "gpu_temp"
          "tray"
          "notifications"
          "privacy"
        ];
        center = [ "workspaces" ];
        end = [
          "network"
          "volume"
          "brightness"
          "battery"
          "clock"
          "session"
        ];
      };

      widget = {
        launcher = { };

        cpu = {
          type = "sysmon";
          stat = "cpu_usage";
          visualization = "gauge";
        };
        cpu_temp = {
          type = "sysmon";
          stat = "cpu_temp";
        };
        memory = {
          type = "sysmon";
          stat = "ram_pct";
        };
        gpu_temp = {
          type = "sysmon";
          stat = "gpu_temp";
        };

        tray = {
          drawer = false;
          hide_passive = true;
        };

        notifications = {
          hide_when_no_unread = false;
        };

        volume = {
          show_label = true;
          device = "output";
        };

        brightness = {
          show_label = true;
        };

        battery = {
          display_mode = "glyph";
          show_label = false;
        };

        privacy.hide_inactive = true;

        clock.format = "{:%H:%M %a, %b %d}";
      };

      plugins = {
        enabled = [
          "noctalia/kaomoji"
          "rylos/tailnet"
        ];
      };
    };
  };
}
