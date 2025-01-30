{ lib, config, ... }: {
  environment.systemPackages = with pkgs; [
    pkgs.pciutils
  ];
}