{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zip
    unzip
    #vscode
    clash-verge
  ];
}
