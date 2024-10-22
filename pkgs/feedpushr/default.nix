{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (pkgs) callPackage;
in
callPackage ./package.nix {
  goagen_1 = callPackage ../goagen_1 { };
}
