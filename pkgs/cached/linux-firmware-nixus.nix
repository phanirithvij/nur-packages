{
  stdenv,
  linux-firmware,
  compressFirmwareZstd,
}:
stdenv.mkDerivation {
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  name = "linux-firmware-filtered-nixus";
  src = compressFirmwareZstd linux-firmware; # can get this from official nixos cache
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
