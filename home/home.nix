{ pkgs, ... }:

{
  imports = [
    ./browsers
    ./commonapps
    ./shell/kitty
    ./desktop/hyprland
    ./input/fcitx5.nix
  ];

  home = {
    username = "wamess";
    homeDirectory = "/home/wamess";
    stateVersion = "23.05";
  };
}
