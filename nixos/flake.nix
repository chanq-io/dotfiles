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
    # Fast-moving packages pulled from unstable (claude-agent-acp).
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # claude-code direct from Anthropic's native releases. nixpkgs-unstable
    # lags 5-10 days behind upstream npm; this flake tracks within an hour.
    # Pinning to a specific build is a one-token swap to e.g. `."2.1.155"`
    # if a release ever regresses; see overlay below.
    nix-claude-code.url = "github:ryoppippi/nix-claude-code";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
    betterbird.url = "github:Heehaaw/betterbird-flake";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.shrike = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }

        # Pull fast-moving AI packages from appropriate sources.
        # claude-code: hourly-updated flake (default = latest). To pin a
        # specific build, swap `.default` for `."2.1.155"` etc.
        # claude-agent-acp: nixpkgs-unstable (slower-moving, less critical).
        { nixpkgs.overlays = let
            unstable = import inputs.nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          in [
            (final: prev: {
              claude-code = inputs.nix-claude-code.packages.${final.stdenv.hostPlatform.system}.default;
              claude-agent-acp = unstable.claude-agent-acp;
            })
          ];
        }

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
