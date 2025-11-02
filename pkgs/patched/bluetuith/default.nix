{ bluetuith, ... }:
bluetuith.overrideAttrs {
  # custom patch to allow bluetuith to work by leveraging rfkill to unblock
  patches = [ ./rfkill.patch ];
}
