{
  symlinkJoin,
  love,
  makeWrapper,
  gameFiles,
}:
symlinkJoin {
  pname = "love-game";
  version = "0.1";

  paths = [love];
  buildInputs = [makeWrapper];

  postBuild = ''
    cp -r ${gameFiles} $out/game
    wrapProgram $out/bin/love \
      --add-flags "$out/game"
  '';

  meta.mainProgram = "love";
}
