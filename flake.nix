{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad-starter = {
      url = "path:/home/nixos/dotfiles/nvim/";
      flake = false;
    };
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "nvchad-starter";
    };
  };

  outputs = {...} @ inputs: let
    myLib = import ./lib/default.nix {inherit inputs;};
  in
    with myLib; {
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
