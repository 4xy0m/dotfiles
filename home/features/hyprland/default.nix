{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.generators) mkLuaInline;

  # toString prints floats as e.g. "144.000000"; render whole numbers cleanly.
  numStr = n: if n == builtins.floor n then toString (builtins.floor n) else toString n;
in
{
  imports = [
    ./monitors.nix
    ./cursor.nix
  ];
  config = {
    wayland.windowManager.hyprland = with config.colorScheme.palette; {
      systemd.enable = false;
      enable = true;
      configType = "lua";
      package = null;
      portalPackage = null;

      # Each attribute here becomes an hl.<name>(...) call.
      settings = {
        config = {
          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            col = {
              active_border = "rgb(${base07})";
              inactive_border = "rgb(${base03})";
            };
            layout = "scrolling";
          };
          xwayland.force_zero_scaling = true;
          misc = {
            disable_hyprland_logo = true;
            animate_manual_resizes = true;
            animate_mouse_windowdragging = true;
            focus_on_activate = true;
          };
          input = {
            kb_layout = "us,us";
            touchpad.disable_while_typing = false;
          };
          scrolling.focus_fit_method = 0;
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

        # env = [
        #   {
        #     _args = [
        #       "HYPRCURSOR_THEME"
        #       config.myHomeManager.cursor.name
        #     ];
        #   }
        #   {
        #     _args = [
        #       "HYPRCURSOR_SIZE"
        #       config.myHomeManager.cursor.size
        #     ];
        #   }
        # ];

        # was: bezier = extremeEaseOut, 0, 1, 0, 1
        curve = {
          _args = [
            "extremeEaseOut"
            {
              type = "bezier";
              points = [
                [
                  0
                  1
                ]
                [
                  0
                  1
                ]
              ];
            }
          ];
        };

        animation = [
          {
            leaf = "fade";
            enabled = true;
            speed = 5;
            bezier = "default";
          }
          {
            leaf = "windows";
            enabled = true;
            speed = 5;
            bezier = "extremeEaseOut";
            style = "popin 75%";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 5;
            bezier = "default";
            style = "popin 75%";
          }
          {
            leaf = "workspaces";
            enabled = true;
            speed = 4;
            bezier = "extremeEaseOut";
            style = "slidevert";
          }
          {
            leaf = "specialWorkspace";
            enabled = true;
            speed = 8;
            bezier = "extremeEaseOut";
            style = "slidefadevert -50%";
          }
        ];

        # was: layerrule
        layer_rule = {
          name = "noctalia";
          match.namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$";
          no_anim = true;
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        };

        window_rule = {
          match.class = "dev.noctalia.Noctalia";
          float = true;
          size = [
            1080
            920
          ];
        };

        monitor = map (m: {
          output = toString m.name;
          mode = "${numStr m.width}x${numStr m.height}@${numStr m.refreshRate}";
          position = "${toString m.x}x${toString m.y}";
          scale = m.scale;
          transform = if m.rotating != null then m.rotating else 0;
          disabled = !m.enabled;
        }) config.myHomeManager.monitors;

        workspace_rule = map (m: {
          workspace = "m[${toString m.name}]";
          layout_opts.direction = "down";
        }) (lib.filter (m: m.rotating == 1) config.myHomeManager.monitors);

        gesture = [
          {
            fingers = 3;
            direction = "vertical";
            action = "workspace";
          }
          {
            fingers = 3;
            direction = "left";
            action = mkLuaInline ''function() hl.dispatch(hl.dsp.layout("focus l")) end'';
          }
          {
            fingers = 3;
            direction = "right";
            action = mkLuaInline ''function() hl.dispatch(hl.dsp.layout("focus r")) end'';
          }
        ];
      };

      extraConfig = ''
        ---- KEYBINDS ----
        local mod = "SUPER"

        -- apps
        hl.bind(mod .. " + A", hl.dsp.exec_cmd("ghostty"))
        hl.bind(mod .. " + R", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
        hl.bind(mod .. " + O", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
        hl.bind(mod .. " + B", hl.dsp.exec_cmd("librewolf"))
        hl.bind(mod .. " + P", hl.dsp.exec_cmd("hyprquickframe"))

        hl.bind(mod .. " + C", hl.dsp.window.close()) -- was killactive

        -- focus (was layoutmsg)
        hl.bind(mod .. " + left", hl.dsp.layout("focus l"))
        hl.bind(mod .. " + right", hl.dsp.layout("focus r"))
        hl.bind(mod .. " + down", hl.dsp.layout("focus d"))
        hl.bind(mod .. " + up", hl.dsp.layout("focus u"))

        -- move window (was layoutmsg movewindowto)
        hl.bind(mod .. " + CONTROL + left", hl.dsp.window.move({ direction = "l" }))
        hl.bind(mod .. " + CONTROL + right", hl.dsp.window.move({ direction = "r" }))
        hl.bind(mod .. " + CONTROL + down", hl.dsp.window.move({ direction = "d" }))
        hl.bind(mod .. " + CONTROL + up", hl.dsp.window.move({ direction = "u" }))

        -- swap columns / move vertically
        hl.bind(mod .. " + SHIFT + left", hl.dsp.layout("swapcol l"))
        hl.bind(mod .. " + SHIFT + right", hl.dsp.layout("swapcol r"))
        hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
        hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))

        -- special workspace
        hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic")) -- was togglespecialworkspace
        hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" })) -- was movetoworkspace

        hl.bind(mod .. " + V", hl.dsp.window.float()) -- was togglefloating
        hl.bind(mod .. " + V", hl.dsp.window.center()) -- was centerwindow
        -- was resizeactive exact 50% 50% (resize takes pixel numbers only)
        hl.bind(mod .. " + V", function()
          local m = hl.get_active_monitor()
          if not m then return end
          hl.dispatch(hl.dsp.window.resize({ x = math.floor(m.width * 0.5), y = math.floor(m.height * 0.5) }))
        end)
        hl.bind(mod .. " + G", hl.dsp.layout("fit active"))
        hl.bind(mod .. " + SHIFT + G", hl.dsp.window.fullscreen())

        hl.bind(mod .. " + SHIFT + equal", hl.dsp.layout("colresize +conf"))
        hl.bind(mod .. " + minus", hl.dsp.layout("colresize -conf"))

        -- workspaces ($mainMod, $N -> mod + key; key 0 = workspace 10)
        for i = 1, 9 do
          hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i, on_current_monitor = true })) -- was focusworkspaceoncurrentmonitor
          hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i })) -- was movetoworkspace
        end
        hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10, on_current_monitor = true }))
        hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

        hl.bind(mod .. " + mouse_down", hl.dsp.layout("move +col"))
        hl.bind(mod .. " + mouse_up", hl.dsp.layout("move -col"))

        hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))

        ---- MOUSE BINDS ----
        hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
        hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

        ---- MEDIA KEYS ----
        hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
        hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
        hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
        hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
        hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
        hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
        hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

        ---- AUTOSTART ----
        hl.on("hyprland.start", function()
        --   hl.exec_cmd("${pkgs.hypridle}/bin/hypridle")
           hl.exec_cmd("hyprctl setcursor ${config.myHomeManager.cursor.name} ${toString config.myHomeManager.cursor.size}")
           hl.exec_cmd("noctalia")
        end)
      '';
    };
  };
}
