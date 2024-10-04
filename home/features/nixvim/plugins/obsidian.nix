{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.obsidian-nvim;
      dependencies = [pkgs.vimPlugins.plenary-nvim];
      opts = {
        new_notes_location = "current_dir";
        workspaces = [
          {
            name = "Foobar";
            path = "~/Notes/Notes/Foobar/";
          }
        ];
      };
    }
  ];
}
