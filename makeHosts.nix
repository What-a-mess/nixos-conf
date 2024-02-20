{
  inputs
  hostname,
  username,
  nixpkgs ? inputs.nixpkgs,
  system ? "x86_64-linux",
  pkgs ? inputs.nixpkgs.legacyPackages.${system},
  extraPkgs ? {},
  extraModules ? []
}:
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
      inherit inputs self username hostname extraPkgs;
  };
  modules = (builtins.attrValues self.nixosModules.default) ++ [
      inputs.home-manager.nixosModules.home-manager {
          home-manager = {
              # useGlobalPkgs = true;
              # useUserPackages = true;
              extraSpecialArgs = {
                  inherit pkgs extraPkgs;
              };
              users.${username} = import ../home-manager/hm-module.nix;
          };
      }
  ] ++
  extraModules;
};