{config, pkgs, ...}: {
  imports = [
    ../utils/waybar
    ../utils/wofi
  ];

  # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr" = {
    source = ./conf;
    recursive = true;
  };
}
