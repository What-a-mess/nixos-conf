{ pkgs, extraPkgs, ... }:

{
  home.packages = with extraPkgs.stable; [
    zip
    unzip
    vscode
    # clash-verge
  ];
}
