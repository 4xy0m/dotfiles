{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.indent-blankline-nvim;
      main = "ibl";
      config = true;
    }
  ];
}
