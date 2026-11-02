{
  navi,
  fetchFromGitHub,
  rustPlatform,
}:
navi.overrideAttrs (
  old:
  let
    pname = "navi";
    version = "2.25.0-beta1-unstable-2026-10-16";
    src = fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "7cc5d42b22f223bd205b85f61cc75ba6fd2c54c7";
      hash = "sha256-9irTb7fTmOf7uVOJZtsvnu7hSCdIzVjmE2JszISSxcE=";
    };
  in
  {
    inherit pname version src;
    # https://discourse.nixos.org/t/nixpkgs-overlay-for-mpd-discord-rpc-is-no-longer-working/59982/2
    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-CXUggMacJPArHYLvDDz8+Fef/eeL+TXRMqg/vybuD5c=";
    };

    patches = [
      ./0001-fix-prevent-clap-from-panicking-on-test-harness-argu.patch
    ];

    checkFlags = [
      "--skip=common::terminal::tests::test_width"
    ];
  }
)
