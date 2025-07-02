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
  version = "0.5.0-unstable-2025-06-22";

  src = fetchFromGitHub {
    owner = "Cretezy";
    repo = "lazyjj";
    rev = "b69039c5f4908f45ff3acb69fe6c0c919712aba7";
    hash = "sha256-M6S3F0n5UATeiJdFRsG9ud7sz/OsaFVjEuBpRJm8Me8=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-1gaOUL+7PjleKMoEQ8ioVjT0thhX5Qe99QXYbOmXFiQ=";

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
