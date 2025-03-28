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
    love2d = {
      stdenv,
      fetchFromGitHub,
    }:
      stdenv.mkDerivation {
        name = "LuaCats-love2d";
        src = fetchFromGitHub {
          owner = "LuaCats";
          repo = "love2d";
          rev = "765abafe49775ba52937430e2546dfc330381d6b";
          hash = "sha256-IRG/v8NcelqXWKovXm8d5YAAkCUb+6WvgmioaSUso/c=";
        };

        installPhase = ''
          mkdir $out
          cp -r $src/library $out
        '';
      };
  in {
    packages = forAllSystems (pkgs: {
      default = pkgs.callPackage love2d {};
    });
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.love
        ];
      };
    });
  };
}
