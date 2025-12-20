{ pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = lib.mkForce "CaskaydiaCove Nerd Font Propo";
      size = lib.mkForce 13;
    };

    settings = {
      # --- Janela e Aparência ---
      window_padding_width = 10;
      hide_window_decorations = "no";
      confirm_os_window_close = 0;
      background_opacity = lib.mkForce "0.9";

      # --- Cursor ---
      cursor_shape = "underline";
      cursor_blink_interval = 0.5;

      # --- Seleção ---
      copy_on_select = "yes";

      # --- Cores ---
      background = "#08080b";
      foreground = "#787c99";
      cursor = "#787c99";

      selection_background = "#515c7e";
      selection_foreground = "none"; # Mantém a cor original do texto

      # Cores Normais
      color0 = "#363b54";
      color1 = "#f7768e";
      color2 = "#41a6b5";
      color3 = "#e0af68";
      color4 = "#7aa2f7";
      color5 = "#bb9af7";
      color6 = "#7dcfff";
      color7 = "#787c99";

      # Cores Brilhantes
      color8 = "#363b54";
      color9 = "#f7768e";
      color10 = "#41a6b5";
      color11 = "#e0af68";
      color12 = "#7aa2f7";
      color13 = "#bb9af7";
      color14 = "#7dcfff";
      color15 = "#acb0d0";
    };

    # --- Atalhos (Baseado no seu binds.toml) ---
    keybindings = {
      # Nova Janela (Estilo OS Window, igual ao Alacritty)
      "ctrl+;" = "new_os_window";

      # Abrir Thunar (Launch em background)
      "ctrl+shift+:" = "launch --type=background thunar";

      # Scroll
      "ctrl+up" = "scroll_line_up";
      "ctrl+down" = "scroll_line_down";

      # Busca (Abre o histórico num pager para buscar)
      "ctrl+f" = "show_scrollback";
    };
  };
}
