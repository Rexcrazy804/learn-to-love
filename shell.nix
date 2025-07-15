{
  sources ? import ./npins,
  pkgs ? import sources.nixpkgs {},
}: let
  inherit (pkgs) mkShell love;
  inherit (pkgs.lib) makeSearchPath attrValues;

  LUACATS_LIB = makeSearchPath "library" [
    (sources.lc-love2d {inherit pkgs;})
  ];
in
  mkShell {
    buildInputs = [love];
    inherit LUACATS_LIB;
  }
