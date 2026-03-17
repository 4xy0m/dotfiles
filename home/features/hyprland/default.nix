{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./monitors.nix ./cursor.nix];
  config = {
    wayland.windowManager.hyprland = with config.colorScheme.palette; {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      settings = {
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgb(${base07})";
          "col.inactive_border" = "rgb(${base03})";
          layout = "scrolling";
        };
        xwayland.force_zero_scaling = true;
        animations = {
          enabled = true;
          bezier = "extremeEaseOut, 0, 1, 0, 1";
          animation = [
            "fade,       1, 5, default"
            "windows,    1, 5, extremeEaseOut, popin 75%"
            "windowsOut, 1, 5, default,        popin 75%"
            "workspaces, 1, 4, extremeEaseOut, slidevert"
            "specialWorkspace, 1, 8, extremeEaseOut, slidefadevert -50%"
          ];
        };
        layerrule = [
          {
            name = "blur-noctalia";
            "match:namespace" = "noctalia-background-.*$";
            ignore_alpha = 0.5;
            blur = true;
          }
        ];
        exec-once = [
          "noctalia-shell"
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
        gesture = [
          "3, vertical, workspace"
          "3, left, dispatcher, layoutmsg, focus l"
          "3, right, dispatcher, layoutmsg, focus r"
        ];
        misc = {
          disable_hyprland_logo = true;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
        };
        input = {
          kb_layout = "us,us";
          touchpad.disable_while_typing = false;
        };
        plugin.hyprscrolling = {
          fullscreen_on_one_column = true;
          follow_focus = true;
          focus_fit_method = 1;
        };
        bind = [
          "$mainMod, A, exec, ghostty"
          "$mainMod, R, exec, noctalia-shell ipc call launcher toggle"
          "$mainMod, O, exec, noctalia-shell ipc call sessionMenu toggle"
          "$mainMod, B, exec, librewolf"
          "$mainMod, P, exec, hyprquickframe"
          "$mainMod, C, killactive"

          "$mainMod, left, layoutmsg, focus l"
          "$mainMod, right, layoutmsg, focus r"
          "$mainMod, down, layoutmsg, focus d"
          "$mainMod, up, layoutmsg, focus u"

          "$mainMod CONTROL, left, layoutmsg, movewindowto l"
          "$mainMod CONTROL, right, layoutmsg, movewindowto r"
          "$mainMod CONTROL, down, layoutmsg, movewindowto d"
          "$mainMod CONTROL, up, layoutmsg, movewindowto u"

          "$mainMod SHIFT, left, layoutmsg, swapcol l"
          "$mainMod SHIFT, right, layoutmsg, swapcol r"
          "$mainMod SHIFT, down, layoutmsg, movewindowto d"
          "$mainMod SHIFT, up, layoutmsg, movewindowto u"

          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          "$mainMod, V, togglefloating"
          "$mainMod, V, centerwindow"
          "$mainMod, V, resizeactive, exact 50% 50%"
          "$mainMod, G, layoutmsg, fit active"
          "$mainMod SHIFT, G, fullscreen"

          "$mainMod SHIFT, equal, layoutmsg, colresize +conf"
          "$mainMod, minus, layoutmsg, colresize -conf"

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

          "$mainMod, mouse_down, layoutmsg, move +col"
          "$mainMod, mouse_up, layoutmsg, move -col"

          "$mainMod, TAB, workspace, e+1"
        ];
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioNext, exec, playerctl stop"
        ];
        workspace =
          (map
            (m: lib.mkIf (m.rotating == 1)
              "m[${toString m.name}], layoutopt:direction:down"
            )
            config.myHomeManager.monitors
          );
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
