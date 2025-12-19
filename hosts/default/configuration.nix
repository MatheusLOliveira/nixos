# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      inputs.stylix.nixosModules.stylix
    ];

  ################################
  ## Boot loader
  ################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ################################
  ## Environment
  ################################
  environment = {
    variables = {
      # fix ç
      # https://github.com/NixOS/nixpkgs/issues/239415#issuecomment-2575620570
      GTK_IM_MODULE = "cedilla";
      QT_IM_MODULE = "cedilla";
    };
  };

  ################################
  ## NIX
  ################################
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };
  nix.settings.experimental-features = [
     "nix-command"
     "flakes"
  ];
  nix.settings.trusted-users = ["root" "math"];
 
  ################################
  ## Networking
  ################################

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking = {
  	hostName = "math"; # Define your hostname.
  	networkmanager.enable = true;
  	networkmanager.dns = "none";
  	nameservers = [
  	  "1.1.1.1"
  	  "1.0.0.1"
  	  "8.8.8.8"
  	  "8.8.4.4"
  	 ];
        firewall.enable = true;
  	};

  ################################
  ## Localization
  ################################

  time.timeZone = "America/Sao_Paulo"; # Set your time zone.
  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  ################################
  ## Printing
  ################################
  
  services.printing.enable = true; # Enable CUPS to print documents.

  ################################
  ## Audio
  ################################

  services.pulseaudio.enable = false; # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  ################################
  ## Touchpad
  ################################

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  ################################
  ## GPU
  ################################

  hardware.graphics = {
     enable = true;
     enable32Bit = true;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  ################################
  ## Programs
  ################################

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.math = {
    shell = pkgs.zsh; # Define zsh as default
    isNormalUser = true;
    description = "Math";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
       "math" = import ./home.nix;
    };
  };
  
  programs = {
     firefox.enable = true;
     steam.enable = true;
     gamescope.enable = true;
     
     hyprland = {
       enable = true;
       package = inputs.hyprland.packages."${pkgs.system}".hyprland;
       xwayland.enable = true;
     };

     starship.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true; # TAB autocomplete
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Environment
    vim
    inputs.zen-browser.packages."${system}".default # O Zen Browser via Flake
    neovim
    wget
    git
    kitty
    cava
    btop
    zip
    unzip
    which
    pavucontrol
    lshw
    vlc

    # Development
    vscode

    # Games
    discord
    mangohud
    bottles
    heroic
    (steam.override {extraPkgs = p: [p.gamescope];})
    gamescope
    protontricks

    spotify

    # Hyprland
    waybar # Status bar
    wofi # Application launcher
    wl-clipboard # Clipboard functionality
    xdg-desktop-portal-hyprland # XDG Desktop Portal
    hyprpolkitagent # Polkit Agent
    swaynotificationcenter # Notification Daemon
    hyprpaper # Wallpaper
    hyprshot # Screenshots
    hyprlock # Lockscreen
    hypridle # Hibernate
    stow
    starship
    nwg-look
    bibata-cursors
    (pkgs.catppuccin-gtk.override {
    accents = [ "blue" ];
    variant = "mocha";
    })
  ];

  fonts.packages = with pkgs; [
     nerd-fonts.fira-code
     nerd-fonts.jetbrains-mono
     nerd-fonts.symbols-only
     nerd-fonts.caskaydia-cove # Versão Nerd da Cascadia Code
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = ../../../assets/backgrounds/nice-blue-background.png;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Classic";
  stylix.cursor.size = 24;
}
