{ lib, pkgs, config, extraPkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pkgs.pciutils
  ];
}