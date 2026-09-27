{
  navi,
  fetchFromGitHub,
  rustPlatform,
}:
navi.overrideAttrs (
  old:
  let
    pname = "navi";
    version = "2.25.0-beta1-unstable-2026-09-20";
    src = fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "7389f9544b9cbbf845acadb96c1b18a13ca988c4";
      hash = "sha256-S96wlpemaw3CnNVlaNUfYAUM0oqDMli9M/Or3fjBf74=";
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
