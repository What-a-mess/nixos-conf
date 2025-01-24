{config, pkgs, ...}: {
  imports = [
    ../utils/waybar
    ../utils/wofi.nix
    ../utils/mako.nix
    ../utils/wl-clipboard.nix
  ];
  home.packages = with pkgs; [
    hyprpaper
  ];

  # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr" = {
    source = ./conf;
    recursive = true;
  };
}
