{
  config,
  inputs,
  ...
}: {
  programs.waybar = with config.colorScheme.palette; {
    style = ''
      * {
        border: none;
        border-radius: 0px;
        font-family: JetBrainsMono Nerd Font;
        font-size: 12.5px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(${
        inputs.nix-colors.lib.conversions.hexToRGBString "," base01
      }, 0.5);
      }

      #custom-launcher {
        background-color: #${base02};
        color: #${base07};
        border-radius: 0px 20px 20px 0px;
        padding: 0px 30px 0px 15px;
        margin: 0px;
        font-size: 22px;
      }

      #workspaces {
        background-color: #${base02};
        color: #${base02};
        margin: 4px 4px;
        padding: 4px 2px;
        border-radius: 16px;
      }

      #workspaces button {
        background-color: #${base01};
        color: #${base04};
        padding: 0px 10px;
        margin: 0px 4px;
        border-radius: 16px;
        min-width: 20px;
        transition: all 0.2s ease-in-out;
      }

      #workspaces button.active {
        background-color: #${base07};
        color: #${base02};
        border-radius: 16px;
        min-width: 35px;
        background-size: 400% 400%;
        transition: all 0.2s ease-in-out;
      }

      #workspaces button:hover {
        background-color: #${base04};
        color: #${base02};
        border-radius: 16px;
        min-width: 35px;
        background-size: 400% 400%;
      }

      #clock {
        background-color: #${base02};
        color: #${base05};
        border-radius: 20px 0px 0px 20px;
        padding: 2px 15px 2px 20px;
        margin-left: 7px;
        font-weight: bold;
      }

      #custom-notifications {
        background-color: #${base00};
        color: #${base04};
        padding-left: 4px;
        padding-right: 14px;
        font-weight: bold;
      }

      #privacy, #cpu, #memory, #tray, #backlight, #pulseaudio, #network, #battery {
        background-color: #${base02};
        color: #${base05};
        margin: 4px 0px;
        margin-left: 7px;
        border-radius: 16px;
        padding: 0px 16px;
        font-weight: bold;
      }

      tooltip {
        background-color: #${base00};
        font-size: 22px;
      }
    '';
  };
}
