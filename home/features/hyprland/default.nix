{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./monitors.nix ./cursor.nix];
  config = {
    wayland.windowManager.hyprland = with config.colorScheme.palette; {
      enable = true;
      settings = {
        general = {
          gaps_in = 6;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgb(${base07})";
          "col.inactive_border" = "rgb(${base03})";

          layout = "master";
        };
        master.new_status = "master";
        xwayland.force_zero_scaling = true;
        animations = {
          enabled = true;
          bezier = "extremeEaseOut, 0, 1, 0, 1";
          animation = [
            "fade,       1, 5, default"
            "windows,    1, 5, extremeEaseOut, popin 75%"
            "windowsOut, 1, 5, default,        popin 75%"
            "workspaces, 1, 4, extremeEaseOut"
            "specialWorkspace, 1, 8, extremeEaseOut, slidefadevert -50%"
          ];
        };
        layerrule = [
          "blur, waybar"
          "blur, rofi"
          "ignorealpha 0.5, rofi"
        ];
        exec-once = [
          "waybar"
          "${pkgs.hypridle}/bin/hypridle"
          "hyprctl setcursor ${config.myHomeManager.cursor.name} ${toString config.myHomeManager.cursor.size}"
        ];
        "$mainMod" = "SUPER";
        "$1" = "1";
        "$2" = "2";
        "$3" = "3";
        "$4" = "4";
        "$5" = "5";
        "$6" = "6";
        "$7" = "7";
        "$8" = "8";
        "$9" = "9";
        "$10" = "0";
        gestures = {
          workspace_swipe = true;
        };
        misc = {
          disable_hyprland_logo = true;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
        };
        input = {
          kb_layout = "us,us";
          touchpad.disable_while_typing = false;
        };
        bind = [
          "$mainMod, A, exec, kitty"
          "$mainMod, R, exec, launcher"
          "$mainMod, O, exec, powermenu"
          "$mainMod, C, killactive"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, down, movefocus, d"
          "$mainMod, up, movefocus, u"

          "$mainMod CONTROL, left, movewindow, l"
          "$mainMod CONTROL, right, movewindow, r"
          "$mainMod CONTROL, down, movewindow, d"
          "$mainMod CONTROL, up, movewindow, u"

          "$mainMod SHIFT, left, swapwindow, l"
          "$mainMod SHIFT, right, swapwindow, r"
          "$mainMod SHIFT, down, swapwindow, d"
          "$mainMod SHIFT, up, swapwindow, u"

          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          "$mainMod, V, togglefloating"
          "$mainMod, V, centerwindow"
          "$mainMod, V, resizeactive, exact 50% 50%"
          "$mainMod, G, fullscreen, 1"
          "$mainMod SHIFT, G, fullscreen"
          "$mainMod, W, togglesplit"

          "$mainMod, $1, focusworkspaceoncurrentmonitor, 1"
          "$mainMod, $2, focusworkspaceoncurrentmonitor, 2"
          "$mainMod, $3, focusworkspaceoncurrentmonitor, 3"
          "$mainMod, $4, focusworkspaceoncurrentmonitor, 4"
          "$mainMod, $5, focusworkspaceoncurrentmonitor, 5"
          "$mainMod, $6, focusworkspaceoncurrentmonitor, 6"
          "$mainMod, $7, focusworkspaceoncurrentmonitor, 7"
          "$mainMod, $8, focusworkspaceoncurrentmonitor, 8"
          "$mainMod, $9, focusworkspaceoncurrentmonitor, 9"
          "$mainMod, $10, focusworkspaceoncurrentmonitor, 10"

          "$mainMod SHIFT, $1, movetoworkspace, 1"
          "$mainMod SHIFT, $2, movetoworkspace, 2"
          "$mainMod SHIFT, $3, movetoworkspace, 3"
          "$mainMod SHIFT, $4, movetoworkspace, 4"
          "$mainMod SHIFT, $5, movetoworkspace, 5"
          "$mainMod SHIFT, $6, movetoworkspace, 6"
          "$mainMod SHIFT, $7, movetoworkspace, 7"
          "$mainMod SHIFT, $8, movetoworkspace, 8"
          "$mainMod SHIFT, $9, movetoworkspace, 9"
          "$mainMod SHIFT, $10, movetoworkspace, 10"

          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          "$mainMod, TAB, workspace, e+1"
          "$mainMod SHIFT, TAB, workspace, e-1"
        ];
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        workspace = map
          (
            m: lib.mkIf (m.rotating == 1) "m[${toString m.name}], layoutopt:orientation:top"
          )
          (config.myHomeManager.monitors);
        monitor =
          map
          (
            m: "${toString m.name},${toString m.width}x${toString m.height}@${toString m.refreshRate},${toString m.x}x${toString m.y},${toString m.scale},transform,${toString m.rotating}"
          )
          (config.myHomeManager.monitors);
        decoration = {
          rounding = 8;
          blur = {
            enabled = true;

            popups = true;
            popups_ignorealpha = 0.5;

            passes = 3;
            size = 8;
          };
        };
      };
    };
  };
}
