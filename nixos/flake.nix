{
  description = "chanq-io NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Apps that aren't in nixpkgs. Each provides a package per system;
    # threaded into home-manager via extraSpecialArgs and consumed in
    # modules/home/gui-apps.nix. Left unfollowed on nixpkgs so they keep
    # whatever version their authors pinned.
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
    betterbird.url = "github:Heehaaw/betterbird-flake";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.shrike = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/shrike
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.cardamom = import ./modules/home;
        }
      ];
    };
  };
}
