{
  description = "A simple NixOS flake";

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
      zen-browser,
      ...
    }
    @inputs: {
    nixosConfigurations = {
      math = nixpkgs.lib.nixosSystem { # Same name as networking.hostName
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # Passa os inputs para dentro do config
        modules = [
          ./hosts/default/configuration.nix # Importa sua config antiga
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
