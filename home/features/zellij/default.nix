{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zellij.enableZshIntegration = true;
  xdg.configFile."zellij/plugins/zellij-autolock.wasm".source = ./zellij-autolock.wasm;
  xdg.configFile."zellij/dev-layout-folder.kdl".source = ./dev-layout-folder.kdl;
  xdg.configFile."zellij/dev-layout-file.kdl".source = ./dev-layout-file.kdl;
  xdg.configFile."zellij/config.kdl".text = with config.colorScheme.palette; ''
       plugin "compact-bar"
       default_layout "compact"
       copy_on_select true
       theme "default"
       themes {
       default {
                    text_selected {
                        base 0
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                        background 0
                    }
                    text_unselected {
                        base 0
                        emphasis_0 "#${base09}"
                        emphasis_1 0
                        emphasis_2 "#${base07}"
                        emphasis_3 "#${base09}"
                        background 0
                    }
                    ribbon_selected {
                        base 0
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                        background 0
                    }
                    ribbon_unselected {
                        base 0
                        emphasis_0 0
                        emphasis_1 "#${base09}"
                        emphasis_2 0
                        emphasis_3 0
                        background "#${base08}"
                    }
                    table_title {
                        base 0
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                        background 0
                    }
                    table_cell_unselected {
                        base 0
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                        background 0
                    }
                    table_cell_selected {
                        base 0
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                        background 0
                    }
                    list_unselected {
                        base 0
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                        background 0
                    }
                    list_selected {
                        base 0
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                        background 0
                    }
                    frame_unselected {
                        base "#${base04}"
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                    }
                    frame_selected {
                        base "#${base07}"
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                    }
                    frame_highlight {
                        base  "#${base09}"
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                    }
                    exit_code_success {
                        base 0
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                    }
                    exit_code_error {
                        base 0
                        emphasis_0 0
                        emphasis_1 0
                        emphasis_2 0
                        emphasis_3 0
                    }
                }
       }
  plugins {
    autolock location="file:~/.config/zellij/plugins/zellij-autolock.wasm" {
      is_enabled true
      reaction_seconds "0.1"
      triggers "${lib.getExe pkgs.bash} -e /home/nixos/.nix-profile/bin/nvim|nvim"
    }
  }
load_plugins {
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
