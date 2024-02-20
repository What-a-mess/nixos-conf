{
  nixpkgs,
  system ? "x86_64-linux",
  extraNixpkgs ? {},
  allowUnfree ? true,
  overlauys ? []
}: {
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = allowUnfree;
  };
  extraPkgs = builtins.mapAttrs (
    name: extraNixpkg: import extraNixpkg {
      inherit system;
      config.allowUnfree = allowUnfree;
    }
  ) extraNixpkgs;
}