# upd-all.sh manages the hash
# https://github.com/gvolpe/nix-config/blob/3d2744a4d663d30f1b0b4014917f8d51b006f053/lib/overlays.nix#L87
(builtins.getFlake "github:DeterminateSystems/nix-src/e1ed2d111bd21724f28ebb80aedd5154d4979fa9")
.packages."x86_64-linux".nix.overrideAttrs
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
