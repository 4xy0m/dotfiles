{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    (pkgs.writeShellScriptBin "nix-develop-if-flake" (builtins.readFile ./nix-develop-if-flake.sh))
  ];
  programs.zellij = {enable = true; };
  programs.zellij.enableZshIntegration = true;
  xdg.configFile."zellij/plugins/zellij-autolock.wasm".source = ./zellij-autolock.wasm;
  xdg.configFile."zellij/plugins/zjframes.wasm".source = ./zjframes.wasm;
  xdg.configFile."zellij/plugins/zjstatus.wasm".source = ./zjstatus.wasm;
  xdg.configFile."zellij/dev-layout-folder.kdl".source = ./dev-layout-folder.kdl;
  xdg.configFile."zellij/dev-layout-file.kdl".source = ./dev-layout-file.kdl;
  xdg.configFile."zellij/layouts/default.kdl".source = ./default.kdl;
  xdg.configFile."zellij/config.kdl".text = with config.colorScheme.palette; ''
       copy_on_select true
       show_startup_tips false
       advanced_mouse_actions false
       theme "default"
       themes {
    default {
        text_unselected {
            base 205 214 244
            background 24 24 37
            emphasis_0 250 179 135
            emphasis_1 137 220 235
            emphasis_2 166 227 161
            emphasis_3 245 194 231
        }
        text_selected {
            base 205 214 244
            background 88 91 112
            emphasis_0 250 179 135
            emphasis_1 137 220 235
            emphasis_2 166 227 161
            emphasis_3 245 194 231
        }
        ribbon_selected {
            base 24 24 37
            background 180 190 254
            emphasis_0 243 139 168
            emphasis_1 250 179 135
            emphasis_2 245 194 231
            emphasis_3 137 180 250
        }
        ribbon_unselected {
            base 24 24 37
            background 205 214 244
            emphasis_0 243 139 168
            emphasis_1 205 214 244
            emphasis_2 137 180 250
            emphasis_3 245 194 231
        }
        table_title {
            base 166 227 161
            background 0
            emphasis_0 250 179 135
            emphasis_1 137 220 235
            emphasis_2 166 227 161
            emphasis_3 245 194 231
        }
        table_cell_selected {
            base 205 214 244
            background 88 91 112
            emphasis_0 250 179 135
            emphasis_1 137 220 235
            emphasis_2 166 227 161
            emphasis_3 245 194 231
        }
        table_cell_unselected {
            base 205 214 244
            background 24 24 37
            emphasis_0 250 179 135
            emphasis_1 137 220 235
            emphasis_2 166 227 161
            emphasis_3 245 194 231
        }
        list_selected {
            base 205 214 244
            background 88 91 112
            emphasis_0 250 179 135
            emphasis_1 137 220 235
            emphasis_2 166 227 161
            emphasis_3 245 194 231
        }
        list_unselected {
            base 205 214 244
            background 24 24 37
            emphasis_0 250 179 135
            emphasis_1 137 220 235
            emphasis_2 166 227 161
            emphasis_3 245 194 231
        }
        frame_unselected {
            base 88 91 112
            background 0
            emphasis_0 0
            emphasis_1 0
            emphasis_2 0
            emphasis_3 0
        }
        frame_selected {
            base 180 190 254
            background 0
            emphasis_0 250 179 135
            emphasis_1 137 220 235
            emphasis_2 245 194 231
            emphasis_3 0
        }
        frame_highlight {
            base 250 179 135
            background 0
            emphasis_0 245 194 231
            emphasis_1 250 179 135
            emphasis_2 250 179 135
            emphasis_3 250 179 135
        }
        exit_code_success {
            base 166 227 161
            background 0
            emphasis_0 137 220 235
            emphasis_1 24 24 37
            emphasis_2 245 194 231
            emphasis_3 137 180 250
        }
        exit_code_error {
            base 243 139 168
            background 0
            emphasis_0 249 226 175
            emphasis_1 0
            emphasis_2 0
            emphasis_3 0
        }
        multiplayer_user_colors {
            player_1 245 194 231
            player_2 137 180 250
            player_3 0
            player_4 249 226 175
            player_5 137 220 235
            player_6 0
            player_7 243 139 168
            player_8 0
            player_9 0
            player_10 0
        }
    }
}
  plugins {
    autolock location="file:~/.config/zellij/plugins/zellij-autolock.wasm" {
      is_enabled true
      reaction_seconds "0.2"
      triggers "nvim"
      print_to_log true
    }
  }
load_plugins {
    "file:~/.config/zellij/zjframes.wasm" {
        hide_frame_for_single_pane       "true"
        hide_frame_except_for_search     "true"
        hide_frame_except_for_scroll     "true"
        hide_frame_except_for_fullscreen "true"
    }   
    autolock
}
keybinds {
    shared_except "locked" {
        bind "Ctrl right" { MoveFocusOrTab "right"; }
        bind "Ctrl down" { MoveFocus "down"; }
        bind "Ctrl up" { MoveFocus "up"; }
        bind "Ctrl left" { MoveFocusOrTab "left"; }
    }
    shared {
        bind "Alt p" { Resize "Increase"; }
        bind "Alt m" { Resize "Decrease"; }
        bind "Ctrl p" { SwitchToMode "Pane"; }
        bind "Ctrl n" { SwitchToMode "Resize"; }
        bind "Ctrl s" { SwitchToMode "Scroll"; }
        bind "Ctrl o" { SwitchToMode "Session"; }
        bind "Ctrl t" { SwitchToMode "Tab"; }
        bind "Ctrl h" { SwitchToMode "Move"; }
        bind "Ctrl b" { SwitchToMode "Tmux"; }
    }
}
  '';
}
