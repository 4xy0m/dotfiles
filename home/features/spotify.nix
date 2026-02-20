{
  pkgs,
  ...
}: 
  let 
    catppuccin-spotify-player = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "spotify-player";
      rev = "34b3d23806770185b72466d777853c73454b85a6";
      hash = "sha256-eenf1jB8b2s2qeG7wAApGwkjJZWVNzQj/wEZMUgnn5U=";
    };
  in {
  programs.spotify-player = {
    enable = true;
    settings.theme = "Catppuccin-mocha";
  };
  xdg.configFile."spotify-player/theme.toml".source = "${catppuccin-spotify-player}/theme.toml";
}
