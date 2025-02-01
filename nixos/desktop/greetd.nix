{ pkgs, username, ... }: 
{
  # security.pam.services.greetd.kwallet.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = username;
      };
    };
  };
}