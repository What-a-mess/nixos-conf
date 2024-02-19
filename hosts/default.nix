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
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = {
                        inherit extraPkgs;
                    };
                    users.${username} = import ../home-manager/hm-module.nix;
                };
            }
        ] ++
        extraModules;
    };
in {
    wamess-dekstop = let 
        pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
        };
        extraPkgs = if builtins.hasAttr "extraNixpkgs" self then 
            builtins.mapAttrs (name: extraNixpkg: import extraNixpkg {
                system = "x86_64-linux";
                config.allowUnfree = true;
            }) self.extraNixpkgs else {};
    in mkHost {
        hostname = "wamess-dekstop";
        username = "wamess";
        extraModules = [ ./wamess-desktop ];
        inherit pkgs extraPkgs;
    };
    wamess-test-vm = let 
        pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
        };
        extraPkgs = if builtins.hasAttr "extraNixpkgs" self then 
            builtins.mapAttrs (name: extraNixpkg: import extraNixpkg {
                system = "x86_64-linux";
                config.allowUnfree = true;
            }) self.extraNixpkgs else {};
    in mkHost {
        hostname = "wamess-test-vm";
        username = "wamess";
        extraModules = [ ./wamess-test-vm ];
        inherit pkgs extraPkgs;
    };
}