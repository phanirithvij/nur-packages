{ gitbatch, fetchpatch2, ... }:
gitbatch.overrideAttrs (_: {
  patches = [
    # https://github.com/isacikgoz/gitbatch/compare/master...leilee:master
    (fetchpatch2 {
      url = "https://github.com/leilee/gitbatch/commit/54bb38b5825736e1d822b2f6816ef849ab18f840.patch?full_index=1";
      hash = "sha256-TH3Y0qbP+1tQloWTu3pCydXONNUw/WVyaYCtruIcFeI=";
    })
  ];
})
