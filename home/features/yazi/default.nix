{ pkgs, ... }:
  let 
    yazi-rs = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "8945e543ebbaa25de155b7101a917eba007252f2";
      hash = "sha256-ko/vvItKtQSz5rbP3TMb4R1bywW2q8hj7E/A++vhVqQ=";
    };
    zide = pkgs.fetchFromGitHub {
      owner = "josephschmitt";
      repo = "zide";
      rev = "98125cc4c862edd8e43ea1536d9fded397f7b461";
      hash = "sha256-+VOm9sy0x5ihgoQpUuWeBxnuH+oiVSoWwzA8y8scyNg=";
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
  xdg.configFile."yazi/plugins/git.yazi/".source = "${yazi-rs}/git.yazi";
  xdg.configFile."yazi/plugins/no-status.yazi/".source = "${yazi-rs}/no-status.yazi";
  xdg.configFile."yazi/plugins/auto-layout.yazi/main.lua".source = "${zide}/yazi/plugins/auto-layout.yazi/init.lua";
  xdg.configFile."yazi/init.lua".text = init-lua;

  xdg.configFile."yazi-tree/yazi.toml".source = ./config-tree.toml;
  xdg.configFile."yazi-tree/keymap.toml".source = ./keymap-tree.toml;
  xdg.configFile."yazi-tree/plugins/git.yazi/".source = "${yazi-rs}/git.yazi";
  xdg.configFile."yazi-tree/plugins/no-status.yazi/".source = "${yazi-rs}/no-status.yazi";
  xdg.configFile."yazi-tree/plugins/auto-layout.yazi/main.lua".source = "${zide}/yazi/plugins/auto-layout.yazi/init.lua";
  xdg.configFile."yazi-tree/init.lua".text = init-lua;

  home.packages = [
    (pkgs.writeShellScriptBin "yazi-edit" (builtins.readFile ./yazi-edit.sh))
    (pkgs.writeShellScriptBin "yazi-pick" (builtins.readFile ./yazi-pick.sh))
    (pkgs.writeShellScriptBin "yazi-picker" (builtins.readFile ./yazi-picker.sh))
  ];
}
