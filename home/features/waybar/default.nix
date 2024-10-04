{
  config,
  myLib,
  inputs,
  pkgs,
  ...
}: {
  imports = [./style.nix];
  programs.waybar = {
    package = pkgs.waybar;
    enable = true;
    settings = [
      {
        position = "top";
        layer = "top";
        height = 30;
        output = [(builtins.head config.myHomeManager.monitors).name];
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-right = [
          "pulseaudio"
          "backlight"
          "network"
          "battery"
          "clock"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-left = [
          "custom/launcher"
          "cpu"
          "memory"
          "tray"
          "privacy"
        ];
        privacy = {
          icon-spacing = 4;
          icon-size = 18;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-out";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 24;
            }
          ];
        };
        cpu = {
          format = " {usage}%";
          format-alt = " {avg_frequency} GHz";
          interval = 3;
        };
        memory = {
          format = " {}%";
          format-alt = " {used}/{total} GiB";
          tooltip-format = "swap: {swapUsed}/{swapTotal} GiB";
          interval = 3;
        };
        "wlr/workspaces" = {
          active-only = false;
          all-outputs = false;
          on-click = "activate";
          disable-scroll = false;
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
          format = "{name}";
          format-icons.sort-by-number = true;
        };
        tray = {
          spacing = 8;
          icon-size = 20;
        };
        clock = {
          format = "  {:%a %b %d, %H:%M}";
          tooltip = true;
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };
        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "󰈀  {ifname} (eth)";
          tooltip-format-wifi = "({frequency} GHz) Connected to {essid} ({gwaddr}) via {ifname} ({ipaddr})";
          tooltip-format-ethernet = "Connected via {ifname} ({gwaddr} -> {ipaddr})";
          format-linked = "󰈀  {ifname} (eth) (No IP)";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        };
        "custom/launcher" = {
          format = "";
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" "" "" "" "" "" ""];
        };
        battery = {
          states = {
            good = 95;
            warning = 35;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          tooltip-format = "{time}";
          format-icons = ["" "" "" "" ""];
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-icons = ["󰕿" "󰖀" "󰕾"];
          format-muted = "󰝟";
          scroll-step = 5;
          on-click = "amixer set Master toggle";
          on-double-click = "pavucontrol";
        };
      }
    ];
  };
}
