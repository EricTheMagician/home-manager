{
  description = "Home Manager (dotfiles) and NixOS configurations";

  inputs =
    {
      nixpkgs.url = "github:NixOS/nixpkgs";
      #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
      # nixpkgs-unstable.url = "github:NixOS/nixpkgs";

      #   nurpkgs = {
      #     url = "github:nix-community/NUR";
      #     inputs.nixpkgs.follows = "nixpkgs";
      #   };

      home-manager = {
        url = "github:nix-community/home-manager/release-23.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

    };

  outputs =
    { self
    , nixpkgs
    , home-manager
    ,
    }:
    let
      username = "eric";
      homeDirectory = "/home/${username}";
      configHome = "${homeDirectory}/.config";

      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.xdg.configHome = configHome;
      };

      # unstable = import nixpkgs-unstable {
      # inherit system;
      #  config.allowUnfree = true;
      #  config.xdg.configHome = configHome;
      # };

    in
    {
      formatter.x86_64-linux = pkgs.nixpkgs-fmt;


      homeConfigurations.eric = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        # unstable = nixpkgs-unstable;

        modules = [
          ./home.nix
          {
            home = {
              username = username;
              homeDirectory = homeDirectory;
              # stateVersion = "23.05";
            };
          }
        ];
      };

    };
}

