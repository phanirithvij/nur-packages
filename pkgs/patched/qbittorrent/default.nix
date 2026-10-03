{ qbittorrent }:
qbittorrent.overrideAttrs (_: {
  patches = [ ./0001-Reverse-sort-icons.patch ];
})
