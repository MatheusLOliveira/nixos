# # https://nixos.wiki/wiki/GNOME
{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Enable the GNOME Desktop Environment.
  services = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;

    xserver.enable = true; # Enable the X11 windowing system.
  };
  # https://hugosum.com/blog/customizing-gnome-with-nix-and-home-manager
  # debloat gnome:
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-shell-extensions

    baobab # disk usage analyzer
    #cheese # photo booth
    eog # image viewer
    epiphany # web browser
    # gedit # text editor
    # simple-scan # document scanner
    # totem # video player
    yelp # help viewer
    evince # document viewer
    file-roller # archive manager
    geary # email client
    seahorse # password manager

    # these should be self explanatory
    # gnome-calculator
    # gnome-calendar
    gnome-characters
    # gnome-clocks
    # gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    # gnome-music
    gnome-photos
    gnome-screenshot
    # gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    # pkgs.gnome-connections
  ];

  programs.dconf.enable = true;
}
