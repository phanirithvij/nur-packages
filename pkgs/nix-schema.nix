# upd-all.sh manages the hash
# https://github.com/gvolpe/nix-config/blob/3d2744a4d663d30f1b0b4014917f8d51b006f053/lib/overlays.nix#L87
{
  system ? "x86_64-linux",
}:
let
  flake = builtins.getFlake "github:DeterminateSystems/nix-src/9a4502bf3840efb259de3cc1cadaf747cc625d12";
  # TODO, withAWS = false;
  pkg = flake.packages.${system}.nix;
in
pkg.overrideAttrs (o: {
  doCheck = false;
  doInstallCheck = false;
  postInstall =
    (o.postInstall or "")
    + ''
      rm $out/bin/nix-*
      mv $out/bin/nix $out/bin/nix-schema
    '';
})
