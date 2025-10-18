{ bashmount, fetchpatch2, ... }:
bashmount.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/jamielinux/bashmount/commit/a69e2fdb7cac48a2733afc139644cb42e8b79317.patch?full_index=1";
      hash = "sha256-nJw5ZW5lkOfJv64pjYT2xz//IICsW2mMyO2FBdhwBjc=";
    })
  ];
})
