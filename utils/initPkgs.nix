{
  nixpkgs,
  system ? "x86_64-linux",
  extraNixpkgs ? {},
  nur ? null,
  allowUnfree ? true,
  overlauys ? []
}: let
  lib = nixpkgs.lib;
in
 {
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = allowUnfree;
  };
  extraPkgs = lib.mkMerge [ 
    builtins.mapAttrs (
      name: extraNixpkg: import extraNixpkg {
        inherit system;
        config.allowUnfree = allowUnfree;
      }
    ) extraNixpkgs
    lib.mkIf (extraNixpkgs != null) {
      nurNoPkgs = import nur {
        nurpkgs = pkgs;
      }
    }
  ];
}