{ lib, ... }:

{
  virtualisation.vmware.guest.enable = true;
  environment.sessionVariables = {
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}