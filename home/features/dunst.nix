{config, ...}: {
  services.dunst = with config.colorScheme.palette; {
    enable = true;
    settings = {
      global = {
        offset = "10x10";
        follow = "keyboard";
        separator_color = "#${base02}";
      };

      base16_low = {
        msg_urgency = "low";
        background = "#${base01}";
        foreground = "#${base0B}";
        frame_color = "#${base0B}";
      };

      base16_normal = {
        msg_urgency = "normal";
        background = "#${base01}";
        foreground = "#${base05}";
        frame_color = "#${base07}";
      };

      base16_critical = {
        msg_urgency = "critical";
        background = "#${base01}";
        foreground = "#${base05}";
        frame_color = "#${base08}";
      };
    };
  };
}
