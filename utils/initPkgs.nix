{
  nixpkgs,
  system ? "x86_64-linux",
  extraNixpkgs ? {},
  nur ? null,
  allowUnfree ? true,
  overlays ? []
}: let
  lib = nixpkgs.lib;
in rec
 {
  pkgs = import nixpkgs {
    inherit system overlays;
    config = {
      allowUnfree = allowUnfree;
    };
  };
  extraPkgs = 
    builtins.mapAttrs (
      name: extraNixpkg: import extraNixpkg {
        inherit system overlays;
        config.allowUnfree = allowUnfree;
      }
    ) extraNixpkgs // lib.attrsets.optionalAttrs nur != null {
      nurNoPkgs = import nur {
        nurpkgs = pkgs;
      };
    };
}