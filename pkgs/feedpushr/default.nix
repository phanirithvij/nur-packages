{ callPackage, ... }:
callPackage ./package.nix {
  goagen_1 = callPackage ../goagen_1 { };
}
