{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.gitsigns-nvim;
      event = ["BufReadPre" "BufNewFile"];
      config = true;
    }
  ];
}
