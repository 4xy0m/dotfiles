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
          on-timeout = "sh -c 'hyprctl activewindow -j | jq -e \".fullscreen > 0\" >/dev/null || loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "sh -c 'hyprctl activewindow -j | jq -e \".fullscreen > 0\" >/dev/null || hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "sh -c 'hyprctl activewindow -j | jq -e \".fullscreen > 0\" >/dev/null || systemctl suspend";
        }
      ];
    };
  };
}
