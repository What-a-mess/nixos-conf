{
  environment = import ./environment.nix;
  user = import ./user.nix;
  audio = import ./audio.nix;
  fonts = import ./fonts.nix;
  desktop = import ./desktop/kde.nix;
}