{
  description = "Nixos config flake";

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    xdg-desktop-portal-termfilepickers.url = "github:guekka/xdg-desktop-portal-termfilepickers";
    nxchad = {
      url = "github:fmway/nxchad";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixvim.follows = "nixvim";
        flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
        fmway-modules.url = "github:fmway/modules";
      };
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
    hyprland.url = "github:hyprwm/Hyprland";
    HyprQuickFrame = {
      url = "github:Ronin-CK/HyprQuickFrame";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { ... }@inputs:
    let
      myLib = import ./lib/default.nix { inherit inputs; };
    in
    with myLib;
    {
      nixosConfigurations = {
        laptop = mkSystem ./hosts/laptop/configuration.nix;
        laptop2 = mkSystem ./hosts/laptop2/configuration.nix;
        desktop = mkSystem ./hosts/desktop/configuration.nix;
      };

      homeConfiguration = {
        "nixos@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;
        "nixos@laptop2" = mkHome "x86_64-linux" ./hosts/laptop2/home.nix;
        "nixos@desktop" = mkHome "x86_64-linux" ./hosts/desktop/home.nix;
      };
      nixosModules.default = ./system;
      homeManagerModules.default = ./home;
    };
}
