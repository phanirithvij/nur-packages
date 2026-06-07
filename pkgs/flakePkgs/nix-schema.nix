# upd-all.sh manages the hash
# https://github.com/gvolpe/nix-config/blob/3d2744a4d663d30f1b0b4014917f8d51b006f053/lib/overlays.nix#L87
{
  stdenv,
}:
let
  flake = builtins.getFlake "github:DeterminateSystems/nix-src/0efc31ddccfb9670eda169c215595cd65b666962";
  # TODO, withAWS = false;
  pkg = flake.packages.${stdenv.hostPlatform.system}.nix;
in
pkg.overrideAttrs (o: {
  doCheck = false;
  doInstallCheck = false;
  # should be postInstall but likely nix drv installphase is not running hooks?
  installPhase = (o.installPhase or "") + ''
    rm $out/bin/nix-*
    mv $out/bin/nix $out/bin/nix-schema
  '';
  # TODO enable-later
  # see https://discord.com/channels/568306982717751326/570351733780381697/1358729732241489971
  meta.broken = false; # Manually marking it broken because it messes up my system nix
})
