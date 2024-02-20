{
  home-manager,
  username,
  pkgs,
  extraPkgs,
  ...
}: 
  home-manager.nixosModules.home-manager {
    home-manager = {
      # useGlobalPkgs = true;
      # useUserPackages = true;
      extraSpecialArgs = {
          inherit pkgs extraPkgs;
      };
      users.${username} = import ./home.nix;
    };
  }
