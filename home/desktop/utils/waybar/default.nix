{ pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];
  home.file.".config/waybar" = {
    source = ./conf;
    recursive = true;
  };
}