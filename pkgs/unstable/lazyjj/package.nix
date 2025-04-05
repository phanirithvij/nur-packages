{
  lib,
  fetchFromGitHub,
  makeWrapper,
  jujutsu,
  rustPlatform,
  testers,
  lazyjj,
}:
rustPlatform.buildRustPackage {
  pname = "lazyjj";
  version = "0.5.0-unstable-2025-03-14";

  src = fetchFromGitHub {
    owner = "Cretezy";
    repo = "lazyjj";
    rev = "cbae43c50484547a2f41c610c740a16b4cb1e055";
    hash = "sha256-FK4g1VBoPr2bYcbXD9zL9Muu6BGVyKH7LDGVj4JzWy0=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-rm4f8QLamtJLZ3Vag2B/SnBm7iYcR1fDPm97r8cvc/M=";

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
