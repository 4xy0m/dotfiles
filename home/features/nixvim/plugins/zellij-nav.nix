{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimUtils.buildVimPlugin {
        name = "zellij-nav";
        src = pkgs.fetchFromGitHub {
          owner = "swaits";
          repo = "zellij-nav.nvim";
          rev = "25930804397ef540bd2de62f9897bc2db61f9baa";
          hash = "sha256-TUhA6UGwpZuYWDU4j430LMnHVD8cggwrAzQ+HlT5ox8=";
        };
      };
      event = "VeryLazy";
      config = ''
        function()
        	require("zellij-nav").setup()
        end
      '';
    }
  ];
}
