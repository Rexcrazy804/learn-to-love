{
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
}
