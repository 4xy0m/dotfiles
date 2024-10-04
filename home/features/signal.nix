{pkgs, ...}: let
  catpuccin-theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/CalfMoon/signal-desktop/e2b51b6234114532786d7b2a6ab3ca0008c9960d/themes/catppuccin-mocha.css";
    sha256 = "14px9zh82kkh13vs2p9qf5w9nrnsccndznkrlsh9yi7nrhxj993y";
  };
in {
  home.packages = [
    pkgs.signal-desktop
    # (pkgs.signal-desktop.overrideAttrs (finalAttrs: previousAttrs: {
    #   buildInputs = previousAttrs.buildInputs ++ [pkgs.asar];
    #   postInstall = ''
    #            asar extract $out/lib/Signal/resources/app.asar temp/
    #     cp ${catpuccin-theme} temp/stylesheets/catppuccin-mocha.css
    #     sed -i '1s/^/@import "catppuccin-mocha.css";\n /' temp/stylesheets/manifest.css
    #     asar pack temp/ $out/lib/Signal/resources/app.asar
    #   '';
    # }))
  ];
}
