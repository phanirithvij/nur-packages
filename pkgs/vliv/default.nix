{
  lib,
  callPackage,

  vliv, # self
}:
let
  base = callPackage ./base.nix { inherit vliv; };
  default = base.withPlugins (
    pl: with pl; [
      internal
      lyapunov
      newton
      debug
    ]
  );
  full = base.withPlugins (pl: lib.attrValues pl);
  # TODO binary direct download from releases
  bin = { };
in
{
  inherit base default full;
}
