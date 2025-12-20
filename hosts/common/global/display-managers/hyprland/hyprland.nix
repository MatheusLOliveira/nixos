# https://wiki.nixos.org/wiki/Hyprland
{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };
  services.xserver.enable = true;
  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
}
