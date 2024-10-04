{...}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dmps off";
          on-resume = "hyprctl dispatch dmps on";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
