{
  navi,
  fetchFromGitHub,
  rustPlatform,
}:
navi.overrideAttrs (
  old:
  let
    pname = "navi";
    version = "2.25.0-beta1-unstable-2026-07-28";
    src = fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "f7330b9ad5bd95b7d1a3c96d00e0a77deb589147";
      hash = "sha256-JA7Bh8VhPhUPWgPH0KQIBpoyaQ3y2TzGZ+tt3C4YR2A=";
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
