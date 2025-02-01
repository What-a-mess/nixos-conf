{ lib, pkgs, config, extraPkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pciutils
    dig
  ];
}