{ pkgs, extraPkgs, ... }:

{
  imports = [
    ./git.nix
  ];

  home.packages = with pkgs; [
    zip
    unzip
    vscode
    # clash-verge
  ];
}
