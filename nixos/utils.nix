{ lib, config, ... }: {
  environment.systemPackages = [
    pkgs.pciutils
  ];
}