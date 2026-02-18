{config, ...}: {
  programs.ghostty = with config.colorScheme.colors; {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 11;

      background-opacity = 0.9;

      background = "#${base00}";
      foreground = "#${base05}";
      selection-background = "#${base05}";
      selection-foreground = "#${base00}";
      cursor-color = "#${base05}";

      keybind = [
        "ctrl+shift+h=unbind"
        "ctrl+shift+l=unbind"
      ];

      palette = [
        "0=#${base00}"
        "1=#${base08}"
        "2=#${base0B}"
        "3=#${base0A}"
        "4=#${base0D}"
        "5=#${base0E}"
        "6=#${base0C}"
        "7=#${base05}"
        "8=#${base03}"
        "9=#${base08}"
        "10=#${base0B}"
        "11=#${base0A}"
        "12=#${base0D}"
        "13=#${base0E}"
        "14=#${base0C}"
        "15=#${base07}"
        "16=#${base09}"
        "17=#${base0F}"
        "18=#${base01}"
        "19=#${base02}"
        "20=#${base04}"
        "21=#${base06}"
      ];
    };
  };
}
