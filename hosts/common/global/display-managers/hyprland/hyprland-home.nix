{ pkgs, ... }: 
{
  # Habilita o módulo do Hyprland no Home Manager
  wayland.windowManager.hyprland = {
    enable = true;
    
    # Isso injeta o conteúdo do seu hyprland.conf dentro da config gerada pelo Nix
    extraConfig = builtins.readFile ./hypr/hyprland.conf;
  };

  # Para arquivos adicionais (hyprlock, scripts, cores, etc), 
  # nós usamos o xdg.configFile para colocá-los no lugar certo (~/.config/hypr/...)
  
  # Exemplo para o hyprlock:
  xdg.configFile."hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  
  # Exemplo se você tiver uma pasta de scripts dentro de hypr:
  # xdg.configFile."hypr/scripts".source = ./hypr/scripts;
  
  # Pacotes extras que o Hyprland pode precisar e você usa na config
  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprpaper
    rofi-wayland # ou wofi
    waybar
    
    wl-clipboard              # Essencial para copiar/colar
    swaynotificationcenter    # Central de notificações
    hyprshot                  # Para prints
    nwg-look                  # Para configurar temas GTK visualmente
    stow                      # Pode manter se ainda usar para outras coisas fora do Nix
    
    # Agentes de autenticação (polkit)
    hyprpolkitagent           # Ou outro como polkit-gnome / lxsession
    
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
