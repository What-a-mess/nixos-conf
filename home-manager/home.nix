{ pkgs, ... }:

{
  imports = [
    ./core
    ./browsers
    ./gui/shell/kitty
    ./gui/desktop/wm/hyprland
    ./gui/input/fcitx5.nix
    # ./misc
    ./tui
  ];

  home = {
    username = "wamess";
    homeDirectory = "/home/wamess";
    stateVersion = "24.11";
  };
}
