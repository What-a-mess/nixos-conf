{
  lib,
  config,
  username,
  ...
}: {
  users = {};
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel" 
      "audio" 
      "video"
      "networkmanager"
    ]
    ++ lib.optionals config.virtualisation.lxd.enable [ "lxd" ]
    ++ lib.optionals config.virtualisation.docker.enable [ "docker" ]
    ++ lib.optionals config.virtualisation.podman.enable [ "podman" ]
    ++ lib.optionals config.virtualisation.libvirtd.enable [ "libvirtd" ]
    ++ lib.optionals config.virtualisation.virtualbox.host.enable ["vboxusers"]
    ++ lib.optionals config.programs.adb.enable [ "adbusers" ];
  };
}