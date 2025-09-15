{ pkgs, ... }:
  let 
    yazi-rs = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "b8860253fc44e500edeb7a09db648a829084facd";
      hash = "sha256-29K8PmBoqAMcQhDIfOVnbJt2FU4BR6k23Es9CqyEloo=";
    };
    yazelix = pkgs.fetchFromGitHub {
      owner = "luccahuguet";
      repo = "yazelix";
      rev = "0192328ea8ccabd6035cb91426c870d1bc057914";
      hash = "sha256-021nmyuENYPqW3PbIZaoBZ897xf/ZAcF6dLJ8kB6YoE=";
    };
    init-lua = ''
      require("git"):setup()
      require("no-status"):setup()
      require("auto-layout"):setup()
    '';
  in 
  {
  programs.yazi.enable = true;
  xdg.configFile."yazi/yazi.toml".source = ./config.toml;
  xdg.configFile."yazi/plugins/git.yazi/".source = "${yazi-rs}/git.yazi";
  xdg.configFile."yazi/plugins/no-status.yazi/".source = "${yazi-rs}/no-status.yazi";
  xdg.configFile."yazi/plugins/auto-layout.yazi/main.lua".source = "${yazelix}/yazi/plugins/auto-layout.yazi/main.lua";
  xdg.configFile."yazi/init.lua".text = init-lua;

  xdg.configFile."yazi-tree/yazi.toml".source = ./config-tree.toml;
  xdg.configFile."yazi-tree/keymap.toml".source = ./keymap-tree.toml;
  xdg.configFile."yazi-tree/plugins/git.yazi/".source = "${yazi-rs}/git.yazi";
  xdg.configFile."yazi-tree/plugins/no-status.yazi/".source = "${yazi-rs}/no-status.yazi";
  xdg.configFile."yazi-tree/plugins/auto-layout.yazi/main.lua".source = "${yazelix}/yazi/plugins/auto-layout.yazi/main.lua";
  xdg.configFile."yazi-tree/init.lua".text = init-lua;

  home.packages = [
    (pkgs.writeShellScriptBin "yazi-edit" (builtins.readFile ./yazi-edit.sh))
    (pkgs.writeShellScriptBin "yazi-pick" (builtins.readFile ./yazi-pick.sh))
    (pkgs.writeShellScriptBin "yazi-picker" (builtins.readFile ./yazi-picker.sh))
  ];

  programs.zsh.shellAliases.yz = "yazi-edit";
}
