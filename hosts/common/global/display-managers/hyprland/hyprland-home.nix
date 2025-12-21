{ pkgs, ... }:
{
  # Habilita o módulo do Hyprland no Home Manager
  wayland.windowManager.hyprland = {
    enable = true;

    # Isso injeta o conteúdo do seu hyprland.conf dentro da config gerada pelo Nix
    extraConfig = builtins.readFile ./hypr/hypr/hyprland.conf;
    #settings = {
    #  binde = [
    #    ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
    #    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    #  ];
    #
    #  bind = [
    #    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    #  ];
    #};
  };

  #configFile"destiny".source = "where_is_the_file"
  #xdg.configFile."wofi".source = ./hypr/wofi;
  xdg.configFile = {
    #"hypr".source = ./hypr/hypr;

    "hypr/hyprlock.conf".source = ./hypr/hypr/hyprlock.conf;
    "hypr/scripts".source = ./hypr/hypr/scripts;
    "hypr/configs".source = ./hypr/hypr/configs;

    "waybar".source = ./hypr/waybar;
    "rofi".source = ./hypr/rofi;
    "swaync".source = ./hypr/swaync;
  };

  # Exemplo se você tiver uma pasta de scripts dentro de hypr:
  # xdg.configFile."hypr/scripts".source = ./hypr/scripts;

  # Pacotes extras que o Hyprland pode precisar e você usa na config
  home.packages = with pkgs; [
    hyprlock
    hypridle
    #hyprpaper
    #wofi
    rofi
    waybar
    nautilus
    loupe
    pamixer
    playerctl # Music on waybar

    wl-clipboard # Essencial para copiar/colar
    swaynotificationcenter # Central de notificações
    hyprshot # Para prints
    nwg-look # Para configurar temas GTK visualmente
    stow # Pode manter se ainda usar para outras coisas fora do Nix

    # Agentes de autenticação (polkit)
    hyprpolkitagent # Ou outro como polkit-gnome / lxsession

    # --- Tema Catppuccin (com a configuração que você tinha) ---
    (catppuccin-gtk.override {
      accents = [ "blue" ];
      variant = "mocha";
    })

    # Ícones e Cursores (opcionais, mas recomendados já que você instalou o tema)
    catppuccin-cursors.mochaBlue
    papirus-icon-theme
  ];
}
