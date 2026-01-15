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
  version = "0.6.1-unstable-2026-01-13";

  src = fetchFromGitHub {
    owner = "Cretezy";
    repo = "lazyjj";
    rev = "cc4053c23d67fd7f11456e98c7a34d2f0a98485e";
    hash = "sha256-IGe12tjkpaaPHJmVHVdXfVcWyBDIUjMGeWMTxqlti2c=";
  };

  cargoHash = "sha256-Wk35/xekhwR9KJIdsOhSdkmuPy5O/uvPYaiN+9gdcWU=";

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
