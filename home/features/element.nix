{ ... }: {
  programs.element-desktop.enable = true;
  programs.element-desktop.settings = {
    default_server_config = {
      "m.homeserver" = {
        base_url = "https://matrix-client.matrix.org";
        server_name = "matrix.org";
      };
      "m.identity_server" = {
        base_url = "https://vector.im";
      };
    };
    disable_custom_urls = false;
    disable_guests = false;
    disable_login_language_selector = false;
    disable_3pid_login = false;
    force_verification = false;
    brand = "Element";
    integrations_ui_url = "https://scalar.vector.im/";
    integrations_rest_url = "https://scalar.vector.im/api";
    show_labs_settings = true;
    custom_themes = [
      {
        name = "Catppuccin Mocha (Mauve)";
        is_dark = true;
        colors = {
          accent-color = "#cba6f7";
          primary-color = "#cba6f7";
          warning-color = "#f38ba8";
          alert = "#f9e2af";
          sidebar-color = "#11111b";
          roomlist-background-color = "#181825";
          roomlist-text-color = "#cdd6f4";
          roomlist-text-secondary-color = "#9399b2";
          roomlist-highlights-color = "#45475a";
          roomlist-separator-color = "#7f849c";
          timeline-background-color = "#1e1e2e";
          timeline-text-color = "#cdd6f4";
          secondary-content = "#cdd6f4";
          tertiary-content = "#cdd6f4";
          timeline-text-secondary-color = "#a6adc8";
          timeline-highlights-color = "#181825";
          reaction-row-button-selected-bg-color = "#45475a";
          menu-selected-color = "#45475a";
          focus-bg-color = "#585b70";
          room-highlight-color = "#89dceb";
          togglesw-off-color = "#9399b2";
          other-user-pill-bg-color = "#89dceb";
          username-colors = [
            "#cba6f7"
            "#eba0ac"
            "#fab387"
            "#a6e3a1"
            "#94e2d5"
            "#89dceb"
            "#74c7ec"
            "#b4befe"
          ];
          avatar-background-colors = [
            "#89b4fa"
            "#cba6f7"
            "#a6e3a1"
          ];
        };
      }
    ];
  };
}
