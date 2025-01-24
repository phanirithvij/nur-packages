# upd-all.sh manages the hash
# https://github.com/gvolpe/nix-config/blob/3d2744a4d663d30f1b0b4014917f8d51b006f053/lib/overlays.nix#L87
{
  system ? "x86_64-linux",
}:
(builtins.getFlake "github:DeterminateSystems/nix-src/5ba138e76f42c9f6b470fb6b04323ded4bd9ff05")
.packages.${system}.nix.overrideAttrs
  (old: {
    doCheck = false;
    doInstallCheck = false;
    postInstall =
      old.postInstall
      + ''
        rm $out/bin/nix-*
        mv $out/bin/nix $out/bin/nix-schema
      '';
  })
