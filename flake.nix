{
  description = "My NixOS config";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      # replace official cache with a mirror located in China
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];

    # nix community's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager.url = "github:nix-community/home-manager/release-23.05";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";
    # nur.url = "github:nix-community/NUR";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
  rec {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'

    # nixosConfigurations = {
    #   wamess-dekstop = nixpkgs.lib.nixosSystem rec {
    #     system = "x86_64-linux";
    #     pkgs = pkgsSet.x86_64-linux.pkgs;
    #     specialArgs = {
    #       inherit inputs self;
    #       username = "wamess";
    #       hostname = "wamess-desktop";
    #       extraPkgs = pkgsSet.x86_64-linux.extraPkgs;
    #       lib = nixpkgs.lib;
    #     };
    #     modules = (builtins.attrValues nixosModules) ++ [
    #         home-manager.nixosModules.home-manager {
    #           home-manager = {
    #             # useGlobalPkgs = true;
    #             # useUserPackages = true;
    #             extraSpecialArgs = {
    #                 inherit pkgs;
    #                 extraPkgs = specialArgs.extraPkgs;
    #             };
    #             users.wamess = import ./home-manager/home.nix;
    #           };
    #         }
    #         ./hosts/wamess-desktop
    #         # ./nixos/desktop/kde.nix
    #         ./nixos/desktop/hyprland.nix
    #       ];
    #   };
    #   wamess-test-vm = nixpkgs.lib.nixosSystem rec {
    #     system = "x86_64-linux";
    #     pkgs = pkgsSet.x86_64-linux.pkgs;
    #     specialArgs = {
    #       inherit inputs self;
    #       username = "wamess";
    #       hostname = "wamess-test-vm";
    #       extraPkgs = pkgsSet.x86_64-linux.extraPkgs;
    #     };
    #     modules = (builtins.attrValues nixosModules) ++ [
    #         home-manager.nixosModules.home-manager {
    #           home-manager = {
    #             # useGlobalPkgs = true;
    #             # useUserPackages = true;
    #             extraSpecialArgs = {
    #                 inherit pkgs;
    #                 extraPkgs = specialArgs.extraPkgs;
    #             };
    #             users.wamess = import ./home-manager/home.nix;
    #           };
    #         }
    #         # ./nixos/mods/clash-verge.nix
    #         ./hosts/wamess-test-vm
    #         # ./nixos/desktop/kde.nix
    #         ./nixos/desktop/hyprland.nix
    #       ];
    #   };
    # };

    nixosConfigurations = import ./hosts {
      inherit inputs self;
    };
  };
}
