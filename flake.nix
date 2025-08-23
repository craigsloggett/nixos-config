{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
    }@inputs:
    {
      nixosConfigurations = {
        xps = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [ ./hosts/xps ];
        };
      };
    };
}
