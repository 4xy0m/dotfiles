{
  pkgs,
  inputs,
  myLib,
  config,
  outputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  options.myNixOS.home-manager = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        userConfig = lib.mkOption {};
        userSettings = lib.mkOption {};
      };
    });
  };
  config = {
    programs.hyprland.enable = true;
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    users.users.nixos = {
      isNormalUser = true;
      extraGroups = ["audio" "wheel"]; # Enable ‘sudo’ for the user.
    };

    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
        inherit myLib;
        outputs = inputs.self.outputs;
      };
      users =
        builtins.mapAttrs (name: user: {...}: {
          imports = [
            (import user.userConfig)
            outputs.homeManagerModules.default
          ];
        })
        (config.myNixOS.home-manager);
    };
  };
}
