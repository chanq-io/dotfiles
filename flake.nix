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
        nixgl.inputs.nixpkgs.follows = "nixpkgs";
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
                overlays = [ nixgl.overlay or nixgl.overlays.default ];
                config.allowUnfree = true;
            };
      modules = [ 
        ./home.nix 
      ];
    };
  };
}
