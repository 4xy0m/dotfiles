{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zellij = {enable = true;};
  programs.zellij.enableZshIntegration = true;
  xdg.configFile."zellij/plugins/zellij-autolock.wasm".source = ./zellij-autolock.wasm;
  xdg.configFile."zellij/dev-layout.kdl".source = ./dev-layout.kdl;
  xdg.configFile."zellij/config.kdl".text = with config.colorScheme.palette; ''
       plugin "compact-bar"
       default_layout "compact"
       pane_frames false
       copy_on_select true
       theme "default"
       themes {
    default {
    	bg "#${base08}"
    	black "#${base01}"
    	blue "#${base0B}"
    	cyan "#${base0F}"
    	fg "#${base08}"
    	green "#${base07}"
    	magenta "#${base09}"
    	orange "#${base0A}"
    	red "#${base0A}"
    	white "#${base09}"
    	yellow "#${base07}"
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
