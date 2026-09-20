{
  description = "My NixOS Flake Configuration";

  inputs = {
    # NixOS official package source, using the 26.05 branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home Manager, using the matching 26.05 branch
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword ensures Home Manager uses the same version of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # nixos version of neovim
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs: {
    nixosConfigurations = {
      # "nixos" is your hostname. If you change your hostname, change this too!
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          
          # Make home-manager a module of nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            # Pass inputs to home-manager modules if needed
            home-manager.extraSpecialArgs = { inherit inputs; };
            
            # Define your user's home-manager configuration
            home-manager.users.vkolli = {
                imports = [ 
                    ./home.nix 
                    nixvim.homeManagerModules.nixvim
                ];
            };
          }
        ];
      };
    };
  };
}
