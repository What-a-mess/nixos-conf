{ lib, pkgs, config, extraPkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    nix-bash-completions
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zsh.enable = true;
}