{ inputs, self }:
let 
    nixosModules = import ../nixos {};

    mkHost = {
        hostname,
        username ? "wamess",
        nixpkgs ? inputs.nixpkgs,
        system ? "x86_64-linux",
        pkgs ? inputs.nixpkgs.legacyPackages.${system},
        extraPkgs ? {},
        extraModules ? []
    }:
    nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
            inherit inputs username hostname extraPkgs;
        };
        modules = (builtins.attrValues nixosModules) ++ [
        # modules = [
            inputs.home-manager.nixosModules.home-manager {
                home-manager = {
                    # useGlobalPkgs = true;
                    # useUserPackages = true;
                    extraSpecialArgs = {
                        inherit pkgs extraPkgs username;
                    };
                    users.${username} = import ../home-manager/home.nix;
                };
            }
        ] ++
        extraModules;
    };

    initPkgs = {
        system ? "x86_64-linux",
        allowUnfree ? true
    }: {
        nixpkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = allowUnfree;
        };
        extraPkgs = if builtins.hasAttr "extraNixpkgs" self then 
            builtins.mapAttrs (name: extraNixpkg: import extraNixpkg {
                inherit system;
                config.allowUnfree = allowUnfree;
            }) self.extraNixpkgs else {};
    };

    forAllSystems = inputs.nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];

    overlays = import ../overlays { inherit inputs; };

    extraNixpkgs = {
      unstable = inputs.nixpkgs-unstable;
    };

    pkgsSet = forAllSystems (system: 
      import ../utils/initPkgs.nix {
          inherit system extraNixpkgs overlays;
          nixpkgs = inputs.nixpkgs;
      });

in {
    wamess-dekstop = let 
        system = "x86_64-linux";
        packages = pkgsSet.${system};
    in mkHost {
        hostname = "wamess-dekstop";
        username = "wamess";
        extraModules = [ ./wamess-desktop ../nixos/desktop/hyprland.nix ];
        pkgs = packages.pkgs;
        extraPkgs = packages.extraPkgs;
    };

    wamess-test-vm = let 
        system = "x86_64-linux";
        packages = pkgsSet.${system};
    in mkHost {
        hostname = "wamess-test-vm";
        username = "wamess";
        extraModules = [ ./wamess-test-vm ../nixos/desktop/hyprland.nix ];
        pkgs = packages.pkgs;
        extraPkgs = packages.extraPkgs;
    };
}