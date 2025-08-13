{
  description = "homemanager flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {nixpkgs, home-manager, zen-browser, ...} @ inputs: {
    specialArgs = { inherit inputs; };
    home-manager.extraSpecialArgs = { inherit inputs; };
    homeConfigurations = 
    let system = "x86_64-linux";
    in
    {
      "cardamom" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { 
	    inherit inputs; 
            inherit system;
        };
        pkgs = import nixpkgs { inherit system; };
        modules = [ 
          ./home.nix 
        ];
      };
    };
  };
}
