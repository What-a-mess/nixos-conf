{ lib, config, ... }: {
  hardware.bluetooth.enable = true;

  security.rtkit.enable = config.services.pipewire.enable;

  # Pipewire
  hardware.pulseaudio.enable = lib.mkForce false; # false in pipewire

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };
}