{
  description = "My Config";

  inputs = {
    # NixOS official package source, using the unstable branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    # Zen Browser package (Community Flake)
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
    zen-browser,
      ...
    }
    @inputs: {
    	# Main PC
    	nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        	system = "x86_64-linux";
		
		# specialArgs shares everything inside it to all the submodules
        	specialArgs = { inherit inputs; };
        	
		modules = [
          		./hosts/default/configuration.nix
			./hosts/desktop/default.nix
        	]
    	};
    };
}
