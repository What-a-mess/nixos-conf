{ pkgs, hyprland, ... }: let
  hyprland-pkgs = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    ./greetd.nix
  ];

  hardware.graphics = {
    package = hyprland-pkgs.mesa.drivers;
    # driSupport32Bit = true;
    package32 = hyprland-pkgs.pkgsi686Linux.mesa.drivers;
  };

  xdg.portal = {
    enable = true;
  };

  services.xserver.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services = {

    # desktopManager.gnome.enable = true;

    displayManager = {
      defaultSession = "hyprland";
    };
  };

  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.hyprland;

    xwayland.enable = true;

    # nvidiaPatches = true;
    # enableNvidiaPatches = true;
  };

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    # XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # GTK_USE_PORTAL = "0";
    NIXOS_OZONE_WL = "1"; # for any ozone-based browser & electron apps to run on wayland
    MOZ_ENABLE_WAYLAND = "1"; # for firefox to run on wayland
    MOZ_WEBRENDER = "1";

    # nvidia configs
    # LIBVA_DRIVER_NAME = "nvidia";
    # XDG_SESSION_TYPE = "wayland";
    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_EGL_NO_MODIFIRES = "1";
  };

}
