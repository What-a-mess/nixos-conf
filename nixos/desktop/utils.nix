{ pkgs, extraPkgs, ... }: 
{
  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
  };
}