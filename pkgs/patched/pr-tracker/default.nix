{ pr-tracker }:
pr-tracker.overrideAttrs (_: {
  patches = [ ./pr-tracker-gh-token.patch ];
})
