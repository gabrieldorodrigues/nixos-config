{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.1.0";
  };

  outputs = { self, home-manager, nix-flatpak, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in 
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem{
        specialArgs = {
      inherit inputs;
      inherit pkgs-unstable;
    };
        modules = [
          ./configuration.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
        ];
      };
    };
}