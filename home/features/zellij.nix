{
  pkgs,
  config,
  ...
}: let
  vim-zellij-navigator =
    pkgs.callPackage ../../../pkgs/vim-zellij-navigator/default.nix {};
in {
  programs.zellij = {enable = true;};
  programs.zellij.enableZshIntegration = true;
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
       keybinds {
    unbind "Ctrl h"
       }
  '';
}
