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
  version = "0.5.0-unstable-2025-07-07";

  src = fetchFromGitHub {
    owner = "Cretezy";
    repo = "lazyjj";
    rev = "09489dca9c51c22d4d8a83cdc37897ef65618fb0";
    hash = "sha256-4VjMbQKCdEWRN/5rGwPfKvfUc9wPFfiXbkqzmVqszpM=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-fL6tPZ6NRcjVOTUnrVze7xGDudKMmc0d3jvwYshduHM=";

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
