{
  descdescription = "Nixos configuration flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }: @inputs{
    nixosConfigurations.mySystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs - {inherit inputs;};
      modules = [
        inputs.disko.nixosModules.default
        (import ./disko.nix { device = "/dev/sda"; })
        ./configuration.nix
      ];
    };
  };
}