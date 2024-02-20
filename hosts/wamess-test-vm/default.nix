{ config, pkgs, lib, hostname, ... }: {
    imports = [
        ./hardware-configuration.nix
        ./virtualization.nix
    ];
    boot = {
        loader = {
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
            };
            grub = {
                enable = true;
                efiSupport = true;
                #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
                device = "nodev";
            };
        };
    };

    disabledModules = [ "programs/clash-verge.nix" ];
    programs.clash-verge = {
        enable = true;
        tunMode = true;
        autoStart = true;
        package = pkgs.clash-verge-rev;
    };

    networking = {
        hostName = hostname;
        networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    };

    time.timeZone = "Asia/Shanghai";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "zh_CN.UTF-8";
        LC_IDENTIFICATION = "zh_CN.UTF-8";
        LC_MEASUREMENT = "zh_CN.UTF-8";
        LC_MONETARY = "zh_CN.UTF-8";
        LC_NAME = "zh_CN.UTF-8";
        LC_NUMERIC = "zh_CN.UTF-8";
        LC_PAPER = "zh_CN.UTF-8";
        LC_TELEPHONE = "zh_CN.UTF-8";
        LC_TIME = "zh_CN.UTF-8";
    };
}