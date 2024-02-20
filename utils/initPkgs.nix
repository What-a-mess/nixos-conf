{
  nixpkgs,
  system ? "x86_64-linux",
  extraNixpkgs ? {},
  nur ? null,
  allowUnfree ? true,
  overlauys ? []
}: let
  lib = nixpkgs.lib;
in rec
 {
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = allowUnfree;
  };
  extraPkgs = lib.mkMerge [ 
    (builtins.mapAttrs (
      name: extraNixpkg: import extraNixpkg {
        inherit system;
        config.allowUnfree = allowUnfree;
      }
    ) extraNixpkgs)
    lib.mkIf (nur != null) {
      nurNoPkgs = import nur {
        nurpkgs = pkgs;
      };
    }
  ];
}