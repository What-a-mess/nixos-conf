{ pkgs, extraPkgs, ... }:

{
  imports = [
    ./git.nix
  ];

  home.packages = with pkgs; [
    zip
    unzip
    # clash-verge
  ];
}
