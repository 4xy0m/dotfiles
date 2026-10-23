{ pkgs, ... }:
let
  yazi-rs = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "c591a36e7263e95497715d525e9c46c2f0a880ac";
    hash = "sha256-mWT0yF2iG9+gYEuNiffpM93POlBqY+QKdFh5jSAxYls=";
  };
  auto-layout = pkgs.fetchFromGitHub {
    owner = "apkd";
    repo = "auto-layout.yazi";
    rev = "6c4092223e6c492a4a9aa1df98892701a1378983";
    hash = "sha256-5b1XZIVoZkoI7CjTeaHORZE8ol+IQXX5PnlbvPeJEE4=";
  };
  init-lua = ''
    require("git"):setup()
    require("no-status"):setup()
    require("auto-layout")
  '';
in
{
  programs.yazi.enable = true;
  xdg.configFile."yazi/yazi.toml".source = ./config.toml;
  xdg.configFile."yazi/keymap.toml".source = ./keymap.toml;
  xdg.configFile."yazi/plugins/git.yazi/".source = "${yazi-rs}/git.yazi";
  xdg.configFile."yazi/plugins/jump-to-char.yazi/".source = "${yazi-rs}/jump-to-char.yazi";
  xdg.configFile."yazi/plugins/smart-filter.yazi/".source = "${yazi-rs}/smart-filter.yazi";
  xdg.configFile."yazi/plugins/no-status.yazi/".source = "${yazi-rs}/no-status.yazi";
  xdg.configFile."yazi/plugins/auto-layout.yazi/main.lua".source = "${auto-layout}/main.lua";
  xdg.configFile."yazi/init.lua".text = init-lua;

  xdg.configFile."yazi-tree/yazi.toml".source = ./config-tree.toml;
  xdg.configFile."yazi-tree/keymap.toml".source = ./keymap.toml;
  xdg.configFile."yazi-tree/plugins/git.yazi/".source = "${yazi-rs}/git.yazi";
  xdg.configFile."yazi-tree/plugins/jump-to-char.yazi/".source = "${yazi-rs}/jump-to-char.yazi";
  xdg.configFile."yazi-tree/plugins/smart-filter.yazi/".source = "${yazi-rs}/smart-filter.yazi";
  xdg.configFile."yazi-tree/plugins/no-status.yazi/".source = "${yazi-rs}/no-status.yazi";
  xdg.configFile."yazi-tree/plugins/auto-layout.yazi/main.lua".source = "${auto-layout}/main.lua";
  xdg.configFile."yazi-tree/init.lua".text = init-lua;

  home.packages = [
    (pkgs.writeShellScriptBin "yazi-edit" (builtins.readFile ./yazi-edit.sh))
    (pkgs.writeShellScriptBin "yazi-pick" (builtins.readFile ./yazi-pick.sh))
    (pkgs.writeShellScriptBin "yazi-picker" (builtins.readFile ./yazi-picker.sh))
  ];

  programs.zsh.shellAliases.yz = "yazi-edit";
}
