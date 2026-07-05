{ keepassxc, ... }:
keepassxc.overrideAttrs (oldAttrs: {
  # Context available in issues linked in https://github.com/keepassxreboot/keepassxc/pull/13496
  # closed the PR because it was the wrong approach for everyone, but for me its great, allows autoopen and freedesktop secrets
  patches = (oldAttrs.patches or [ ]) ++ [
    ./0001-fdosecrets-allow-inactive-tabs-to-be-considered.patch
  ];
})
