{ lib, config, ... }: {
  hardware.bluetooth.enable = false;

  security.rtkit.enable = config.services.pipewire.enable;

  # Pipewire
  hardware.pulseaudio.enable = false; # false in pipewire

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };
}