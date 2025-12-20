{ config, pkgs, inputs, ... }:

{
  imports =
    [
      # make home-manager as a module of nixos
      # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
      inputs.home-manager.nixosModules.default

      ./programs/zsh.nix
      ./display-managers/hyprland/hyprland.nix
    ];

  #################
  ## Boot loader ##
  #################

  boot.loader = {
  	systemd-boot.enable = true;
  	efi.canTouchEfiVariables = true;
  };

  #################
  ## Environment ##
  #################

  environment = {
    variables = {
      # https://github.com/NixOS/nixpkgs/issues/239415#issuecomment-2575620570
      GTK_IM_MODULE = "cedilla";
      QT_IM_MODULE = "cedilla";
    };
  };

  ################
  ## Networking ##
  ################

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

  ###########
  ## Users ##
  ###########

  users.users.math = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "math";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "12345";
    packages = with pkgs; [ ];
  };
  
  ##################
  ## Home manager ##
  ##################

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    
    backupFileExtension = "hm-backup";

    users.math = import ./home.nix;
  };


  ##################
  ## Localization ##
  ##################

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

  #########
  ## NIX ##
  #########
  
  nix = { 
  	gc = {
    		automatic = true;
    		dates = "weekly";
    		options = "--delete-older-than 15d";
	};

	settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	settings.trusted-users = [
		"root" "math"
	];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/math/nixos";
  };

  ############
  ## Stylix ##
  ############

  stylix = {
  	enable = true;
	base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
	image = ../../../assets/backgrounds/nice-blue-background.png;

	cursor = {
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 23;
	};
	fonts = {
		serif = {
        	package = pkgs.dejavu_fonts;
        	name = "DejaVu Serif";
      	};

      	sansSerif = {
        	package = pkgs.dejavu_fonts;
        	name = "DejaVu Sans";
      	};

      	monospace = {
        	package = pkgs.nerd-fonts.jetbrains-mono;
        	name = "JetbrainsMono Nerd Font";
      	};
    };
  };

  ##############
  ## Keyboard ##
  ##############

  # Enable the X11 windowing system.
  services.xserver = {
  	enable = true;
	
	xkb = {
		layout = "us";
		variant = "alt-intl";
	};
  };
  console.keyMap = "br-abnt2"; # Configure console keymap


  ##############
  ## Printing ##
  ##############
  
  services.printing.enable = true; # Enable CUPS to print documents.

  ###########
  ## Audio ##
  ###########

  services.pulseaudio.enable = false; # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  ##############
  ## Programs ##
  ##############

  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs = {
     firefox.enable = true;
     steam.enable = true;
     gamescope.enable = true;
     steam.gamescopeSession.enable = true;  
  };

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
    lshw # check gpu details
    vlc
    curl
    starship

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

    (
      # This might require a restart to fully work (terminal commands runs, but it doesnt show up in the launchpad)
      symlinkJoin {
        name = "kitty";
        buildInputs = [ makeWrapper ];
        paths = [ kitty ];
        postBuild = ''
          	  wrapProgram $out/bin/kitty --append-flags "--config ${./configs/kitty.conf}"
          	'';
      }
    )
  ];

  fonts.packages = with pkgs; [
     nerd-fonts.fira-code
     nerd-fonts.jetbrains-mono
     nerd-fonts.symbols-only
     nerd-fonts.caskaydia-cove # Versão Nerd da Cascadia Code
  ];

  ############
  ## System ##
  ############

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
  };

  services = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

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
}
