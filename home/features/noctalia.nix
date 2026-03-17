{
  pkgs,
  config,
  inputs,
  ...
}:
{
  xdg.configFile."wallpapers/" = {
    source = ./hyprpaper/wallpapers;
    recursive = true;
  };

  home.file.".cache/noctalia/wallpapers.json".text = builtins.toJSON {
    defaultWallpaper = "${config.home.homeDirectory}/.config/wallpapers/${config.myHomeManager.wallpaper}";
  };

  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = with config.colorScheme.palette; {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

    plugins = {
      version = 2;
      sources = [
        {
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
          enabled = true;
        }
      ];
      states = {
        "privacy-indicator" = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        "kaomoji-provider" = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
    };

    pluginSettings = {
      "privacy-indicator" = {
        hideInactive = true;
        removeMargins = false;
        activeColor = "primary";
        inactiveColor = "none";
      };
    };

    settings = {
      notifications = {
        monitors = [
          (builtins.head config.myHomeManager.monitors).name
        ];
      };
      osd = {
        location = "bottom_center";
        monitors = [
          (builtins.head config.myHomeManager.monitors).name
        ];
      };
      bar = {
        monitors = [
          (builtins.head config.myHomeManager.monitors).name
        ];
        position = "top";
        density = "default";
        floating = false;
        marginVertical = 0;
        marginHorizontal = 0;
        showCapsule = true;
        capsuleOpacity = 1;
        capsuleColorKey = "none";
        showOutline = false;
        backgroundOpacity = 0.55;
        widgets = {
          left = [
            {
              id = "Launcher";
            }
            {
              id = "SystemMonitor";
              compactMode = false;
              useMonospaceFont = true;
              usePadding = true;
              showCpuUsage = true;
              showCpuTemp = true;
              showMemoryUsage = true;
              showMemoryAsPercent = true;
              showCpuFreq = false;
              showGpuTemp = false;
              showLoadAverage = false;
              showSwapUsage = false;
              showNetworkStats = false;
              showDiskUsage = false;
              showDiskUsageAsPercent = false;
              showDiskAvailable = false;
            }
            {
              id = "Tray";
              drawerEnabled = false;
            }
            { id = "NotificationHistory"; }
            {
              id = "plugin:privacy-indicator";
            }
          ];
          center = [
            { id = "Workspace"; }
          ];
          right = [
            {
              id = "Volume";
              displayMode = "alwaysShow";
            }
            {
              id = "Brightness";
              displayMode = "alwaysShow";
            }
            {
              id = "Battery";
              displayMode = "icon-always";
            }
            { id = "Clock"; }
            { id = "SessionMenu"; }
          ];
        };
      };

      ui = {
        fontDefault = "JetBrainsMono Nerd Font";
        fontDefaultScale = 1.0;
        panelBackgroundOpacity = 0.55;
        panelsAttachedToBar = true;
        tooltipsEnabled = true;
      };

      general = {
        lockScreenMonitors = [
          (builtins.head config.myHomeManager.monitors).name
        ];
        dimmerOpacity = 0.55;
        radiusRatio = 1.0;
        iRadiusRatio = 1.0;
        animationSpeed = 1.0;
        lockScreenAnimations = true;
        lockScreenBlur = 1;
      };

      colorSchemes = {
        useWallpaperColors = false;
        darkMode = true;
      };

      dock.enabled = false;

      sessionMenu = {
        countdownDuration = false;
        showHeader = false;
        showKeybinds = false;
        powerOptions = [
          {
            action = "lock";
            enabled = true;
          }
          {
            action = "suspend";
            enabled = true;
          }
          {
            action = "logout";
            enabled = true;
          }
          {
            action = "reboot";
            enabled = true;
          }
          {
            action = "shutdown";
            enabled = true;
          }
        ];
      };

      wallpaper = {
        enabled = true;
      };
    };

    colors = {
      mPrimary = "#${base0E}";
      mOnPrimary = "#${base00}";
      mSecondary = "#${base0D}";
      mOnSecondary = "#${base00}";
      mTertiary = "#${base0C}";
      mOnTertiary = "#${base00}";
      mError = "#${base08}";
      mOnError = "#${base00}";
      mSurface = "#${base01}";
      mOnSurface = "#${base05}";
      mSurfaceVariant = "#${base02}";
      mOnSurfaceVariant = "#${base04}";
      mOutline = "#${base03}";
      mShadow = "#${base00}";
      mHover = "#${base04}";
      mOnHover = "#${base00}";
    };
  };
}
