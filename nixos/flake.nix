{
  description = "Aether Forge flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        aether = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            /etc/nixos/hardware-configuration.nix
          ];
        };
      };
    };
}