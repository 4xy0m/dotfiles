{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nxchad.url = "github:fmway/nxchad";
    nxchad.inputs.nixpkgs.follows = "nixpkgs";
    llm-agents.url = "github:numtide/llm-agents.nix";
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
