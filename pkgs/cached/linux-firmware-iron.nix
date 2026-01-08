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
  name = "linux-firmware-filtered-iron";
  src = compressFirmwareZstd linux-firmware; # can get this from official nixos cache
  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib/firmware
    pushd $src/lib/firmware || exit 1
    files=(
      iwlwifi-7265D-29.ucode*
      i915/kbl_dmc_ver1_04.bin*
      intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq*
      intel/ibt-hw-37.8.bseq*
    )
    cp --no-preserve=mode --parents ''${files[@]} $out/lib/firmware
    chmod -w -R $out/lib/firmware
    popd || exit 1
    runHook postInstall
  '';
}
