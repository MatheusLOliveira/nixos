{ pkgs, lib, ... }:
{
  # Habilita o módulo do Hyprland no Home Manager
  wayland.windowManager.hyprland = {
    enable = true;

    # Isso injeta o conteúdo do seu hyprland.conf dentro da config gerada pelo Nix
    extraConfig = builtins.readFile ./hypr/hypr/hyprland.conf;

    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;
        sensitivity = -0.2;
        numlock_by_default = true;

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
          scroll_factor = 0.2;
        };
      };

      general = {
        # Espessura da borda (2 ou 3 fica elegante)
        border_size = 2;

        # Espaçamento entre janelas (Gaps) - Opcional, mas combina com o tema
        gaps_in = 5;
        gaps_out = 10;

        # A MÁGICA DAS CORES:
        # col.active: Gradiente de Azul Pastel (Ayu) para Cinza Escuro
        # 45deg: O gradiente fica na diagonal
        "col.active_border" = lib.mkForce "rgb(787C99)";

        # col.inactive: Cinza bem escuro (quase preto) para não chamar atenção
        "col.inactive_border" = lib.mkForce "rgb(1F2430)";
      };
    };
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
