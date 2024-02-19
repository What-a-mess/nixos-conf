{ inputs, self }:
let 
    mkHost = {
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
                    inherit pkgs;
                    extraSpecialArgs = {
                        inherit extraPkgs;
                    };
                    users.${username} = import ../home-manager/hm-module.nix;
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

in {
    wamess-dekstop = let 
        packages = initPkgs { system = "x86_64-linux"; };
    in mkHost {
        hostname = "wamess-dekstop";
        username = "wamess";
        extraModules = [ ./wamess-desktop ];
        pkgs = packages.nixpkgs;
        extraPkgs = packages.extraPkgs;
    };

    wamess-test-vm = let 
        packages = initPkgs { system = "x86_64-linux"; };
    in mkHost {
        hostname = "wamess-test-vm";
        username = "wamess";
        extraModules = [ ./wamess-test-vm ];
        pkgs = packages.nixpkgs;
        extraPkgs = packages.extraPkgs;
    };
}