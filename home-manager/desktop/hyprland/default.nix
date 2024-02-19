{config, pkgs, ...}: {
  imports = [
    ../utils/waybar
    ../utils/wofi
    ../utils/mako
    ../utils/wl-clipboard
  ];
  home.packages = with pkgs; [
    hyprpaper
    mako
  ];

  # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr" = {
    source = ./conf;
    recursive = true;
  };
}
