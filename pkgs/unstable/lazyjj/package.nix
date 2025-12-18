{
  lib,
  fetchFromGitHub,
  fetchpatch2,
  makeWrapper,
  jujutsu,
  rustPlatform,
  testers,
  lazyjj,
}:
rustPlatform.buildRustPackage {
  pname = "lazyjj";
  version = "0.6.1-unstable-2025-12-15";

  src = fetchFromGitHub {
    owner = "Cretezy";
    repo = "lazyjj";
    rev = "f4b436f68295b223b9c1ece233d06073657e37a2";
    hash = "sha256-bMDaceUKVg4m2Bk9eq7/rEvwbrv8W/ilewClPTFzh+A=";
  };

  cargoHash = "sha256-mRq8Cu9LP4JJbBUEs6iyUX5OP31QLFnPgFYdsCVpdDk=";

  cargoPatches = [
    # TODO patch should be in nixpkgs, will not be merged upstream
    # https://github.com/Cretezy/lazyjj/pull/117#issuecomment-3110844786
    (fetchpatch2 {
      url = "https://github.com/Cretezy/lazyjj/pull/117.patch?full_index=1";
      hash = "sha256-fjH0PPu0+GpHdc+iR6aXMBm4TF5khuLJ1MViNNaEHcU=";
    })
  ];

  postInstall = ''
    wrapProgram $out/bin/lazyjj \
      --prefix PATH : ${lib.makeBinPath [ jujutsu ]}
  '';

  nativeBuildInputs = [ makeWrapper ];

  nativeCheckInputs = [ jujutsu ];

  passthru.tests.version = testers.testVersion { package = lazyjj; };

  meta = {
    description = "TUI for Jujutsu/jj";
    homepage = "https://github.com/Cretezy/lazyjj";
    mainProgram = "lazyjj";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ colemickens ];
  };
}
