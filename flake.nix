{
  description = "A devShell for Lua";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (
        system:
          f (import nixpkgs {inherit system;})
      );
  in {
    packages = forAllSystems (pkgs: rec {
      # lua cats completion for love2d
      love2dLC = pkgs.callPackage ./nix/lucats-love2d.nix {};
      game = pkgs.callPackage ./nix/love-game.nix {
        src = "${self}/src";
      };
      default = game;
    });
    devShells = forAllSystems (pkgs: let
      self' = self.packages.${pkgs.system};
    in {
      default = pkgs.mkShell {
        buildInputs = [pkgs.love];
        LUACATS_LIB = builtins.concatStringsSep ":" [
          "${self'.love2dLC}/Library"
        ];
      };
    });
  };
}
