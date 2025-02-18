{
  pkgs,
  ...
}:
  let
    catppuccin-cava = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "cava";
      rev = "0746f77974330338ee2e1e4d1ef9872eba57eb26";
      hash = "sha256-5AQcCRGaAxP5KFzkJtkKFYq0Ug2xVIEqr2r/k87uWwY=";
    };
in {
  programs.cava.enable = true;
  xdg.configFile."cava/config".source = "${catppuccin-cava}/themes/mocha.cava";
}
