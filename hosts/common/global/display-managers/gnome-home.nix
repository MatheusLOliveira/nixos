{
  config,
  lib,
  pkgs,
  ...
}:
{
  # example: https://github.com/Electrostasy/dots/blob/c62895040a8474bba8c4d48828665cfc1791c711/profiles/system/gnome/default.nix#L123-L287
  # see options using this
  # nix-shell -p dconf-editor
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "brave"
        "kitty"
        "org.gnome.Nautilus.desktop"
        "org.gnome.TextEditor.desktop"
        "nixos-manual.desktop"
      ];
    };
    "org/gnome/shell/app-switcher" = {
      # isolate open apps by workspace
      current-workspace-only = true;
    };
    "org/gnome/shell/window-switcher" = {
      # isolate alt+tab for open apps by workspace
      current-workspace-only = true;
    };
    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
    };
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Super><Shift>s" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      # sane alt tab
      switch-applications = [ "<Super>Tab" ];
      switch-windows = [ "<Alt>Tab" ];
    };

    # "org/gnome/shell/extensions/user-theme" = {
    #   enabled = true;
    #   name = "WhiteSur-Dark-solid";
    # };
    # "org/gnome/shell/extensions/show-desktop-button" = {
    #   enabled = true;
    # };
    #
    # "org/gnome/shell/extensions/dash-to-panel" = with lib.gvariant; {
    #   # Even when we are not using multiple panels on multiple monitors,
    #   # the extension still creates them in the config, so we set the same
    #   # configuration for each (up to 2 monitors).
    #   panel-positions = builtins.toJSON (lib.genAttrs [ "0" "1" ] (x: "TOP"));
    #   panel-sizes = builtins.toJSON (lib.genAttrs [ "0" "1" ] (x: 32));
    #   panel-element-positions = builtins.toJSON (
    #     lib.genAttrs [ "0" "1" ] (x: [
    #       {
    #         element = "showAppsButton";
    #         visible = true;
    #         position = "stackedTL";
    #       }
    #       {
    #         element = "activitiesButton";
    #         visible = false;
    #         position = "stackedTL";
    #       }
    #       {
    #         element = "dateMenu";
    #         visible = true;
    #         position = "stackedTL";
    #       }
    #       {
    #         element = "leftBox";
    #         visible = true;
    #         position = "stackedTL";
    #       }
    #       {
    #         element = "taskbar";
    #         visible = true;
    #         position = "centerMonitor";
    #       }
    #       {
    #         element = "centerBox";
    #         visible = false;
    #         position = "centered";
    #       }
    #       {
    #         element = "rightBox";
    #         visible = true;
    #         position = "stackedBR";
    #       }
    #       {
    #         element = "systemMenu";
    #         visible = true;
    #         position = "stackedBR";
    #       }
    #       {
    #         element = "desktopButton";
    #         visible = false;
    #         position = "stackedBR";
    #       }
    #     ])
    #   );
    #   multi-monitors = false;
    #   show-apps-icon-file = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
    #   show-apps-icon-padding = mkInt32 4;
    #   focus-highlight-dominant = true;
    #   dot-size = mkInt32 0;
    #   appicon-padding = mkInt32 2;
    #   appicon-margin = mkInt32 0;
    #   trans-use-custom-opacity = true;
    #   trans-panel-opacity = 0.25;
    #   show-favorites = false;
    #   group-apps = false;
    #   isolate-workspaces = true;
    #   hide-overview-on-startup = true;
    #   stockgs-keep-dash = true;
    # };

  };
}
