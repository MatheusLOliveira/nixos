{ config, pkgs, inputs, ... }: # <--- Adicione 'inputs' aqui!

{
  imports = [
    ./hardware-configuration.nix
    ../common/global
  ];

  # ... Suas configs de boot, rede, timezone ...

  # Configuração do Home Manager (Movemos do flake para cá)
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    # Ajuste o caminho do import conforme onde você deixou o arquivo
    users.matheus = import ../../home.nix; 
  };

  #########
  ## GPU ##
  #########

  hardware.graphics = {
  	enable = true;
	enable32Bit = true;
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
}
