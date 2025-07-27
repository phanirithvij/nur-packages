{ bluetuith, ... }:
bluetuith.overrideAttrs {
  patches = [ ./rfkill.patch ];
}
