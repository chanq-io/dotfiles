{
  description = "homemanager flake";
  inputs = {
    fenix.url = "github:nix-community/fenix";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:guibou/nixGL";
  };
  outputs = {
      fenix,
      nixpkgs,
      nixgl,
      home-manager,
      ...
  } @ inputs: 
  let 
    system = "x86_64-linux";
  in 
  {
    homeConfigurations.cardamom = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit fenix nixgl inputs system; };
      pkgs = import nixpkgs { 
        inherit system; 
	config.allowUnfree = true;
      };
      modules = [ 
        ./home.nix 
      ];
    };
  };
}
