{ pkgs, ... }:

{
  imports = [
    ./browsers
    ./commonapps
    ./shell/kitty
    ./desktop/wm/hyprland
    ./input/fcitx5.nix
    ./misc
  ];

  home = {
    username = "wamess";
    homeDirectory = "/home/wamess";
    stateVersion = "24.11";
  };
}
