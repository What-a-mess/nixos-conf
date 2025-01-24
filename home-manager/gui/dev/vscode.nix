{ pkgs, extraPkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
  ];
}
