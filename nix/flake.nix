{
  description = "Hurng-Chun Lee's home-manager dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."hclee" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];
      };
    };
}
