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
  version = "0.5.0-unstable-2025-07-28";

  src = fetchFromGitHub {
    owner = "Cretezy";
    repo = "lazyjj";
    rev = "584ccaf2e470fe534ab5863e7f9282cd40be1767";
    hash = "sha256-tTa34TeCXhJTy//SIisVqt2bfaGzNKho+AumHEXyzJ0=";
  };

  cargoHash = "sha256-ytoSLy3HfG2rxpvXm9p2tQijPqO1lmto4eZQFgcpKL0=";

  patches = [
    # temporary breakage
    # https://github.com/NixOS/nixpkgs/issues/370890
    (fetchpatch2 {
      url = "https://github.com/Cretezy/lazyjj/pull/159.patch?full_index=1";
      hash = "sha256-HUyZzIaG7hR50zhY9t53Tzt+gMgJJYwLEQL3bpj/eKM=";
    })
  ];

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
