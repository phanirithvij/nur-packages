{
  stdenv,
  fetchFromGitLab,
  linux-firmware,
  compressFirmwareZstd,
}:
let
  linux-firmware' = linux-firmware.overrideAttrs (oldAttrs: rec {
    version = "20260519";
    src = fetchFromGitLab {
      owner = "kernel-firmware";
      repo = "linux-firmware";
      tag = version;
      hash = "sha256-vyrnHNnyNko7m/fZ3fXgLvvasYyJ/pzs5be/Ele+6vY=";
    };
  });
in
stdenv.mkDerivation {
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  name = "linux-firmware-filtered-nixus";
  src = compressFirmwareZstd linux-firmware';
  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib/firmware
    pushd $src/lib/firmware || exit 1
    files=(
      amdgpu/green_sardine*
      mediatek/*MT7961*_1[_.]*
    )
    cp --no-preserve=mode --parents ''${files[@]} $out/lib/firmware
    chmod -w -R $out/lib/firmware
    popd || exit 1
    runHook postInstall
  '';
}
