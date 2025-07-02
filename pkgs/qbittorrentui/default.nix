{ callPackage, ... }:
callPackage ./package.nix {
  panwid = callPackage ./panwid.nix {
    orderedattrdict = callPackage ./orderedattrdict.nix { };
    raccoon = callPackage ./raccoon.nix { };
    urwid-utils = callPackage ./urwid-utils.nix { };
  };
}
