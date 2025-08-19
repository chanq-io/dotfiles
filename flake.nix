{
  description = "homemanager flake";
  inputs = {
    fenix.url = "github:nix-community/fenix";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixneovimplugins = {
      url = "github:NixNeovim/NixNeovimPlugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };
  outputs = {fenix, nixneovimplugins, nixpkgs, home-manager, zen-browser, ...} @ inputs: 
  let 
    system = "x86_64-linux";
  in 
  {
    homeConfigurations.cardamom = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit fenix inputs system; };
      pkgs = import nixpkgs { 
        inherit system; 
        overlays = [ nixneovimplugins.overlays.default ];
	config.allowUnfree = true;
      };
      modules = [ 
        ./home.nix 
      ];
    };
  };
}
