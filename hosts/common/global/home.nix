{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./display-managers/hyprland/hyprland-home.nix
    #./display-managers/gnome-home.nix

    ./programs/neovim
    ./programs/neovide.nix
    ./programs/kitty.nix
  ];

  home.packages = with pkgs; [ ];

  programs = {
    vscode = {
      enable = true;
    };

    git = {
      enable = true;
      settings.user.name = "MatheusLOliveira";
    };

    # starship - an customizable prompt for any shell
    starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };
  };

  home.file.".zen/7wd9f9n5.default/chrome".source = ./configs/zen/chrome;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
