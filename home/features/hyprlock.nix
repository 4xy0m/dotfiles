{config, ...}: {
  programs.hyprlock = with config.colorScheme.palette; {
    enable = true;
    settings = {
      background = [
        {
          path = "~/.config/wallpapers/${config.myHomeManager.wallpaper}";
          blur_passes = 1;
        }
        {
          color = "rgba(${base01}CC)";
          blur_passes = 1;
        }
      ];

      label = [
        {
          monitor = (builtins.head config.myHomeManager.monitors).name;
          text = ''cmd[update:1000] echo "<b><big> $(date +"%H:%M:%S") </big></b>"'';
          font_size = 64;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, 16";
          color = "rgb(${base05})";
          halign = "center";
          valign = "center";
        }
        {
          monitor = (builtins.head config.myHomeManager.monitors).name;
          text = ''
            Hey <span text_transform="capitalize" size="larger">$USER</span>'';
          color = "rgb(${base05})";
          font_size = 20;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, -40";
          halign = "center";
          valign = "center";
        }
        {
          monitor = (builtins.head config.myHomeManager.monitors).name;
          text = "Type to unlock !";
          color = "rgb(${base05})";
          font_size = 16;
          position = "0, 30";
          font_family = "JetBrains Mono Nerd Font 10";
          halign = "center";
          valign = "bottom";
        }
      ];

      input-field = [
        {
          monitor = (builtins.head config.myHomeManager.monitors).name;
          size = "250, 50";
          position = "0, 65";
          font_color = "rgb(${base05})";
          outer_color = "rgb(${base05})";
          inner_color = "rgb(${base00})";
          fail_color = "rgb(${base08})";
          check_color = "rgb(${base09})";
          dots_size = 0.2;
          outline_thickness = 3;
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";
          hide_input = false;
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
