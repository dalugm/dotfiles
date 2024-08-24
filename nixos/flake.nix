{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #zig = {
    #  url = "github:mitchellh/zig-overlay";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { nixpkgs, home-manager,  ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.dalu = import ./home.nix;
          }
        ];
      };
    };
  };
}
