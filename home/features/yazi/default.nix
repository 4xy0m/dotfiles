{ pkgs, ... }:
  let 
    yazi-rs = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "8945e543ebbaa25de155b7101a917eba007252f2";
      hash = "sha256-ko/vvItKtQSz5rbP3TMb4R1bywW2q8hj7E/A++vhVqQ=";
    };
  in 
  {
  programs.yazi.enable = true;
  xdg.configFile."yazi/yazi.toml".source = ./config.toml;
  xdg.configFile."yazi/plugins/git.yazi/".source = "${yazi-rs}/git.yazi";
  xdg.configFile."yazi/plugins/no-status.yazi/".source = "${yazi-rs}/no-status.yazi";
  xdg.configFile."yazi/init.lua".text = "require(\"git\"):setup()\nrequire(\"no-status\"):setup()";

  xdg.configFile."yazi-tree/yazi.toml".source = ./config-tree.toml;
  xdg.configFile."yazi-tree/keymap.toml".source = ./keymap-tree.toml;
  xdg.configFile."yazi-tree/plugins/git.yazi/".source = "${yazi-rs}/git.yazi";
  xdg.configFile."yazi-tree/plugins/no-status.yazi/".source = "${yazi-rs}/no-status.yazi";
  xdg.configFile."yazi-tree/init.lua".text = "require(\"git\"):setup()\nrequire(\"no-status\"):setup()";

  xdg.configFile."yazi-tree/yazi-picker.sh".source = ./yazi-picker.sh;
}
